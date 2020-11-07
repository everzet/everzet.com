---
title: phpspec2 SUS and collaborators
date: 2012-10-08
tags: [post, tech, php, phpspec]
layout: post-layout

permalink: post/33178339051/sus-collaborators/index.html
---

# phpspec2: SUS and collaborators

Good evening my dear BDD practitioners. Today is the first day of the new era. Era of full stack
BDD in php. Today we’ve released first (and even second one, couple hours ago) alpha release of
the first real SpecBDD tool for php - phpspec. We’re really happy about this tool, what it offers
and especially development style it enforces. There are lot of improvement to traditional testing
tools inside, but also, plenty of things that not only different but unusual for other frameworks
in the area (even SpecBDD ones).

First of all, phpspec2 is not a testing framework. It’s a SpecBDD tool. It means, testing is not
our primary aim. Tool’s job is to enforce and make SpecBDD in project flawless and phpspec2 uses
all available methods to do that - state of the artformatters, class and method generators and lot
of othe fancy buzzwords :) Today, i want to explain you the heart of phpspec2 - SUS, collaborators
and prophets.

## SUS

SUS stands for Subject Under Specification. SUS is this thing you’re currently describing in
opened specification. It’s this unexisting object, on which you’re calling unexisting methods and
assuming future outcomes. Most important thing? There could be only one SUS in specification. It
means, you’re always describing one object at a time. Because you hardly could concentrate even on
single unexisting subject. Forcing yourself to concentrate on multiple is like suicide.

I’ve told you already, that phpspec enforces some specific development style. In this particular
case, development style is one subject per specification. How phpspec2 enforces it? It just
doesn’t give you ability to describe expectations about other subjects. You just don’t have any
easy way to do nasty (in SpecBDD terms) things :) You have no choice except doing things right.
And believe me, it wouldn’t take long to see benefits.

So, in phpspec2 single Specification describes single subject. What is Specification? It’s list of
examples about how your object should behave! And what happens when there’s only one subject
possible? You find abilities to make things cleaner. If there’s only one object you’re interested
at a time, then you could just say `this`:

```php
$this->getTitle();
```

Awesome, isn’t it? That’s how you describe objects with phpspec2. You’re pretending that you’re
inside this object and describing it’s behavior and your expectations about it through matchers:

```php
$this->getTitle()->shouldReturn(“myself”);
```

This is possible, because in phpspec2 your SUS is wrapped into special object, called Prophet.
This object can proxy method or property calls into original object and make assumptions about
return values using matchers. Coolest thing about that? When there’s no object or method
implemented yet (usual stuff for BDD), instead of fatal error, you’ll get clean exception message,
and even more - there’s special exception listener, which will offer to generate this class or
method for you.

Also, all return values from your SUS are wrapped into this Prophet object too:

```php
$this->getPayment()->getType()->shouldReturn(“visa”);
```

## Collaborators

Ok, you can describe your object and make assumptions about it’s self-consistent behavior. But we
know that world is much more complicated than that. In real world, most objects are interacting
with each other. For each object in the system, there’s at least one collaborator object, which
communicates with your SUS:

```php
public function payWith(CreditCardInterface $card)
{
    $card->withdraw($this->amount);
}
```

There are 2 ways to handle such situations in classical world of testing - classical and mocking
approaches. In terms of TDD, it’s Classical and London TDD. First (classical) operates with real
or almost-real objects. Every time you need collaborator, you’re instantiating real object for
that. Mockists (LondonTDD) approach is to mock all the collaborators. This way, you can
concentrate on thing that matters right now and keep actual collaborator behavior for later
explanation. In TDD world, there are 2 camps of developers - classicists (those, who prefer
classical approach) and mockists (those, who prefer mock everything). How it relates to phpspec2?
SpecBDD is mockists methodology :) Simply because you can’t avoid insanity if you’ll try to
describe 5 objects through classical approach without implementing those 5 objects :) SpecBDD
tells you - concentrate on single object at a time. And there’s only one way to do that - through
mocks.

Again. I’ve told you already, that phpspec enforces some specific development style :) In this
particular case, development style is mocking every collaborator. In phpspec2, you have examples
instead of test cases. And examples could have dependencies (which are collaborators). And in php,
method dependencies are defined through arguments, right?

```php
public function it_should...($mock1)
{
    $mock1->beAMockOf(‘Some\Class’);
}
```

Yeah, this looks little bit unnatural. That’s why we’re using natural phpdoc syntax to define them
usually:

```php
/**
 * @param Some\Class $mock1
 * @param Some\OtherClass $mock2
 */
public function it_should...($mock2, $mock1)
{
}
```

Easy, right?

Ok, phpspec2 forces you to use mocks as collaborators. But it doesn’t mean you need to deal with
ugly mocking system you’ve seen in other tools before. In case, where 50% of your development
process are mocks, those mocks should be simple. But in most cases, mocks aren’t simple, aren’t
they? That’s because usage of mocks usually involves couple of complex stages to be done during
their usage:

```php
// 1. expectations definition
$payment = $this->getMock(‘Payment’);
$payment
    ->expects($this->once())
    ->method(‘payWith’)
    ->with($visa);

// 2. execution
$bank->process($payment);

// 3. check expectations
```

You see, there’s at least 2 stages every time you use mocks:

* definition stage - you’re defining what methods should be called and how
* execution stage - you’re executing those methods
* checking stage - you’re checking expectations

In most modern frameworks, stage 3 is hidden, so you only have to deal with first 2. Good, but you
still need to work with cumbersome syntax just to differentiate expectations definition from
execution stages. Do you? In my opinion - no. In my whole developer life i haven’t seen case where
execution happens inside test case or example code (on the first level i mean). In test case
you’re always defining expectations. Then why do you need to use this differentiation-driven
syntax? In phpspec2, you don’t:

```php
$mock->getTitle()->willReturn(‘phpspec2’)->shouldBeCalled();
```

Meet the phpspec2 mock. Yup, `getTitle()` method should be called without arguments and when it is, it’ll return phpspec2. Ok, but in most cases you don’t care whether it will be called or not. The only thing you care about is that when it does - it should return something. It’s called stubbing. In phpspec2, stubs look like that:

```php
$mock->getTitle()->willReturn(‘phpspec2’);
```

What’s the difference? There’s no `shouldBeCalled()` method. Ok, let’s go to complext case. How to
mock this:

```php
public function prettify($string)
{
    return sprintf($this->format, $string);
}
```

It’s so-called proxy-method. In phpspec2, you’ll stub it like that:

```php
$mock->prettify(ANY_ARGUMENT)->willReturnArgument();
```

This stub will be matched to any `prettify()` call with any single argument. And when it’s called,
it’ll return this argument. That’s phpspec2 collaborators.

So that’s it for today, just go and try it! And don’t forget to check demo video for it.


