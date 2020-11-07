---
title: Behat 1.2
date: 2011-06-13
tags: [post, news, tech, migrated]
layout: post-layout
original: https://everzet.com/post/6487273052/behat-v12-poll
---

# Behat: Bye-bye ninja-style Ruby, hello oop-style PHP?

Now, as Behat is mature product, it’s time to listen userbase. Most often feedback is:
http://twitter.com/alexandresalome/status/78109547872522240 Which means something like: “Why PHP
tool can’t be more PHP and less Ruby style?”. It CAN!

PHP people dont like ruby-style callback-oriented code in their PHP applications, even if it’s a
testing code. And there’s some good reasons for that:

1. Callback-oriented code is less readable and maintainable, than CLASSical PHP code.
1. Callback-oriented code is based on horizontal-reusability (traits, open-classes, modules)
   patterns, making vertical reusability (inheritance) almost impossible.
1. It’s hard to think object-oriented in functional-oriented code.

So, today i’m proud to present you totally reworked version of Behat definitions loader.

## Bye-bye env.php, hooks.php, steps/*.php, hello FeaturesContext!

Yes! I’ve removed this 3 core file structures from Behat and more - i’ve removed all paths except
`support` and even `support` now has different approach.

From now on, support is a simple autoloading folder. All `*.php` files in that folder will be
autoloaded as it was with `support/bootstrap.php`. So… your help classes, test helpers and other
php code will feel like home here.

But where does my `env.php`, `hooks.php`, `steps.php` go, you ask… And i’ll answer - Context! All
this little pieces: environment configuration, steps and hooks definitions now live in one single
place, called Context:

```php
<?php
# features/support/FeaturesContext.php

use Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\Pending;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

class FeaturesContext extends BehatContext
{
}
```

Context is a simple POPO (Plain Old PHP Object), which is logically close to Environment object. Every scenario has it’s own Context and Behat initializes this object before every and each scenario in your feature suite.

## Step definitions

What about steps? Steps are simple methods in this object… with annotations:

```php
...
/**
 * @Given /^I have entered (\d+) into the calculator$/
 */
public function iHaveEnteredIntoTheCalculator($number)
{
    $this->number = intval($number);
}
...
```

As you might see, this is a simple instance method with access to instance’s `$this`. Bye-bye
`$world`, i’ve never loved you really! Most important part here is annotation with regex. There
are 3 step definition annotations to help you:

* `@Given /regex/`
* `@When /regex/`
* `@Then /regex/`

And one method could have multiple annotations, which means that it can match to multiple step types:

```php
<?php

use Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\Pending;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

class FeaturesContext extends BehatContext
{
    private $user;

    /** @Transform /"([^"]+)" user/ */
    public function createUserFromUsername($username) {
        return new User($username);
    }

    /** @Transform /^table:username,age$/ */
    public function createUserFromTable(TableNode $table) {
        $hash     = $table->getHash();
        $username = $hash[0]['username'];
        $age      = $hash[0]['age'];

        return new User($username, $age);
    }

    /**
     * @Given /I am ("\w+" user)/
     * @Given /I am user:/
     */
    public function iAmUser(User $user) {
        $this->user = $user;
    }
}
```

## Hooks

Ok, step definitions are fine. But what about hooks? Same story:

```php
<?php

use Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\Pending;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

class Hooks extends BehatContext
{
    /**
     * @BeforeSuite
     */
    public static function doSomethingBeforeSuite()
    {
        // do something before suite even runs
    }

    /**
     * @BeforeScenario
     */
    public function beforeScen()
    {
        // do something before each scenario
    }

    /**
     * @BeforeScenario @rest-fixtures
     */
    public function loadFixtures()
    {
        // do something before each scenario with @rest-fixtures tag
    }
}
```

There are multiple types of hooks you can use in your contexts:

* `@BeforeSuite`
* `@AfterSuite`
* `@BeforeFeature [@optional_tag_filter|optional_name_filter]`
* `@AfterFeature [@optional_tag_filter|optional_name_filter]`
* `@BeforeScenario [@optional_tag_filter|optional_name_filter]`
* `@AfterScenario [@optional_tag_filter|optional_name_filter]`
* `@BeforeStep [@optional_tag_filter|optional_name_filter]`
* `@AfterStep [@optional_tag_filter|optional_name_filter]`

As you noticed, every hook except (Before|After)Suite has optional filter string in which you can
specify filter tag or name string (see example above).

(Before|After)Scenario and (Before|After)Step hooks are runs during Context instance lifetime, so
they are simple instance methods, but (Before|After)Feature and (Before|After)Suite should be
static methods, cuz they runs before or after scenario instance lifetime.

## Reusability

That’s all great, but what about reusability? All definitions should be defined in one single
class? With annotations?? Are you kiddin??? Not really. In reality, Context objects even have 2
types of reusability - both horizontal and vertical. Something, that old system lacks.

## Vertical

Vertical reusability is a simple inheritance. You can inherit your Context class from any other
PHP class in the system. One rule simple rule is: someone of them should implement
`Behat\Behat\Context\ContextInterface` interface. And in that case, Behat will read all
annotations from every class in inheritance tree:

```php
<?php
# features/support/FeaturesContext.php
use Behat\Behat\Context\BehatContext;

class BaseFeaturesContext extends BehatContext
{
    /** @Given /I found (\d+) apples/ */
    public function stepMethod($number) {}
}
```

and your main context:

```php
<?php
# features/support/FeaturesContext.php

class FeaturesContext extends BaseFeaturesContext
{
    private $number;

    public function stepMethod($number)
    {
        $this->number = intval($number);
    }
}
```

As you might see, overrided method inherits all annotations from parent class and can even add
some new annotations to the block. YES! You can now override bundled step definitions ;-)

## Horizontal

But in PHP, we can inherit only from one class at a time? What if i want to split my Context into step definitions and hooks? Subcontexts will help you! Every Context can have subcontexts. Subcontexts are same POPO instances, that implements ContextInterface interface. The only difference is that you create them by hands instead of Behat:

1. You create context object instance
1. Make this context object a subcontext to the current Context with addSubcontext call
1. Behat will automaticall find all definitions and hooks from all registered subcontexts

Let’s take an example:

```php
<?php
# features/support/HooksHolder.php
use Behat\Behat\Context\BehatContext;
class HooksHolder extends BehatContext
{
    /** @BeforeScenario @with_some_tag */
    public function doSomething() {}
}
```

and your main context:

```php
<?php
# features/support/FeaturesContext.php
use Behat\Behat\Context\BehatContext;
class FeaturesContext extends BehatContext
{
    private $hooks;

    public function __construct(array $context_parameters)
    {
        $this->hooks = new HooksHolder();
        $this->addSubcontext($this->hooks);
    }
}
```

And that’s all. All your hooks now will be found by Behat and even more - you can call any of them by hands with `$this->hooks` variable!

## Give it a try

New behavior is finished and fully-tested. You can try it from feature/definitions-revamp branch on github: https://github.com/Behat/Behat/tree/feature%2Fdefinitions-revamp

## Decision

This is a very big change in core of Behat. And, what’s more important, it’s biggest ever change
in userbase. I’ve tried hard to support both old and new definitions scheme, but it was
impossible - they are too different. So, rather than bloodly changing something already useful
(thanks you all, my beloved Behaters) to something non-needed to users, i’ll leave decision for
you. Comment this topic with “+”/“-”, “yes”/“no”, “why?”/“at last!” and after a week, i will OR
will not merge this big change into master.

So, it’s time to decide, my Behaters… Do you want Behat 1.2 to become something completely
OOP-like or do you like old style definitions?

