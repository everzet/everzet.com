---
title: With B for 3
date: 2013-06-30
tags: [post, news, migrated]
layout: post-layout
original: https://everzet.com/post/54277235902/with-b-for-3
---

# With B for 3

Today is a third birthday of Behat. Exactly three years ago I did first commit to Behat
repository. And it was quite a ride, wasn’t it?

## Where we (community) are

3 years is quite a short time for a tool (PHPUnit is on the market for at least 10 years) But we
achieved quite a lot in that time! We have delivered tens of BDD talks across the world, written
tens of commercial products using it and even driving development of OpenSource [e-commerce
framework](https://docs.sylius.com/en/latest/bdd/index.html) using BDD. Damn, even Drupal community now talks about awesomeness of BDD and Behat. Isn’t that an achievement? In community that was bashed about poor software quality for years…
Well, what can I say? Empire strikes back!

## Community

All this wouldn’t be possible without amazing community of users and contributors. 42! people
contributed to Behat over its lifetime including headrevision, davedevelopment, robocoder, stof
and many-many more. And if you think that it’s my personal project, you’re wrong :) This third
year in a row this community looks better than ever and that’s every single contributor
achievement. Thank you all for that! And keep doing that awesomeness with doubled effort! I’m
counting on you, guys…

## Family

Talking about people without which this all wouldn’t be possible, I can’t avoid talking about my
lovely wife - Tati. Without her, all this craziness wouldn’t ever become true! Simply because I’d
die of stress, loneliness and starving long before v1.0 release :) She’s the biggest driver and
supporter behind everything I’m doing and pretty much the reason why I’m doing all that.

Thank you, honey, you’re one of the biggest Behat development supporters out there!

## What's next

So, what’s next? First of all, new website is right aroudn the corner with much bigger emphasis on
community and extensions. Support for extension self-publishing on the behat.org will become a big
part of it.

Second, and even more important, be prepared for more coolness (with minimal amount of BC breaks,
of course). In the next month I’ll push the first preview release of vThree.0. What’s there? Well,
three of the most requested features by the community:

1. Multi-contextual runs with support for per-tag, per-directory and per-role context classes.
   This “importance of the role” mantra I was always preaching will finally become possible as
   each role will eventually be able to have own steps dictionary.
1. Multi-bundle support for Symfony2Extension. Finally you’ll be able to test all your project and
   3rd-party bundles in one run. Yay?
1. Multi-worker support. Which is basically an ability to distribute your single feature suite
   testing across multiple CPUs or even machines, combining output on one machine.  Those changes
   pretty much required from me a rewrite of the testing core, which is now sort of hexagonal. So
   even though there wouldn’t be a lot of those, there will be BC breaks.

BC breaks are bad for community. I learned that a hard way :) So, in order to neglect upcoming BC
problems, in coming weeks I’ll also release Behat v2.5.0. This will be the first Behat LTS release
with 2 year bugfix support cycle. That will hopefully give you calm about your existing suites ;)

Hope all this stuff will make you as happy as it makes me, guys. Crazy times ahead!

## Thank you

Once again, I wanted to say thanks to amazingly vibrant community behind Behat. Without you,
nothing of this would be possible.

This is my personal “thank you” and congratulations for our achievements! Tomorrow we’ll have
professional “thank you” from Inviqa with couple of surprises. Stay tuned!

