---
title: Economy of Tests
date: 2015-01-05
tags: [post, product]
layout: post-layout

permalink: posts/2015/1/economy-of-tests/index.html
---

# Economy of Tests

![Snow Geese Migration](http://verraes.net/img/posts/2015-01-05-economy-of-tests/Snow_Geese_Migration.jpg)

*This is a joint post with [Mathias Verraes](https://twitter.com/mathiasverraes). You can expect
more of these.*

A common complaint with teams that first try their hand at automated testing, is that it is hard,
costly, and not worth the effort. On the other hand, supporters say that [it saves them
time](https://twitter.com/mathiasverraes/status/234641929260908544). In this post, we’ll try to
add some nuance to the discussion. We’ll take a look at how different levels of automated testing
affect the cost of development, both in the short and the long term, for both greenfield and
brownfield projects. Finally, we’ll look at a simple strategy for introducing tests and migrating
them across test levels, in order to reduce maintenance costs.

## Definitions of Test Levels

Coming up with universal definitions of types of tests, is hard. There are many styles, and
different authors choose different categorizations. **For the scope of this post**, we will
simplify to three levels.

- A **unit test** verifies a single behavior of a single unit -- this can be a function, a method,
  or a class, but it can be something other as well. A logical unit is something that can be
  **reasoned about in isolation**. The unit must be **completely under your control**. The test
  should limit the number of other units it touches on, and should not touch any part outside of
  your own system. As such, the test should **only fail for one reason**.
- **Integration testing** means we’re verifying that that different units are working together. It
  focuses on the **interfaces between components**. Some of these components may be from third
  parties. When they break, they signal that, although individual units may behave correctly,
  something changed in the API that caused failure in another place. Often, integration tests are
  slower than unit tests.
- **System testing** uses a **production-like environment** to verify the system as a whole. This
  may include user interfaces, databases, web servers, logging, etc. Typically a call is made at
  the **outside boundary of the system**. Ideally, the outcome is verified at the same boundary.

## Learning

System and integration tests do not require you to adapt your system’s design in order to be
testable. The difficulty with good unit tests, is that they require good software design to be
useful. Because of this, unit tests are more costly than system and integration tests. To learn
system testing, all you need to learn is the tools and the process. To learn unit testing, you
need to learn design at the same time. This frustrates developers who are new to unit testing. The
method appears not to work for them, because they're trying to learn unit testing without learning
better design.

When discussing the cost of a method, we need to separate the cost of the learning from the cost
of actually applying the method. Once you’ve learned something, you can transfer this knowledge
and reuse it.

## Test Metrics

A number of metrics affect the cost of a test.

- **Execution speed**: the faster a test runs, the shorter the feedback loop. You will run the
  test more often during development. The lifespan of a mistake is reduced. The failing tests
  notifies you of the mistake before you get a chance to move on to other tasks. The reasoning is
  still fresh in your head. Nothing else is built on top of the mistake. You can quickly fix it
  and move on. People with little experience in TDD usually underestimate the **cumulative effect
  of this feedback loop**.
- **Fragility**: the less stable your test is, the less you trust it. If your test breaks a lot,
  it’s harder to use as a meaningful measure of the system quality. **Brittle tests often indicate
  a coupling problem**. Either your test touches too many parts of the system, or the system under
  test itself is too coupled. For example, a small change in the GUI breaks a test in the domain
  model. Even worse is *flickering*: a test that breaks, even when you haven’t made any changes.
  This might happen because of things like race conditions or dependencies on services outside of
  your control.
- **Understandability**: writing code is usually easier than reading it. A clear test is the best
  documentation for the system you could have. Textual documentation tends to rot. Tests on the
  other hand are executable. When the system changes, the test breaks, and therefore the
  documentation breaks. However, a misleading or confusing test can actually derail the learning
  process of a developer. If the effort of reading the test is too great, it won’t be read, it
  won’t be maintained, and it won’t be used.

When do these metrics matter?

When you are introducing a first test, we have a specific goal: we want to add a new feature, or
we want to assert an existing behavior. We focus on one test at a time. The execution speed is
usually not that important. Even if it takes ten seconds, that’s still short enough to get the
benefit of fast feedback. We run the test in isolation, so it only breaks because of direct
changes. Fragility won’t show up until much later. And finally, as we have just written the test,
understandability is not a factor yet either.

The impact of these metrics increases dramatically the more tests you have. The cost you pay in
order to keep the tests fast, green, and understandable, is affecting overall development effort.
You could ignore the tests, but then you lose all the benefits they bring.

## Project Lifecycle

Is it a new project, or an existing codebase? That is our final factor for looking at the cost of
tests. In our experience, in a greenfield project, the cost of introducing tests at any level
(unit, integration, system), is equivalent.

Being able to introduce tests cheaply at any level, is great, but there’s a hidden risk. People
new to automated testing, might be inclined to put too much focus on system and integration tests.
As we discussed earlier, those levels are easier to learn, and, by consequence, more popular. Over
time, system and integration tests become costlier: they are slower, harder to read, and they are
brittle. These forces accumulate, leading to technical debt in the tests.

<style>
td {
    border: 1px solid white;
}
</style>
<table cellpadding="5" cellspacing="5" style="width:100%; margin: 30px 5px"><thead><tr><th> </th>
<th colspan="2">Greenfield</th>
<th colspan="2">Brownfield</th>
</tr><tr><th> </th>
<th>Introduction</th>
<th>Maintenance</th>
<th>Introduction</th>
<th>Maintenance</th>
</tr></thead><tbody><tr><th style="text-align: right;">System tests</th>
<td style="text-align: center; background-color: #d9ead3">€</td>
<td style="text-align: center; background-color: #f4cccc">€ € €</td>
<td style="text-align: center; background-color: #d9ead3">€</td>
<td style="text-align: center; background-color: #f4cccc">€ € €</td>
</tr><tr><th style="text-align: right;">Integration tests</th>
<td style="text-align: center; background-color: #d9ead3">€</td>
<td style="text-align: center; background-color: #fff2cc">€ €</td>
<td style="text-align: center; background-color: #fff2cc">€ €</td>
<td style="text-align: center; background-color: #fff2cc">€ €</td>
</tr><tr><th style="text-align: right;">Unit tests</th>
<td style="text-align: center; background-color: #d9ead3">€</td>
<td style="text-align: center; background-color: #d9ead3">€</td>
<td style="text-align: center; background-color: #f4cccc">€ € €</td>
<td style="text-align: center; background-color: #d9ead3">€</td>
</tr></tbody>
</table>

To counter the growing costs, Mike Cohn proposed the [Test
Pyramid](http://www.amazon.com/gp/product/0321579364/ref=as_li_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0321579364&linkCode=as2&tag=verraesnet-20&linkId=BPE4YKYDY3WHOFAB).
The idea is that the majority of your tests should be unit tests, with less focus on the higher
levels.

<img style="float:right;margin-left: 10px" src="http://verraes.net/img/posts/2015-01-05-economy-of-tests/test_pyramid-small.png" alt="Test Pyramid">

In greenfield, advice like “write more unit tests” is easy to follow. Ignoring that advice creates
the sort of technical debt we usually associate with brownfield projects. Those have a very
different kind of test economy. Unit tests are very difficult in legacy code: unless you’re
extremely lucky, the project is big ball of mud, with huge blocks of code and nothing even
remotely resembling a unit that you can test in isolation. You’ll naturally resort to high level
testing. That is often the only option.

## Test Level Migration

The Test Pyramid is a static model of an ideal end goal. In the real world, when dealing with
legacy, we advise to **migrate tests from top to bottom**.

For brownfield, it’s perfectly fine to introduce tests at the level you are most comfortable with,
and that suits the codebase at hand. But high level tests should be seen as a first step. An
inverted pyramid is unbalanced, but you can use the system tests to **put pressure on the test
suite**. We can call this **test level migration**: as the system tests give you more confidence
to change things in your code base, you use this to add more low level tests.

<img style="float:right;margin-left: 10px"
src="http://verraes.net/img/posts/2015-01-05-economy-of-tests/Snow_Geese_Migration-small.jpg"
alt="Snow geese migration"> After a while, more behaviour is covered with low-level tests. Now you
can remove the high level tests, especially those where the maintenance cost is greater than the
value they provide.  ([Yes, it’s ok to delete
tests.](http://verraes.net/2014/12/how-much-testing-is-too-much/)) The balance shifts to the base
of the pyramid.

Migrating tests can be done gradually. The first step is to drop your system tests to the level of
the integration tests. Use the same integration points, such as databases, and other services. The
tests still might break a lot, but at least they don’t break because of changes in the high level
components such as the GUI or HTTP API. The next step would be to isolate integration points and
cover the bulk of the system behaviour with actual unit tests.

Our process for introducing and evolving tests in a brownfield project looks like this:

1. Identify the part of system you want to change.
1. Estimate how expensive adding a unit tests is.
1. If it’s expensive, move up one layer. Can you isolate the test to touch only a small number of
   components?
1. If that’s still too expensive, you move up again and write a test against the entire system,
   using the GUI or an API as the boundary.
1. As the number of higher level tests grows and your technical debt starts showing, find ways to
   refactor the code base, and push tests to lower levels.
1. Get rid of brittle, slow, and unreadable high level tests that test behaviours already covered
   by lower level tests.

## Opposing forces

Testing on brownfield projects always has two opposing forces:

- Adding new test tends to push you to the higher levels of testing.
- Carefully maintaining your test suite tends to push you to the lower levels of testing.

<img style="float:right;margin-left: 10px"
src="http://verraes.net/img/posts/2015-01-05-economy-of-tests/test_economy_forces-small.png"
alt="Opposing forces in the economy of tests">

This is the essence of the Test Pyramid: when you write only high level tests, you take on
technical debt. Sometimes this is necessary, but as soon as you have debt, the clock is ticking.
Interest accumulates, and it becomes harder to remedy the situation. That’s why putting pressure
on your test suite to migrate test levels, pays of in the long run.

## What to migrate

The choice of tests to migrate, is important. You can use the metrics of execution speed,
readability, and maintainability, to identify tests in dire need of migration. Another heuristic
is asking whether the test is at its natural lowest possible level. For example, when a test is
exercising the whole system in order to test a single unit of business logic, it is clear that
this test is unnecessary costly, and should be migrated to the level of a unit test. Leave the
system tests in place that verify if the system as a whole is working, and use unit tests to fix
the most important permutations of the expected behavior.

## Conclusion

For projects with a long life expectancy, investing in your test suite is well worth it. Proper
automated testing is a careful balance. Quickly introduce tests when you need them, and build a
comprehensive, fast, and reliable test suite in the long run. We hope this post can give you some
ammunition to win your team to this idea.
