---
title: Fullstack BDD wrap up
date: 2012-09-15
tags: [post, news, migrated]
layout: post-layout
original: https://everzet.com/post/31581124270/fullstack-bdd-2012-wrapup
---

# Fullstack BDD wrap up

Yesterday we’ve given our first talk with Marcello about fullstack BDD in PHP (yesterday’s talk
was about Symfony2 particularly) world. And i think it was great.

## About the talk

Talk consisted of 2 parts - theorethical and practical. In the first part, the main goal was to
show people importance of SpecBDD and it’s place in BDD stack as we already assumed lot of people
know what Behat and StoryBDD is all about. We’ve put lot of passion and ideas on attendees in this
part, but there was nothing in the first part of talk that we weren’t doing on other conferences
before. And there was always a missing part. On every conference i was talking about Behat, about
it’s place in the development process and everybody tended to agree with me, though i still didn’t
seen wide understanding of fullstack BDD in PHP world. People still doesn’t see BDD tools as
logical parts of their development process. Everybody understands, that it’s awesome to use tools
like Behat, but nobody actually knows how development process with them look like before we’re
starting to teach them with Marcello closely. That’s where second part of the talk came from.

Key idea to understand in the second part of the talk is that our plan was not to show particular
commands or actions your team needs to do, as it’s really impossible to show - things warry from
project to project too much. Idea was to show that fullstack BDD is not only absolutely possible
in Symfony2 applications, but looks like logical, missing link in any development process. In
simple terms, idea was to burn fire in your hearts about the process itself. To show people goal
and force them to seek knowledge.

But yeah, we’ve showed alot in 20 minutes. It could’ve look confusing in some parts as it were
live coding anyway. But we didn’t wanted to show you something abstract or not real. We wanted to
show you real life development process based on BDD. I don’t know if you noticed or not, but we
almost finished (only template was left) one scenario implementation during 20!!! minutes of
life-coding with comments and Q/A session. 20 minutes to write part of application, scenario
(functionally tested) and specification (class tested) for it. We’ve shown on real example, that
“we’re not using TDD, as those tests take too much time” argument doesn’t work anymore. At all!

Main goal of the talk could be described as “unrecoverably infect”. Of course we could’ve just
showed another set of beautiful “BDD in PHP” slides for 1 hour as we did enormous amount of times
before. But we wanted to do something really different this time around - what’s the point of
showing you results of interesting research, that you don’t even know how to apply into real life.
This time we wanted to show you the final result. How BDD looks in real life development. And to
make you hunger about this stuff. If you are, [here’s the next logical step for
you](https://github.com/everzet/fullstack-bdd-sflive2012/commits/master) ;)

## About the tools

We’ve also talked alot about tools and even presented new one during presentation. But there
wasn’t enough time to make really clear reasoning behind those things. So let me do it right now
:)

## The Good, the Bad, the xUnit

From some feedback i understood that we’ve looked like biggest critics of the xUnit out there
yesterday. It’s far from being truth. As a matter of fact, i even said multiple times that
“there’s no problem in xUnit” and “there’s nothing wrong with tool itself - it does the job really
well”. Idea we were pointing out is that xUnit was been created for some particular set of
problems and it does the job really well solving them. Thing is, people just loosing track of what
this particular set of tools were created for and start using it for wrong job. Have you ever
tried to use hammer as your screwdriver of choice? And after that if i’m saying that “you
shouldn’t use hammer for that”, does it mean that hammer is a bad tool? No. It was just created
and optimized for different needs.

What is the problem xUnit tries to solve, you could ask me. Testing your code, i would say.
Existing one! This idea sits deep deep inside any xUnit tool out there, they make it extremely
easy to test/express your units in the assertions and testcases. Code coverage, mocks with fixed
amount of calls - those all parts of the big picture, final goal any xUnit tool tries to achieve -
be sure to notify you about breaking something. That’s the goal. Give you tools to create code
breaking notifications system.

Ok, xUnit was created and extremely useful at testing code. Isn’t it what we need in TDD or
SpecBDD? No, it’s absolutely not. One toolset (xUnit) makes sure your code doesn’t break and
that’s its main goal. Another toolset (TDD, SpecBDD) makes sure that you’re building correct and
logical interaction system between objects in your system. One is aimed on testing something that
is already exist and completely described (at least in the UML or on the paper), another one is
aimed on describing something new. And in this lays the main difference between two. You don’t see
the difference now, just because most of the SpecBDD or TDD tools are trying to provide just a
different syntax without going deeply into understanding their goal. It was even the case with
PHPSpec1, which Marcello was developing for couple of years now. And that’s something that we
wanted to change completely with PHPSpec2. We want to make difference so obvious and clean, that
you could easily see the goal of the tool even without using it (aka “from screenshots”).

## The difference

What happens when you’re running xUnit testcase for non-existing class (and we agreed, that with TDD and SpecBDD we’re describing code before writing it)?

![](/assets/images/fullstack-bdd-wrap-up/phpunit_no_class.png)

Mind if i tell you what just happened? Tool yells at you. It yells because something went
completely wrong in its opinion. It did it’s job really well - it made your life extremely
uncomfortable because you’ve broke something. Problem is, in case of TDD, the fact that something
doesn’t exist or broken shouldn’t be something extraordinary, it should be the way you develop
applications. Instead of yelling at you, tool should talk with you and provide solutions. Because
it knows, that you’re still in the process of finding best design, not testing something complete:

![](/assets/images/fullstack-bdd-wrap-up/phpspec2_no_class.png)

Is PHPUnit a worse tool in this particular case? Yes! Is PHPUnit a worse tool in any case? NO!
It’s just a hammer and you should stop using it as a screwdriver.

You see, goals are different. PHPSpec2 builds a shell-driven conversation with you, because it
assumes you’re not done yet and you need a help:

![](/assets/images/fullstack-bdd-wrap-up/phpspec_verbose.png)

xUnit yells at you, because it assumes you’ve broke something working just freAKING NOW:

![](/assets/images/fullstack-bdd-wrap-up/phpunit_verbose.png)

And here comes an interesting part. What happens when you’re using wrong tool for the job?
Confusion! You’ve heard thousands of times that you’re not doing TDD because you’re lazy or
because you’re not experienced enough. In our opinion, you’re not doing TDD (read SpecBDD),
because you’re feeling incomfortable when someone yells at you every minute. It’s like trying to
do pomodoro with WWII air-strike alarm as a timer. Air-strike is extremely useful during war, but
makes you extremely uncomfortable during your workday if using it as a timer.

Everything in PHPSpec2, including syntax and CLI interface works for its main goal - to help you
describe your application logic. To help you understand how your objects interact with each other
and what job they should do. Does it matter how many times your mock method will be called inside
object? In some cases - yes, in most cases - no. That’s why PHPSpec2 will never ask you this
question explicitly. Because you don’t need to answer it during design phase in most cases.

Everything in xUnit, including syntax and tools around works for its main goal - to help you
understand that your applicaion is not broken anywhere. Does it matter how many times your mock
method will be called inside object? It doesn’t harm at least, as you already know this number
(code is written, right?) anyway. and if this number goes up/down, it could potentially lead to a
bug, right? So that’s why it forces you to answer this question every time. Because in this case,
it could be important.

There is a huge difference, that most testing tools were hiding from you for years. Not anymore!

## Wrap up of wrap up

During the talk we’ve shown lot of concepts to you, but most important one was - fullstack BDD is
not only possible, but extremely awesome in PHP if you’re using it with right tools. And if you
were confused or missed something during the process, that’s exact reason why [this
repo](https://github.com/everzet/fullstack-bdd-sflive2012) was created for. Follow commit messages
and evangelize BDD on your working place. And see you on the next conference ;)

