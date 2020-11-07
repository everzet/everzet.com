---
title: Maximum Feasible Miracle
date: 2019-06-26
tags: [post, stakeholder-whisperer, migrated]
layout: post-layout
original: https://stakeholderwhisperer.com/posts/2019/6/maximum-feasible-miracle
---

# Maximum Feasible Miracle

<img style="margin-left: auto; margin-right: auto;"
src="/assets/images/maximum-feasible-miracle.png"
alt="Maximum Feasible Miracle">

> When a distinguished but elderly scientist states that something is possible, he is almost
> certainly right. When he states that something is impossible, he is very probably wrong.
> — Clarke’s First Law by **Arthur C. Clarke**

Current technological constraints heavily influence many of our product decisions. When figuring
out the minimum in your Minimum Viable Product takes too much energy, consider temporarily
discarding all of the constraints. Later, incrementally reintroduce them back, monitoring the
impact on the product. Exploring product without constraints allows your team to reconnect with
the underlying customer behaviour and identify both smaller and better ways to serve it — the ways
hidden behind years of bad memories about intractable problems.

The technological landscape is continuously evolving. New tools and frameworks pop up every day.
The problems that before were considered hard or even impossible to solve, suddenly become
trivial, thanks to the constant stream of new platforms and tools. If what’s possible is being
redefined every day, the day to day decision-making ends up being based predominantly on what was
possible yesterday, not what is achievable now.

The human mind also [likes predictability, a lot](/posts/2016/1/innovation-slider). So much so
that we easily fall into complacency around previously identified limitations. When you find that
something is impossible to do, the hard way, you unconsciously file the challenge under
“insurmountable”. When the problem inevitably gets a solution, our mind becomes a blocker,
stealthily protecting us from repeat disappointments at the cost of stagnation. Over the years,
the mind builds layers of these intractable problems, making our decision-making even more biased
towards the past long gone.

## Designing A Miracle for A Need

I have a trick that I use during gruelling product planning sessions. I call it **Maximum Feasible
Miracle**. In planning, good teams usually focus on searching for the smallest possible
combination of features to fulfil a small, but visible part of the target need. Instead, I would
ask them to clearly state the target need and search for the smallest, most magical product, that
adequately addresses the need — the more impossible the product, the better. I task the team to
pretend they are wizards and design the best digital elixir they can imagine. I ask them to find
and define a _Miracle_.

Let’s say you are a member of a product team planning incremental delivery of an online product
shop. When defining the scope of the build, you would naturally start talking about
authentication, administration, product listing, product search, basket and checkout capabilities.
If you are using the [User Story Mapping](https://www.jpattonassociates.com/user-story-mapping/)
format, you would put the activities into the map backbone and start exploring individual features
within each activity to build an incremental backlog. How much of search can we get away with as
the first smallest increment? How much of the checkout functionality do we need to support a
necessary purchase? These conversations become very heated very quickly. After all, isn’t all this
functionality a market standard? Surely we need all of this in the end.

However, what is the ultimate miracle version of the webshop? What is the customer need that we
are trying to fulfil here? The customer either wants to purchase a particular product as a result
of a decision they already made or they want help in making the decision. If we focus on
purchasing a specific product as our target need, what is the magical software concoction to
fulfil it? A mind-reading, single-product landing page comes to my mind. You type in the domain
name into a browser, and the exact product you want appears in front, read straight from your
mind. Underneath the product is a single button to purchase. Clicking on the button works out the
address to which you want the product delivered, the bank account you want to use and all the
credentials required, effectively committing the purchase. Let’s say we plan to implement all this
by utilising a series of mind-reading services AWS announced just this morning (they might not
have).

## Maximising Feasibility, One Constraint at a Time

Besides being a scary proposition, mind-reading and zero-interaction banking platforms are not a
reality (yet?). So what is the value of coming up with this imagined solution that we can not
deliver? As with many things, the value is in the journey, not the destination. Creating a product
with all the reality constraints stripped allows us to see the need we are trying to support.
Granularly reintroducing constraints then allows us to individually evaluate the impact of each of
them on the solution and the need. It allows us to look at the problem, the solution and the
limitations, without taking any of them for granted. It also allows us to find new ways of
addressing the need.

We can not yet read minds to identify the desired product. That’s a constraint we are introducing
back and a piece of magic we now have to remove. We have to ask the customer which product they
want. However, what if instead we decide to sell a limited set of products and show all of them
straight on the landing page or, perhaps, pick a single random one on each customer’s visit?
Alternatively, maybe, we add a single search field, leading customer to a single product page, a
la Google’s “I am feeling lucky”. If the constraint is that we do not know the product on a
customer’s mind, what are our options? Surprisingly, faceted, paginated search results interface
does not always end up being the first pick.

The interface to extract bank account details from the customer’s brainwaves is not widely
available yet. That is another constraint we are reintroducing. Do we have to ask a customer for
his bank account details through a complicated checkout process? What if instead, we use Amazon
Pay, Apple Pay or Google Pay, resulting in just a single button to purchase? Also, customer
account and history? We can explore getting it through the above integrations too. If the
constraint is that we need to allow customers to commit purchase, what are our options? Asking for
customer’s bank account details is not the only option on the table anymore.

A single-page, random product shop with an Amazon Pay button to commit the purchase, sounds
scarily close to our wacky Miracle. We just found our _Maximum Feasible_ Miracle! Admittedly, this
exercise is unlikely to unfold in this exact way for the majority of your webshop planning
sessions, but it is more than possible for you to discover different, creative routes to the need
fulfilment. At the very least, it might help you generate options for delivering the original
scope more incrementally.

## Planning for Magic

> Any technology distinguishable from magic is insufficiently advanced.
>
> — Corollary to Clarke’s Third Law by **Arthur C. Clarke**

We often bring large amounts of personal bias and baggage into planning sessions. Over years of
practice, it gets hard to see the tree of need behind the forest of widely-accepted practices. For
an industry that continually strives to solve the unsolved, too many limitations of the past seem
to influence our decisions today. It is then of no surprise that many products and solutions we
end up delivering are carbon copies of each other. Reused constraints bread reused decisions.

One of the simplest ways to fight biases is to shine a light upon them. By removing and then
incrementally reintroducing individual constraints, we are exposing them to critical thinking. It
might feel like we are retreading the old grounds or reopening the old wounds, but only by
reexamining the past can we hope to improve the future. One of the commonly accepted roles of
software is in the opening of new doors. Perhaps, it can also help us reopen the doors
unintentionally closed.

Maximum Feasible Miracle is just one approach to help expose and explore hidden constraints. Gojko
Adzic, in his book [Specification by Example](https://gojko.net/books/specification-by-example/),
introduces a different version he calls Bug Driven Development. He would start planning from a
single screen, asking stakeholders to file verbal “bug requests” about the missing functionality.
It works very similarly to the approach in this article. I’m sure there are others. Maybe you have
your own. Leave a comment below if you do or if you find the approach a useful addition to your
toolbox.
