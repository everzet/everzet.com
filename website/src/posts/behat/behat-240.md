---
title: Behat 2.4
date: 2012-05-12
tags: [post, tech, php, behat]
layout: post-layout

permalink: post/22899229502/behat-240/index.html
---

# Behat 2.4: The most extendable testing framework

I’ve just finished major refactoring of Behat core, that will lead to the next major Behat version
next monday - 2.4. And i can’t wait to explain you all goodness that waits you in next version,
but first, i need to take little jump into history :)

## Reinventing the wheel

Almost two years ago, when i first came across StoryBDD and cucumber i was amazed by the
possibilities it could give to development process. So, obviously, i immediately started to think
about how to bring this goodness into php world. This could look like obvious things for you as
i’m writing post about next major version of Behat here, but one thing you most likely not know is
that Behat in it’s first realization attempt was intended to become just a PHPUnit extension with
Gherkin parser :) Yep, i don’t like reinventing the wheel and i wanted to leverage as much
3rd-party tools as possible to just “do the job” in simplest possible way. But why we have
full-featured Behat framework here instead of just a cool PHPUnit extension? Short answer: because
PHPUnit doesn’t support extensions in the way i could really leverage StoryBDD with it. So i’ve
started Behat. And i’ve made promise to myself, that if i’ll create sufficient framework, i’ll
make it really extendable, so no one will have problems with additng cool features into my
framework.

## Symfony components

When i’ve started Behat, i knew that i want to make reliable, clean core in order to make this
framework extendable and highly maintainable. So i needed 3rd-party libraries for that. And know
what, i’m Symfony guy :) So i’ve just took Symfony2 components that Behat needed and done job on
top of them. Such a complex tool creation with own parser wasn’t really an easy job and Behat core
was almost completely recreated (complete refactoring) 4 times at least (what, you didn’t noticed
that?). But the thing that always been here - completely clean core, extendable, based on Symfony2
components. Behat uses DIC since the beginning and this early decision gave me absolutely
different level of agility in refactoring, thanks to which we have what we have now - amazing BDD
tool. And today, i’m extremely happy to finally say, that my initial goal is achieved - Behat is
freaking really extandable and the biggest thing i’ve done - i’ve just provided couple of
extensions points and plug through which you can talk with DIC.

## Extensions system

So, Behat 2.4. Major update. Lot of things in core replaced, rewritten, moved (again!). Lot of
code cleaning, lot of bug fixing, lot of internal improvements and yeah, almost forgot - new
extension system. This is the hottest thing on the planet. As a matter of fact, it is so hot, that
sun looks like a piece of ice in comparison with it. And it’s based on Symfony2 DIC component.
Yeah, no new things for you, Symfony2 guys. Extension system in Behat 2.4 is almost like bundle
system in Symfony2, but simpler. Basically, everything in Behat is constructed and dispatched
through DIC. And what extension system gives to you, is basically an ability to hook into
container creation process and declare your own or extend Behat core services in it. Through this
simple interface.

This extension system is really powerful and clean, but as anything so powerful, it could be
little bit hard to describe at first. So, i’ve thought a lot about how to easily introduce all
this to our awesome userbase. And the best way i’ve found is through example…

## MinkExtension

New kid in the house. Basically, there’s no Behat-related stuff in Mink anymore - everything is
moved into brand new MinkExtension. And now i’ll explain you both why and how you might create an
extension like this one.

Ok. Why? Becase static variables suck. They break extendability, they break cleanliness of your
code, they break with future Behat updates. But in old Behat, you just couldn’t live without them.
You see, FeatureContext is something, that is local to each scenario, Mink in comparison is not -
you don’t want to close and open your Firefox window between each scenario, don’t you? So, Mink
should exist outside the lifetime of FeatureContext and there was only one way to achieve that
before 2.4 - static variables.

And it’s not only about Mink - there’s lot of global loggers, state readers, connection
persisters, that you most likely wouldn’t want to recreated before each scenario.

As any problematic static variables usage, this one just indicates bigger hidden problem: Mink
instance initialization and maintaining isn’t a feature suite task - it’s configuration system (or
extension in our case) task. Let’s say you’re doctor, working in clinic. When you go to the work
at morning, no one expects you to buy your own stethoscope or desk - clinic should provide you
with all the needed instruments to do your job… With your suite contexts it’s the same. And we
were pretending as one-man-clinic for too long now. So long, that it’s time to fix things!

## Creating MinkExtension

Ok, first step to start with extensions is to understand, that they are just simple objects implementing `Behat\Behat\Extension\ExtensionInterface` or extending `Behat\Behat\Extension\Extension`.

## Installing Behat 2.4 and Mink 1.4

Lets install latest version of Behat and Mink. I’ll use Composer for that:

```json
{
  "require": {
    "behat/behat": "2.4.0beta5",
    "behat/mink": "1.4.0beta2"
  },
  "repositories": {
    "behat/mink-deps": {
      "type": "composer",
      "url": "behat.org"
    }
  },
  "config": {
    "bin-dir": "bin"
  }
}
```

Now run:

```bash
curl http://getcomposer.org/installer | php
php composer.phar install
```

We’re ready to go!

## Bootstraping and activating extension core

As ususal, extending something with already implemented for you methods is easier than
implementing them with hands as forced by interfaces. So, let’s create our first extension class
inside `features/extensions/MyAwesomeExtension.php`:

```php
<?php
# features/extensions/MyAwesomeExtension.php

use Behat\Behat\Extension\Extension;

class MyAwesomeExtension extends Extension
{
}
```

Simple, right? Looks like an empty class, but in reality, it’s the world of unlimited
possibilities. Now we lets activate this incredibly useless (yet) one in Behat:

```yaml
# behat.yml
default:
  extensions:
    features/extensions/MyAwesomeExtension.php: ~
```

Ok. What’s this `MyAwesomeExtension.php`? It’s classfile of your extension. How Behat will be able
to instantiate it? It won’t, because it can’t. You should return new instance by yourself:

```php
<?php
# features/extensions/MyAwesomeExtension.php

...

return new MyAwesomeExtension();
```

As a matter of fact, you are not required to use classfile path to your extension initializer
(script, that returns extension instance). Behat supports 5 ways of activating extensions:

1. Using `*.phar` file, which will return instantiated extension instance from it’s stub.
1. Using fully-qualified classname, that is discoverable by Behat autoloader. bootstrap folder is
   not really an option here as files inside it would be required after configuration
   initialization. So only option here is if you’re using Composer.
1. Using relative (from config file) path to script, which will return new extension instance.
1. Using absolute path to script, which will return new extension instance.
1. Using php include path to script, which will return new extension instance. This is an option
   if you’re using PEAR to install your Behat and extensions - you’ll be able to activate
   extension with simple `mink-extension/init.php`.

## Providing extension parameters through `behat.yml`

It was simple. Now lets pass some parameters into our extension from `behat.yml`:

```yaml
# behat.yml
default:
  extensions:
    features/extensions/MyAwesomeExtension.php:
      param1: value1
      param2:
        subparam1: subvalue1
        subparam2: subvalue2
```

Those parameters will get passed into your extension load() method as first array argument:

```php
<?php
# features/extensions/MyAwesomeExtension.php

use Behat\Behat\Extension\Extension;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class MyAwesomeExtension extends Extension
{
    public function load(array $config, ContainerBuilder $container)
    {
        // $config contains parameters
    }
}

return new MyAwesomeExtension();
```

## Injecting services into DIC

Before going any further, you should read DIC introduction and understand some basics.

So, from previous code block you might noticed this ContainerBuilder thing. What is it? It’s DIC
in a flesh. You’ll use this object to tell Behat about your own services and how Behat should use
them.

Lets add some boilerplate code into our load() method to load extension services config. We’ll use
`*.xml` files for our DIC configuration files (but you could also use `*.yml` or `*.php` files for
that):

```php
public function load(array $config, ContainerBuilder $container)
{
    $loader = new Symfony\Component\DependencyInjection\Loader\XmlFileLoader(
        $container,
        new Symfony\Component\Config\FileLocator(__DIR__)
    );
    $loader->load('services.xml');
}
```

This will load your own `features/extensions/services.xml` service configuration file into
\$container. Lets start from describing Mink service in <services> section:

```xml
<?xml version="1.0" ?>
<container xmlns="http://symfony.com/schema/dic/services"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://symfony.com/schema/dic/services http://symfony.com/schema/dic/services/services-1.0.xsd">
    <services>
        <service id="behat.mink" class="Behat\Mink\Mink" />
    </services>
</container>
```

You see that `<service id="behat.mink" ... >` declaration? It’s our brand new service. Now next
time someone will require behat.mink service, container will provide this service, initializing it
first, if needed (if not initialized yet).

## Context initializers

So, that’s it. Now Behat DIC is able to instantiate Mink (i’m avoiding additional stuff here like sessions, drivers, selector handlers, as it’s not important for introduction). But now we have two important questions:

1. Who will cause DIC to instantiate this Mink service?
1. How to get instantiated Mink service inside our context class?

Both those questions should be answered with context initializer. Context initializer is any
class, that implements `Behat\Behat\Context\Initializer\InitializerInterface` and have only one
aim - to inject specific services into your context instances before each scenario. Lets create one (in the same classfile):

```php
<?php
# features/extensions/MyAwesomeExtension.php

use Behat\Behat\Context\Initializer\InitializerInterface;
use Behat\Behat\Context\ContextInterface;
use Behat\Mink\Mink;

...

class MinkAwareInitializer implements InitializerInterface
{
    private $mink;

    public function __construct(Mink $mink)
    {
        $this->mink = $mink;
    }

    public function supports(ContextInterface $context)
    {
        // in real life you should use interface for that
        return method_exists($context, 'setMink');
    }

    public function initialize(ContextInterface $context)
    {
        $context->setMink($this->mink);
    }
}

...
```

Now let’s add this initializer into DIC:

```xml
<service id="mink.context.initializer" class="MinkAwareInitializer">
    <argument type="service" id="behat.mink" />
    <tag name="behat.context.initializer" />
</service>
```

With this definition we tell Behat 2 things:

1. There’s a new custom service, called mink.context.initializer, which when initialized should
   get behat.mink service as a constructor argument.
1. This service should be used by Behat as context initializer (thanks to tag with specific
   behat.context.initializer name).

So, how context initializers work? Basically, after Behat instantiates new context class (before
each scenario), it gets all the registered initializers and checks if they support this context or
any of it’s subcontexts by calling `supports(...)` method on each registered initializer. If some
initializer supports this context (`supports()` returns `true`) - `initialize()` method gets
called. In our case, if our context (or any of it’s subcontexts) have `setMink()` method, this
method will be called immediately after context instantiation, recieving mink instance as an
argument. Just like that.

Want to have mink instance in your subcontext - just add `setMink()` method to it and Behat will
do the rest for you. Awesome, right? It is! No more fiddling with `$this->getMainContext()->getSubcontext('mink')->getMink()`. You just implement some interface with your subcontext (adding methods) and that’s it - Behat will do the rest for you behind the scene.

**Important note**: actual MinkExtension really uses interfaces instead of simple method checking (so should you), this way it’s more safe to say that context is the expected one by concrete initializer.

## Context class guessers

Ok, now we have same mink instance in all our contexts and its subcontexts. But also, we will
provide base context class with predefined Mink steps. Problem here is that you always need to
create your custom context class inside `bootstrap/` folder, even if you use only bundled with
Mink definitions. Well, you’re not required to anymore, cuz that’s what context class guessers are
here for. As you might expect, context class guessers are just another class, that implements
another fun interface - `Behat\Behat\Context\ClassGuesser\ClassGuesserInterface` in this case.
Let’s define our custom one, which will just return our bundled context class:

```php
<?php
# features/extensions/MyAwesomeExtension.php

Behat\Behat\Context\ClassGuesser\ClassGuesserInterface;

...

class MinkContextClassGuesser implements ClassGuesserInterface
{
    public function guess()
    {
        return 'YourCustomContext';
    }
}

...
```

This interface (and our class, that implements it) have only one method - guess() and this method
just returns fully-qualified classname for your context. Now, how to make it work? Just add it to
the DIC config with specific tag:

```xml
<service id="mink.context.class_guesser" class="MinkContextClassGuesser">
  <tag name="behat.context.class_guesser" priority="-1" />
</service>
```

Ok, this one is little bit more tricky. What this `priority="-1"` means? It means that this
guesser have even lower priority than the default one. You see, Behat already have default class
guesser, which uses preconfigured classname (FeatureContext by default), but only if this class
exists.  Default guesser have priority of `0`. So in our case, `0` is greater than `-1`, so
default guesser will be called first. Default guesser will check that FeatureContext is available
and if not - our new guesser will be called instead. Yep, you don’t need to create your own
`FeatureContext` class or even `bootstrap/` folder anymore, just to use bundled with
`MinkExtension` definitions - just write your features and you’re ready to go

## More stuff

There’s much more clean extension points, that you can use in your extensions. Basically, you
should know, that you always can cleanly add/extend:

* context class guessers
* context initializers
* formatters
* arguments or options to CLI
* definition snippets generators
* gherkin loaders

And other extensions could even add their own extensions points. MinkExtension adds support for
`behat.mink.session` and `behat.mink.selector` pass, giving other extensions (Symfony2Extension)
ability to easy add custom sessions or selectors engines to the Mink.

Also, you have ability to make dirty-extensions, replacing any service in Behat core with your
own. But i highly encourage you to use clean extension points. This will save your extension from
future BC breaks.

I’ve just covered small part of new extension system, but i hope it’s enough to explain why we
need such a big change in paradighm and to make you curious. I’ll try to put more detailed chapter
about it into http://docs.behat.org in coming weeks.

## BehatBundle

Ok, Symfony2 guys. BehatBundle was pain in the arse for me since it’s creation. It was most custom
Behat installation to date. Basically, it was extension, but dirty one. It was doing
monkey-patching of Behat core cuz there was no real extension points in it as we have no. But even
that was not the biggest problem. Biggest problem with BehatBundle was to execute Behat (testing
framework) inside application it was intended to test. If you ever faced “DBAL: too many
connections” or “man, you’re working with wrong container”, you will understand what i mean. It
was messy, it was broken. Time to fix things. I’m working on Symfony2Extension - extension that
will give your contexts knowledge of Symfony2 AppKernel in the same way MinkExtension given them
knowledge about Mink.

There will be custom context initializer, little bit more complex class guesser and additional CLI
stuff. But it still will be Behat. The one installed through PEAR, PHAR or Composer. And it will
know everything it should know about your AppKernel or bundles. In terms of functionality it will
offer almost same (maybe more) amount of tools, but will do it correctly. And i’m trying to
achieve as less BC-breaks as possible in this process. I’ll write additional post about it on
monday.

## When?

Behat 2.4, Mink 1.4 on monday. MinkExtension is already here. MinkExtension doesn’t have versions
or tags - only master. It means, that whenever you’ll propose new definition translation or step
fix and i’ll merge it - everybody will get fix immediately (in case of Composer, of course).

## More extensions

What extensions mean to Behat users? Tighter integration with other frameworks, tighter
integration with cloud services like SauceLabs (already in works) and other tools, more
formatters, more everything. It’s really a great opportunity for whole community to make huge step
forward.

