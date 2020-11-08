---
title: How to tackle technical debt
date: 2016-08-04
tags: [guide]
layout: post-layout
originalUrl: https://inviqa.com/blog/how-tackle-technical-debt
---

# How to tackle technical debt

_**This guide was created by Alistair Stead in collaboration with me and Marcello Duarte and
written by Jennifer Lambourne for inviqa.com, back in the day when I was working for Inviqa. The
guide is still [published on inviqa.com](https://inviqa.com/blog/how-tackle-technical-debt),
which is canonical source for this guide. This is just a backup copy in case the original ever
goes down.**_

Dealing with technical debt is not fun. No engineer pursues a career in software engineering for
the love of cleaning up someone else’s spaghetti code and the eternal frustration of missing
documentation. Similarly, no technical director enjoys standing in front of their boss and
explaining why their systems can’t cope with the demands placed upon it.

So what exactly is technical debt? The term, coined by Ward Cunningham, describes the cumulative
consequences of cutting corners in software development. In his seminal book on legacy code,
Michael C. Feathers sums up the angst of technical debt perfectly:

> It conjures images of slogging through a murky swamp of tangled undergrowth with leeches beneath
> and stinging flies above. It conjures odors of murk, slime, stagnancy, and offal. Although our
> first joy of programming may have been intense, the misery of dealing with legacy code is often
> sufficient to extinguish that flame.
>
> Michael C. Feathers

For businesses too, migrating or upgrading legacy systems is constantly cited as one of the most
challenging and urgent issues. While investment is poured in digital transformation strategies and
complex customer engagement programs, behind the scenes many businesses rely on outdated systems
built by teams who never could have predicted the demands that would be placed on their
technology.

But software always has a very specific set of goals behind its development: to support the
business and people for whom it is designed. The interesting thing about most legacy systems is
that they do exactly that: they are functional and support the businesses and people that use
them.

In this regard, legacy systems are even more valuable because they have already proved the core
idea behind the project and provide a working solution for the most boring parts: commodity logic.
The problem with legacy software is not necessarily that it is bad software by today’s measures,
but that it may be bad by tomorrow’s. Eventually, poor code quality and malpractice will catch up
with a system increasing the risk it places on a business.

Technical debt, in other words.

So how can you manage and deal with technical debt? How can you begin to update the code into
something maintainable, healthy and valuable to your business – all while sustaining the
day-to-day operations your business demands?

This guide is an attempt to answer some of the above. It has been written by practicing software
engineers who tackle legacy systems on a daily basis – relics of mishandled projects from previous
development agencies or simply bad practice from in-house teams.

This guide isn’t intended as a definitive article. The methods and processes of managing technical
debt are always open to discussion and improvement, but we hope that this guide will equip
enterprises and individuals alike with the understanding that there is merit in your system’s
madness and that, however horrific your codebase, all is not lost.

## Understanding technical debt

In its day-today use, legacy has come to mean something ‘left or handed down by a predecessor’. In
engineering, this phrase has come to mean a lot more. In Working Effectively with Legacy Code,
Michael C Feathers described legacy as code that is not covered with unit tests. Some software
engineers agree with this definition, others not so much. You don’t have to venture far into
StackExchange to find the debate.

From a business perspective, legacy systems are those which may still be operational, but have
been built using designs or processes that no longer offer value to the business – thus creating
technical debt. An old ecommerce site can remain transactional, for example, but poor UX and
performance issues can mean the site fails to convert customers and online sales are poor.

Behind the scenes of that ecommerce site, however, is probably a technical director and
development team screaming in frustration at a code base that repeatedly refuses to play ball.
They may face a code that reads like hieroglyphics, the original team having long-departed with
any Rosetta Stone documentation.

### Technical debt

When the subject of legacy appears, the term technical debt isn’t usually far behind. Coined by
Ward Cunningham, technical debt is an unavoidable by-product of engineering essentially caused by
developers taking shortcuts. While that may sound unacceptable, shortcuts and efficient
programming save time and money on an initial build that a developer may never have dreamt would
still be in operation today.

The issue comes when those shortcuts catch up with a system. Eventually the accumulated debt has
to be repaid. Paying off that debt means understanding which corners have been cut and why. That
debt needs to be removed when the cost of working with it from one day to the next outweighs the
cost of fixing it, or when the system holds you back.

Ward Cunningham has a great video explaining the origin of the debt metaphor if you wish to know
more.

### Entropy

There may be a lot of reasons why your organisation has unwieldy legacy technology. You may have
inherited an application from a departing development team, acquired new systems through a merger,
or simply have to use software developed in the 80s that for some unfathomable reason is still
propping up your finance team.

Estimating the cost of legacy technology is complex, but the concept of entropy is a good place to
start.

In thermodynamics, entropy is a measurement of disorder. Coming from a Greek word for
transformation, entropy can only increase or remain constant in an isolated system. The laws of
thermodynamics state that entropy in the universe will always increase.

Entropy is calculated using relative rather than absolute terms and so the entropy of a system is
a measurement in terms of the transformation the system has experienced to get to its final form.
If there are a lot of changes and outside energy sources affecting the system, entropy (disorder)
increases.

It isn’t hard to see why the concept of entropy has been adopted by the software engineering
community. Every project has its own degree of entropy and is subject to increased disorder thanks
to the transformations forced upon it every time a line of code is touched.

But software development doesn’t often involve an isolated system. Your project is most-likely a
complex system with many variables affecting entropy. In your team, an example of this may be the
skill level of your developers. Their varying technical abilities will have a varying impact on
the system’s entropy and in an ideal world, we would be able to calculate entropy based on these
variables and be able to predict how quickly your codebase will deteriorate.

Thanks to the sheer number of variables, it is almost an impossible calculation, but it’s helpful
to understand how disorder can grow within a system and quickly leave an organisation with an
unmaintainable application.

In their book, The Pragmatic Programmer, Andy Hunt and Dave Thomas explain entropy another way:

'Picture a city. As well as tall, beautiful, pristine glass skyscrapers, there are derelict and
down-trodden buildings. Hunt and Thomas suggest that areas of decay can stem from a single broken
window. That window remains unfixed, the city inhabitants sense the local council’s unwillingness
to fix the window and so they become negligent. They litter, they damage more buildings, and so on
and so forth. Eventually the area is abandoned and “becomes damaged beyond the owner’s desire to
fix it"'.

The 'Broken Window' theory has much further reaching applications than you may realise. Police
departments and local councils have applied the theory to derelict areas and begun to fix the
small stuff – to fix windows and clean graffiti in order to keep disorder levels down.

Hunt and Thomas argue that the theory should be applied to software engineering. Sweat the small
stuff. Ensure there are no broken windows in your codebase and prevent further damage.

### The human factor

The source of all legacy systems is humans. Your team, whether you question it sometimes or not,
is made up of humans and they each work differently from each other. They make mistakes, they
correct mistakes, and then they try again until they find an answer that works. Then they begin
the cycle again.

But engineers often have a bad habit of putting pressure on themselves to abide by mystical rules
known as 'best practices'. 'Best' is often defined by what worked for one person before it is
distributed from the top down as a go-to method to achieve the same result. Best practices work
well for simple problems, but when working with complex systems, they can sometimes hold teams
back.

A constant attempt to apply 'best practices' can stop innovation and disparage your team from
finding a solution that is fit for purpose. And after all, aren’t we supposed to be building
software that matters? This especially applies if your team believe they must blindly follow set
practices without knowing how to implement them with confidence.

Some of your team may try for a time, convinced that these practices are the right approach, and
quickly fall back into a more comfortable way of working. Most of the time this just causes more
confusion – and increasing entropy.

There is often a pressure for developers to work fast – to churn out feature after feature at an
extreme pace in order for the business to achieve its targets. Sometimes fast is good. A short
burst of activity can propel a team and a business along, but the team must be given downtime
afterwards. A constant pressure from the business for the engineering team to deliver more, faster
can be detrimental not only to the quality of work you produce, but also your team’s health.

## Identifying a legacy problem

### Within your code

Typically, a legacy application will show the following characteristics in its code base:

* Inconsistent or/and confusing naming
* Logic duplication all over the codebase
* Different application layers refer to each other without coherence
* Application is dependent on outdated technologies, libraries or frameworks
* Insubstantial or non-existent documentation
* No tests

### Within your team

When working with your team, legacy is easier to spot: your team works for the code rather than
the code working for them.

If your technical team has to steel themselves for hours of bug fixing to be able to add a
feature, your code is a liability and is legacy. If your development time is largely spent
struggling to accommodate change and fixing knock-on effects elsewhere in the codebase rather than
delivering the best feature for the business and user, you have a legacy problem.

The battle against legacy code often has an effect on the team itself. Given the choice of working
on a green-field project or fighting someone else’s spaghetti code, engineers will generally
choose the former. Hiring and retaining engineers on legacy projects can therefore become a
difficult task, especially if your team lacks the motivation to constantly rework unmaintainable
code.

If you struggle to attract new talent to your team or to keep your team engaged with a project,
the state of your legacy system may be a contributing factor.

### Within the business

In a business context, legacy systems can be identified by what they don’t allow the business to
do rather than what they can.

If the thought of implementing a new feature makes your heart sink and you regularly have to
explain to your board/stakeholders/marketing manager that what looks like a simple change could
take weeks, you probably have a legacy issue. If you find yourself having to say 'no' to requests
from the business because you know your system can’t cope, you definitely have a legacy issue.

Similarly, if you feel that your pace of engineering is simply unsustainable, you could be sliding
into legacy. It’s important that your engineers recognise that working at speed is sometimes
necessary, but can communicate the implications and consequences of this to the business. In turn,
the business needs to allow the technical team the time and space to work sustainability without
any codebase or any developer burning out.

## Why is legacy such a problem?

### Hardness of change

Software engineering is a competitive market. Every day, a new disruptive service shows up that
tries to improve something that somebody else already does well. This creates a very harsh
environment for the development of software products; products need to constantly change and
evolve in order to avoid losing market advantage to new competitors. But there comes the biggest
issue with legacy software: it is extremely hard to change.

Legacy software engineers spend months, even years, adding more and more features to the product
by simply injecting new logic until the point where injecting new logic becomes so risky and
difficult that adding even the simplest of features might take weeks.

If the risk and complexities associated with change continue to grow, eventually the cost of
adding a new feature will greatly outweigh its value. In time, the project simply becomes
unsustainable and the business will start to lose market advantage to new players and face a slow
and painful death.

In balance with the cost of change is the concept of cost of ownership, a term that is
increasingly used in the software industry. In this context, ownership means taking responsibility
for the code, and for any changes made to the code base.

### Lack of flexibility

Sadly, the increasing cost of change is not the only problem with legacy software. Adding features
by injecting new logic also means that new and old logic become hard to modularise or configure.
If the business wants to separate and sell a particular part of the business logic as a paid
add-on, for example, a development team will usually find it impossible because everything is so
interlinked. Likewise, a user wanting to configure the system to fit their particular needs will
also struggle because it cannot provide the flexibility they need.

### Team development

It can also get harder to find and hire skilled engineers that actually want to work with the
technology you have. A legacy system isn’t a thrilling greenfield project, it requires developers
to fix others’ mistakes rather than deploying glamorous new features. Over time, existing
engineers on your project can start to lose interest and this presents its own problem. Without a
sufficient number of people to support your system, it will fall deeper into repair and your
engineers may often leave with valuable knowledge of how the system operates. The situation can
quickly become a downward spiral with no end in sight.

## Getting business buy-in

### Explaining the problem

Software engineering is dogged by poor communication, often between ‘the business’ and the
development team. The business often fails to have a realistic understanding of the capabilities
of the development team and engineers often struggle to communicate the technical constraints of a
system.

Trying to explain the value of investing in legacy systems can be therefore be difficult,
especially if, on the surface, the system appears to be working as required. As a technical
manager, you may also have to face the dreaded 'magpie effect'. New, shiny systems can promise the
world, and it can be difficult to draw attention (and budget) to a curmudgeonly old application
that needs some TLC. So how can you explain the value of fixing what you’ve got?

Here are two metaphors we use to explain the struggle with legacy systems:

#### Tetris

Most people are familiar with the retro game Tetris. Puzzle pieces fall down the game screen and
the player must rotate them in order to create a line of interconnected puzzle pieces. When nicely
aligned, a line disappears, leaving room for more puzzle pieces. If the player fails to align them
properly, the puzzle pieces mount up and eventually reach the top of the game screen causing the
end of the game.

Applications work in a similar fashion. If a codebase is filled with errors, there is less room to
add more features, and critically there is less room to manoeuvre within the existing system. A
legacy application is a badly-played game of Tetris. Your system is starting to stack up and
eventually you will have no room to manoeuvre at all. Game over.

#### The restaurant analogy

Earlier this year, Matt Wayne and Aslak Hellesøy gave a talk at the Behaviour Driven Development
(BDD) user group in London. When describing legacy systems, Wyne and Hellesøy used a restaurant
analogy.

You open a restaurant and begin cooking and serving food. All is well, but dirty pots and pans
quickly accumulate. Over time, your ability to serve food decreases. You have less space to work,
fewer tools to use, and bacteria in the restaurant starts making guests ill. Your ability to
function as a restaurant is impacted and the number of diners visiting your restaurant begins to
slow as it cannot deliver the service or food they expect.

It isn’t often that a software application is going to make users ill, but applying the analogy
above to a legacy project should strike a chord. Without cleaning up your system as you work,
you’ll quickly find yourself unable to handle requests from users and your business will begin to
suffer as a result.

### Selling the impact

After you’ve convinced your boss of the importance of your legacy systems and the horrors of what
can happen if they are left to rot, it’s an opportunity to explain what improvements can help your
business achieve.

A good system works for the business. Heaving an archaic system out of its dastardly ways isn’t
easy, but the end result is that your software will do more for its bottom line. If you’re a
for-profit organisation, that could mean more sales, for a charity, that could mean more
donations, and for a public sector organisation that could mean more awareness, registrations
or community contact.

Identifying what a system refresh will allow the organisation to achieve is a sure fire way to
secure the budget you need to get to work updating your legacy systems.

## Updating legacy systems

The common approach to legacy software is to pretend that it doesn’t have much value and is dead
in the water. Following this train of thought, the obvious next step is to scrap the system, learn
from your mistakes, and build a completely new system from the ground up. But that isn’t always
the most cost-effective and rewarding option.

### Rewrite

A rewrite is a common response for a legacy problem. It can be incredibly tempting to throw your
existing system on the scrap heap and start again. The problem with this approach is that together
with throwing away everything that the legacy system does wrong, you’re throwing away everything
it does right, which is a huge disservice to both delivery and business teams in your
organisation.

A rewrite also comes at significant cost. First of all, the business ends up paying for features
twice – once when the system was first built, and once when you rewrite. Another significant cost
is the so-called cost of delay. This defines how much money the business will lose by not
implementing a particular feature in time.

For example, if you have a feature that would generate £10,000 of additional revenue a month if it
were put into production tomorrow, then adding this feature in 12 months time would leave your
business without the £120,000 it could have made. By undertaking a complete rewrite, you not only
pay the cost of the redevelopment itself, but also miss out on the revenue generated by new
features that could have been developed within that time.

Where things get more interesting is when a business realises the incredible costs of delay that
are associated with rewrites. A common reaction is to create a separate workstream which has the
sole purpose of adding features to the legacy system while a new system is in development in a
separate silo. This creates a vicious cycle in which the new system starts playing an infinite
‘catch-up’ with the ever-so-slightly changing legacy system.

With all of the above in mind, perhaps the most controversial thing about rewrites is that
sometimes they do work, which makes the decision of whether to rewrite particularly difficult. But
that success does come with a catch. Rewrites only work in cases where the cost of development and
delay are considered affordable for the business. These are usually small to medium-sized projects
with a potential rewrite cycle that can be measured in months. If you have one of these systems,
consider yourself lucky; most modern systems only increase in complexity meaning their rewrite
cycle is much longer.

### Business-focused rewrite

The biggest challenge or problem with legacy systems is their reluctance to change. Legacy systems
aren’t bad because they don’t support users’ needs now, they are bad because they can’t evolve
together with these needs. One of the most critical reasons for choosing not to rewrite a legacy
system as a whole is that your team will spend tremendous effort rebuilding some elements that
were working fine in the first place, effectively eating time that could’ve been spent building
real differentiators.

When approaching work with a legacy system we need to maintain a clear focus on the goal and the
value we are intending to add to the system. Then we need to identify where there is waste and
propose measurable experiments to deal with this.

A Lean approach to dealing with legacy is to identify where change is expensive, but also where
improvement will have a noticeable impact on reducing waste. We need to understand which areas of
the legacy system are used the most and which areas change the most. Based on this, you can
undertake a focused rewrite that improves the areas of your system that offer the most value to
your business.

The core concept of a business-focused rewrite is to separate commodity features (that never
change) from differentiators (that constantly change) and focus on rewriting or tackling only
differentiators, leaving the commodity logic alone. It builds on the simple idea that if you are
able to identify the direction and rate at which business needs to change, you should be able to
identify which areas of the system would need to change in order to support that business
progress.

By identifying those changing areas you can pretty much predict where and how your system will
need to evolve and focus your efforts just on these areas, isolating and leaving everything else
as it is.

In order to identify changing features and direction of the business we use the same practices we
use for greenfield projects - business goal definition, impact mapping and other deliberate
Discovery tools. By questioning the direction and needs of the business we effectively identify
the pressure levels businesses will apply to the different parts of the system, effectively
enabling us to progress in areas we need to progress and invest minimally into areas we don’t.

## How to continuously deliver

To start begin dealing with your legacy codebase you need to start a programme of continuous
improvement or Kaizen.

The term Kaizen is derived from two Japanese characters: kai, meaning 'change' and zen meaning
'continuous improvement'. Eliminating waste in the value stream is the goal of Kaizen. The PDCA
(or PDSA) Cycle is the Lean working structure the system for executing Kaizen. The acronym stands
for:

* **Plan**. Create a plan for change, identifying specifically what you want to change and how to measure the impact. Define the steps you need to make that measurable change, and predict what positive results will look like.
* **Do**. Carry out the plan in a trial or test environment, on a small scale, under controlled conditions. This would ideally be using Continuous Delivery and deploying the changes into a realistic context.
* **Check or Study**. Examine the results and verify that you’ve improved the process. If you have, consider implementing it on a broader scale. If you haven’t improved the process, go back and try again.
* **Act**. Implement the changes you’ve verified on a broader scale.

Sadly in most cases just identifying areas of change pressure in the legacy system is not enough
as those are often deeply linked with the areas that don’t change. That usually means that you
can’t rewrite one without rewriting another or without putting some upfront effort in separating
two.

There are a multitude of ways to untangle this purely technical ball of yarn. Our preference is
one of two very different methods that have worked for us in many cases – refactoring-based and
two-systems approaches.

### Refactoring-based approach

Refactoring is the act of changing the structure of the code without changing its behaviour. This
method only works if you can ensure and prove that the initial behaviour didn’t change after you
changed the structure, which basically means you must have comprehensive test coverage before
attempting to do the refactoring.

What if your system doesn’t have tests, like many legacy systems? The answer is to add tests
retrospectively, preparing the system for upcoming changes. Keep in mind that you don’t want to
cover entire system with tests because the entire system doesn’t need to change.

There are generally four possible types of breakages that could occur when applying changes to the
legacy system:

1. Breakage in the critical path of the system – when change in some unrelated part of the system
   causes a critical failure in the core user journey or business-critical part of feature set.
1. Breakage in the changing set of functionality – when change in the particular functionality
   breaks already established behaviour of that functionality.
1. Breakage in the logically connected set of functionality – when change in the particular
   functionality breaks already established behaviour in the functionality that is logically and
   explicitly connected to the changing feature-set.
1. Breakage in non-critical, not connected set of functionality – when change in some unrelated
   part of the system causes failure in non-critical part of the system.

The first thing you need to understand is that you will never be able to eliminate all breakages
during the change of non-tested system – you will always have these, no matter how much time you
spend on covering this system with tests retrospectively. So the goal is not to attempt to prevent
all of the breakages during change, it is to minimise breakages in categories 1-3.

The first step in mitigating the risk of breakages in previous behaviour is to document and cover
that behaviour with test automation. That’s where behaviour-driven development (BDD) fits well
with this approach. BDD helps you to both share the understanding of previous behaviour and
automate the verification that it still works.

So before attempting any size of any change, you need to have conversation and automation exercise
that covers the currently active behaviour of critical path and the area you’re attempting to
change. Essentially, you need to have a conversation with key business and technical stakeholders
to discuss the current behaviour of the system, and then automate it afterwards using an
end-to-end approach. End-to-end tests are slow and fragile, but sometimes are the only way of
testing existing behaviour in legacy systems.

After discussing and automating existing behaviour, we may be certain that our changes will have
limited impact on the system, so we could start changing internal structure of code, preparing it
for change.

We started by saying that in most legacy systems it’s very hard to rewrite or make amends in parts
that need to change, because these parts are interlinked with parts that don’t. The next step
therefore is to separate the piece of logic that we want to change from the logic that we want to
stay as it is – we must refactor. Part of this refactoring must include replacement of slow and
fragile end-to-end tests with fast and stable unit tests as soon as that becomes possible.

Refactoring is essentially a preparation for change. If refactoring is done right, then the
introduction of new behaviour should become almost trivial. When introducing new functionality you
can continuously run tests, checking that the change doesn’t break existing logic. Of course, you
also need to make sure that all the new functionality is covered with tests to save yourself from
additional effort in the future. The easiest way to add tests to the system is to start with them,
automating the discussion you’re having with the business about the change before applying the
change itself.

The positive side of this approach is that you improve the existing system as you go, and even
though you avoid touching commodity logic as much as possible, separating it into separate modules
usually also has positive impact on its readability and stability. The downside to this approach
is that it requires much more investment upfront. Even though the amount of investment required
decreases over time thanks to the increased changes you make, the financial factor alone is
sometimes enough to scare a business out of making the investment.

### Two-systems approach

Another approach to legacy improvements is based on the idea of the ignoring legacy system and
building a new codebase alongside old-one, and then using smart routing techniques to direct
people between two systems coexisting. This approach became viable with the growth of web-based
software.

The basic premise of the two-systems approach is that you start building new system alongside the
old one, never turning the old one off and just gradually migrating development efforts towards
the new codebase. This requires both systems to share access to the same infrastructure stack.
This allows you, after small initial upfront investment, to introduce changes and optimisations
mostly without touching the legacy codebase.

There are two key steps in preparing the architecture for the two-systems approach to work:

1. Establish the second system alongside the old one and configure the routing mechanism (usually
   reverse-proxy) to direct traffic to one or another system in accordance to the progress.
1. Share the infrastructure access between two systems, basically making sure that both have
   access to the same set of databases, APIs and sessions.

The positive side of this approach is that it requires a minimum amount of initial preparations
and you could quickly jump into serving accumulated business needs. The downside of this approach
is obviously the doubled cost of the systems maintenance and general architectural complexity of
the system.

It is also worth mentioning that this approach has increased risk in comparison to the refactoring
as the new system (if handled incorrectly) could quickly become a second legacy platform. In that
case you’ll have not one, but two legacy problems at hand. As any approach with decreased costs at
a cost of increasing risks, it should be handled with extreme caution.

## Avoiding legacy going forward

Legacy is primarily a technology problem, and the most obvious solution for a technology problem
is to apply industry-known principles such as SOLID.

SOLID (Single responsibility, Open-closed, Liskov substitution, Interface segregation and
Dependency inversion) comprise the five principles of class design. When used with an extensive
test suite (see: Why your test suite sucks), they can help you avoid sliding back into the
unwieldy legacy system you have escaped.

But legacy is not just a technology problem. We know that legacy is created by developers as a
result of cutting corners that may have seemed sustainable at the time. The problem comes when
those corners and their associated debt catch up with a project. Taking shortcuts is just a
secondary cause of legacy. Behind that is often a pressured development team feeling the need to
take shortcuts and cut corners due to meet demands of a business.

In order to avoid getting back into legacy, the business needs to understand that there is a
trade-off between the speed of feature delivery and feature delivery sustainability. An
engineering team is well-qualified and skilled enough to deliver features fast, but not for long.
A more effective way to deliver features without pushing your team to the grindstone is to deliver
features sustainably. It’s a balance that both business and technical teams need to find, and the
only way to do that is by having healthy communication between both departments.

Your engineers should ask: How fast does the business need to go? Your business should understand
that going fast is an extreme scenario and isn’t the only option.

Sustainability means limited corners will be cut, ensures no team burns out early, and with the
right communication, ensures that both technical and business teams fully understand the capacity
and requirements of the other.

## Conclusion

You can’t run from legacy. The longer you run without looking back at your code quality, the
harder it is to recover from the sprint. The solution is simply to find a balance on when to start
running, and when to improve software at hand. Preferring speed over sustainability is an
exception to the normal development practice and should be treated as one by both technical and
business sides of the company.

Don’t be quick to write off your legacy system. With the right discussions and the right approach
you can turn the beast into something beautiful.

