---
title: Behat 2.0
date: 2011-06-20
tags: [post, tech, php, behat]
layout: post-layout

permalink: post/6719826499/behat-v2-announce/index.html
---

# Behat v2: The OOP powa!

Ok, the week is passed. Time to make a decision. But first, i want to say thank you! Thank you all
for awesome feedback about our future and for just being Behat users no matter what amount of time
you use it or what usestyle you prefer. Let me make my point clear once again - every user is
important for me and Behat community.

One week ago you answered my simple question “should we switch to OOP direction instead of
closures” and here’s simple statistics:

* 18 users for new syntax
* 1 user against it (Jeremy Bush)

Also, i’ve learned 2 important lessons from your feedback:

1. Even users, who prefer OOP-style definitions don’t know why they prefer it. They feel, that
   it’s a more natural way, but why?
1. Users, who prefer old closure-style definitions prefer it so much, that they really think about
   switch-out from Behat because of OOP switch!

So, i’ve worked this weekend hard to demonstrate you all 2 important things:

1. Every Behat user is important to me. At least while he’s interested in Behat ;-)
1. The OOP is the pooowaaa!

## Welcome, context interfaces!

First thing, that i’ve changed from previous proposal is rename of `support` folder into
`bootstrap`.  Yes, Behat autolorequire path now is `features/bootstrap` - all `*.php` files in
that folder will be required on Behat utility start. So, your bootstrap and help scripts, same as
`FeatureContext` class should be placed here (by default).

Also, i’ve tuned up FeatureContext little bit. Now, when you run behat `--init`, you’ll get:

```php
<?php
# features/bootstrap/FeatureContext.php

use Behat\Behat\Context\ClosuredContextInterface,
    Behat\Behat\Context\TranslatedContextInterface,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\Pending;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;

//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
class FeatureContext extends BehatContext
{
    /**
     * Initializes context.
     * Every scenario gets it's own context object.
     *
     * @param   array   $parameters     context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        // Initialize your context here
    }

//
// Place your definition and hook methods here:
//
//    /**
//     * @Given /^I have done something with "([^"]*)"$/
//     */
//    public function iHaveDoneSomethingWith($argument)
//    {
//        doSomethingWith($argument);
//    }
//
}
```

If you look very closely, you’ll notice 2 new interfaces in the header of file:

* `Behat\Behat\Context\TranslatedContextInterface`
* `Behat\Behat\Context\ClosuredContextInterface`

First one describes `getTranslationResources()` context method, which should return array of
`*.xliff` file paths, which Behat will load and use to translate your step definitions and
translations. Behat will call this method and load all bounded translation xliff’s from every
context, that implements `TranslatedContextInterface`. That’s simple!

Now, `ClosuredContextInterface`. This interface declares `getStepDefinitionResources()` and
`getHookDefinitionResources()` methods, which your context should implement in order to use this
interface. First method (`getStepDefinitionResources()`) should return array of paths to `*.php`
files with closure-style step definitions (exactly same definitions as were in Behat 1.x). Second
method should return array of paths to `*.php` files with closure-style hook definitions (exactly
same hooks as were in Behat 1.x).

So, if you drive your `FeatureContext` to something like this:

```php
<?php
use Behat\Behat\Context\ClosuredContextInterface as Closured,
    Behat\Behat\Context\TranslatedContextInterface as Translated,
    Behat\Behat\Context\BehatContext,
    Behat\Behat\Exception\Pending;
use Behat\Gherkin\Node\PyStringNode,
    Behat\Gherkin\Node\TableNode;
use Symfony\Component\Finder\Finder;

if (file_exists(__DIR__ . '/../support/bootstrap.php')) {
    require_once __DIR__ . '/../support/bootstrap.php';
}

class FeatureContext extends BehatContext implements Closured, Translated
{
    public $parameters = array();

    public function __construct(array $parameters) {
        $this->parameters = $parameters;

        if (file_exists(__DIR__ . '/../support/env.php')) {
            $world = $this;
            require(__DIR__ . '/../support/env.php');
        }
    }

    public function getStepDefinitionResources() {
        if (file_exists(__DIR__ . '/../steps')) {
            $finder = new Finder();
            return $finder->files()->name('*.php')->in(__DIR__ . '/../steps');
        }
        return array();
    }

    public function getHookDefinitionResources() {
        if (file_exists(__DIR__ . '/../support/hooks.php')) {
            return array(__DIR__ . '/../support/hooks.php');
        }
        return array();
    }

    public function getTranslationResources() {
        if (file_exists(__DIR__ . '/../steps/i18n')) {
            $finder = new Finder();
            return $finder->files()->name('*.xliff')->in(__DIR__ . '/../steps/i18n');
        }
        return array();
    }

    public function __call($name, array $args) {
        if (isset($this->$name) && is_callable($this->$name)) {
            return call_user_func_array($this->$name, $args);
        } else {
            $trace = debug_backtrace();
            trigger_error(
                'Call to undefined method ' . get_class($this) . '::' . $name .
                ' in ' . $trace[0]['file'] .
                ' on line ' . $trace[0]['line'],
                E_USER_ERROR
            );
        }
    }
}
```

you’ll get all your already defined definitions and environment configs from Behat 1.x. It will
load `features/steps/*.php` as step definitions, `features/support/bootstrap.php` on Behat start,
`features/support/env.php` on context creation and even `features/support/hooks.php` as hook
definitions file. It’ll just work! Believe me, i’ve tested it:
https://github.com/Behat/Behat/tree/v2/features/closures ;-)

That’s the power of OOP. It was impossible to support OOP-style definitions on top of
closure-centric environment. But it turns, that it’s extremely simple to implement closure-style
definitions on top of OOP-centric design ;-)

And know what? You can even mix them! You can mix closured contexts with annotated (default ones)
or you can add annotated definitions into your closured contexts!

## Behat v2

So, let me introduce you a new kid: Behat v2 with:

* context-centric design (FeatureContext is center of your feature suites)
* refactored definitions and story-syntax printers to be more pleasant to use
* transformations translations
* some cool new CLI options (–no-paths, –no-snippets, –expand)
* weaverryaned © help and exception messages
* full backward compatibility with Behat v1.x

Is it really big to be a major version bump? You decide: 129 commits, 7900 additions, 2200
deletions (https://github.com/Behat/Behat/compare/master…v2#files_bucket).

## When?

Beta1 is already available from pear channel.

OOOR: behat-2.0.0beta1.phar. Yes, from now on, every Behat release will come with appropriate
full-featured phar package.

Installation of Behat was hard task for most of the users. First, you were need to install PEAR,
then discover channel, then and only then - behat. Now, with phar it’s as simple as:

1. Download behat-2.0.0beta1.phar
1. Use it: `php behat-2.0.0beta1.phar -h`

It has all dependencies packaged into it. So it’s the only 1.2 mb, you need to get full-featured
working Behat v2 ;-)

v2 release party will be next week. I’ll update Mink and all Symfony2 Bundles accordingly later
this week.

## Thanks!

Once again. This wouldn’t be possible without you, my sweet Behat community. Feel free to propose,
argue or even hate me if it’ll help to make the best future for Behat, as Jeremy Bush did ;-)

