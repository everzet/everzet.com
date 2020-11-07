---
title: Conceptual difference between Mockery and Prophecy
date: 2014-01-11
tags: [post, tech, php, phpspec]
layout: post-layout

permalink: post/72910908762/conceptual-difference-between-mockery-and-prophecy/index.html
---

# Conceptual difference between Mockery and Prophecy

Today I’ve been asked twice what’s the difference between Mockery and Prophecy just to suddenly
discover that I didn’t clarify this aspect never before. Well, that’s about time.

If we were to remove all the syntactical and implementation differences between two libraries what
we’ll be left with is one really big conceptual difference and it’s the fact that in contradiction
to Mockery, Prophecy puts messaging (aka how objects communicate) before structure (aka when
objects communicate).

Lets consider an example:

```php
interface User
{
    public function getRating();
    public function setRating($rating);
}

class UserRatingCalculator
{
    public function increaseUserRating(User $user, $add = 1)
    {
        $user->setRating($user->getRating() + $add);
    }
}
```

Pretty simple rating calculation behaviour (though a bit artificial, I know). Now, the test with
Mockery will look something like this:

```php
$user = Mockery::mock('User');
$user->shouldReceive('getRating')->andReturn(2);
$user->shouldReceive('setRating')->with(4)->once();

$calc = new UserRatingCalculator();
$calc->increaseUserRating($user->mock(), 2);
```

And test with Prophecy will look something like this:

```php
$user = $prophet->prophesize('User');
$user->getRating()->willReturn(2);
$user->setRating(4)->shouldBeCalled();

$calc = new UserRatingCalculator();
$calc->increaseUserRating($user->reveal(), 2);
```

Except subtle differences in syntax examples look exactly the same. Now let’s ramp up things a
bit. Lets say that now we want to raise an event before and after rating change. New calculator
could look like that:

```php
class UserRatingCalculator
{
    private $dispatcher;

    public function __construct(EventDispatcher $dispatcher)
    {
        $this->dispatcher = $dispatcher;
    }

    public function increaseUserRating(User $user, $add = 1)
    {
        $this->dispatcher->userRatingIncreasing($user->getRating());
        $user->setRating($user->getRating() + $add);
        $this->dispatcher->userRatingIncreased($user->getRating());
    }
}
```

So now we need to also check that the dispatcher event is raised with a specific argument. In
Mockery it could look like that:

```php
$user = Mockery::mock('User');
$user->shouldReceive('getRating')->andReturn(2, 2, 4);
$user->shouldReceive('setRating')->with(4)->once();

$disp = Mockery::mock('EventDispatcher');
$disp->shouldReceive('userRatingIncreasing')->with(2)->once();
$disp->shouldReceive('userRatingIncreased')->with(4)->once();

$calc = new UserRatingCalculator($disp->mock());
$calc->increaseUserRating($user->mock(), 2);
```

The key thing to note here is how we stubbed `getRating()` call with 3 consequent return values.
This is called structure binding - it means your test is now bound to the way your code is
structured (that there are 3 consequent `getRating()` calls in specific order).

In Prophecy solution will look quite different:

```php
$user = $prophet->prophesize('User');
$user->getRating()->willReturn(2);
$user->setRating(Argument::type('integer'))->will(function($args) {
    $this->getRating()->willReturn($args[0]);
});

$disp = $prophet->prophesize('EventDispatcher');
$disp->userRatingIncreasing(2)->shouldBeCalled();
$disp->userRatingIncreased(4)->shouldBeCalled();

$calc = new UserRatingCalculator($disp->reveal());
$calc->increaseUserRating($user->reveal(), 2);
```

As you can see, Prophecy takes different approach to the same problem. Prophecy uses approach
called message binding - it means that behaviour of the method does not change over time, but
rather is changed by the other method.

Now, what’s the real difference between these two approaches? Consider a calculator change:

```php
public function increaseUserRating(User $user, $add = 1)
{
    $initialRating = $user->getRating();
    $this->dispatcher->userRatingIncreasing($initialRating);

    $user->setRating($initialRating + $add);

    $resultingRating = $user->getRating();
    $this->dispatcher->userRatingIncreased($resultingRating);
}
```

We simply assigned initial rating to internal method variable (for a clarity sake).

The trick is, this change will break Mockery test, because instead of 3 getRating() calls (and
returns) you now have only two. You locked onto structure, structure changed - you got failure.

In case of Prophecy though, initial test will still pass, because test was bound purely on
communicational behaviour, and it didn’t change a bit.

So the core conceptual difference is not in how you write tests, but when you fix them. Mockery
sometimes could put you into the situation, where you would write tests that will inevitably fail
because of the private structural refactoring. Where’s Prophecy postulates that there is no
failure in this case - because the actual behaviour stayed the same.

