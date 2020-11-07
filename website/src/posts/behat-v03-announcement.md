---
title: Behat 0.3
date: 2010-11-02
tags: [post, news, tech, migrated]
layout: post-layout
original: https://everzet.com/post/1461842003/behat-v03
---

# Behat v0.3

Today i’m releasing new major version of Behat. It’s 0.3 & generally focused on hooks & formatters. I’ve totally refactored filters, hooks loaders/container/dispatcher & added 2 new great formatters.

## Filters

Before this update you could run all your feature files inside 1 folder or single feature file anywhere. But what if you want to run only specific scenario or feature? What if you write scenarios & want to run only “Work In Progress” features? Answer is - filters! Behat 0.3 comes with 2 new command line filters

* feature elements name filter
* feature elements tags filter

### Name Filter

First of all, name filter. Every your feature, scenario or outline can have title, like that:

```gherkin
Feature: Feature_Title
  Scenario: Scenario_Title
```

And now you can run only scenarios with specified name:

```bash
behat --name Scenario
```

will run only `features/scenarios/outlines`, that has “Scenario” word in their name. Want to
filter with harder logic? No problem, `--name` filter supports regexps to:

```bash
behat --name '/^Scenario [247]$/'
```

will run only `features/scenarios/outlines`, that name is “Scenario 2”, “Scenario 4” or “Scenario
7”

### Tags Filter

But what if you want to run only in-progress scenarios? Constantly rewriting name filter will kill
all your motivation. Tags filter comes to rescue! Every feature/scenario/outline can have
tag/tags. Tags - is a word, that starts with @, separates with space and are on line before
`Feature:`, `Scenario:` or `Scenario Outline:` keywords:

```gherkin
@feature-tag1 @feature-tag2
Feature: Feature with tags

  @scenario-tag1 @wip
  Scenario: Scenario 1
    ...

  @scenario-tag2
  Scenario: Scenario 2
    ...
```

here feature has 2 tags (’@feature-tag1’, ’@feature-tag2’). Every scenario in that feature will
inherit this 2 tags in addition to their own. So, Scenario 1 will match to ’@feature-tag1’,
’@feature-tag2’, ’@scenario-tag1’ and ’@wip’ tags filter. Enough words, lets look at the examples:

```bash
behat --tags @wip
```

this will run features/scenarios with @wip (Work In Progress) tag (Scenario 1 in our case). Also,
you can specify multiple tags in filter through comma:

```bash
behat --tags @wip,@scenario-tag2
```

this will run features/scenarios with @wip OR @scenario-tag2 (Scenario 1 & Scenario 2 in our
case). What if you want to run all scenarios without specified tag? Simply add ~ (not) before it’s
name:

```bash
behat --tags ~@wip,@scenario-tag2
```

this will run features/scenarios without @wip OR with @scenario-tag2 tags (Scenario 2 in our
case).

Comma means OR. If you need AND instead - use &&:

```bash
behat --tags ~@wip&&@scenario-tag2
```

will run features/scenarios without @wip AND with @scenario-tag2 tags (thats again Scenario 2 in
our case).

You could also create complex filters like this:

```bash
behat --tags ~@wip,@scenario-tag1&&@scenario-tag3
```

will match to features/scenarios (without @wip OR with @scenario-tag1 tag) AND with @scenario-tag3
tag.

## Hooks

Cucumber is very famous for it’s hooks system. It’s so powerful, that you can use them instead of
feature backgrounds. Also, hooks can be filtered, which means you can hook before tagged/named
scenarios with hook filters.

### Available Hooks

You can create hooks with adding this lines:

```phg
$hooks->beforeSuite(function($event) { /* do something */ });
```

in your `features/support/hooks.php` file.

Available hooks are:

```php
$hooks->beforeSuite(function($event) { /* do something */ });
$hooks->afterSuite(function($event) { /* do something */ });

$hooks->beforeFeature('', function($event) { /* do something */ });
$hooks->afterFeature('', function($event) { /* do something */ });

$hooks->beforeScenario('', function($event) { /* do something */ });
$hooks->afterScenario('', function($event) { /* do something */ });

$hooks->beforeStep('', function($event) { /* do something */ });
$hooks->afterStep('', function($event) { /* do something */ });
```

Here `$event` is instance of `Symfony\Component\EventDispatcher\Event` on which you could call
`$event->getSubject()` and it will return current subject node `FeatureNode` for `beforeFeature()`
& `afterFeature()`, `ScenarioNode` for `beforeScenario()` & `afterScenario()`.

Scenario & step hooks has ability to change current scenario environment. To do this, simply
write:

```php
$hooks->beforeScenario('', function($event) {
    $env = $event->getParameter('environment');
    $env->calc = new Calculator();
});
```

this hook will run before every scenario/outline subscenario and almost equals to Feature Background functionality.

### Filtered Hooks

All hooks except `beforeSuite()` & `afterSuite()` has first argument, which is by default empty.
This is hook filter & it can be:

* name string filter (equals to behat name filter)
* name regex filter (equals to behat name filter)
* tags filter (equals to behat tags filter) means if you write:

```php
$hooks->beforeScenario('@wip,~@scenario-tag2', function($event) {
    $env = $event->getParameter('environment');
    $env->calc = new Calculator();
});
```

then `scenario.before` hook will be fired only if current feature/scenario have @wip tag OR
haven’t @scenario-tag2 tag.

## New Formatters

Most often request from v0.1/v0.2 Behat users was the ability to integrate Behat with CI server,
such as Hudson. Behat was able to interact with CI simply by returning correct exit code & it
works, because Behat always return !=0 on failed suites & ==0 on passed suites. But Hudson also
can integrate with PHPUnit, JUnit & show extended run info, such as exception messages, cases
count & suite run time.

### JUnit Formatter

Now Behat able to generate JUnit-compatible XML’s with new JUnit formatter:

```bash
behat -f junit -o %WORKSPACE%
```

this is example configuration for Hudson CI server.

### HTML Formatter

Also, i’ve created HTML formatter, which could generate reports like this one: EverzetBehatBundle
report in one simpe command:

```bash
behat -f html -o ~/report.html
```

And if you want to customize HTML layout - just create features/support/templates/html.tpl file
and copy initial template from here. Now Behat HTML formatter will use this template instead of
bundled one to generate HTML reports.

## Update

Again, update with PEAR or with GitHub clone/submodule. EverzetBehatBundle is updated already to
match v0.3.

