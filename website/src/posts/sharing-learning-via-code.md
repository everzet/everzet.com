---
title: Sharing Learning via Code
date: 2019-06-07
tags: [post, stakeholder-whisperer, migrated]
layout: post-layout
original: https://stakeholderwhisperer.com/posts/2019/6/sharing-learning-via-code
---

# Sharing Learning via Code

<img style="margin-left: auto; margin-right: auto;"
src="/assets/images/sharing-learning-via-code.png"
alt="Sharing Learning via Code">

When you build a new feature as a team, and it requires much new learning, do not hoard new
knowledge in your head. Instead, incrementally commit each unit of learning into working code.
Hide that partial logic behind a feature flag. The feature would be incomplete, but
work-in-progress outputs expose meaningful and demonstrable progress. To increase the team’s
awareness of outputs, add links into the feature tracker or documentation.

Committing and exposing the intermediate learning through code helps to spread the knowledge
within the team faster. Problems get discovered early into implementation instead of much later.
Moreover, the need for comprehensive documentation decreases as knowledge sharing through code and
collaboration increases.

During collaborative development, the objective of learning is not for an individual to gain new
knowledge, but to reflect the learning in code. Individual’s study reflected in code is the
learning shared with and enabling the entire team.

## The experiment

I noticed a while ago that many teams are approaching spikes (tasks dependent on answering a
question or gathering new information) similarly. They would assign a spike to an individual
developer, who would disappear in documentation ocean for days, until eventually resurfacing with,
hopefully, a meaningful insight. In almost every case, the crucial learning that leads to the
insight ends up hidden from the rest of the team.

As someone who values incremental delivery and design, a couple of years ago, I started looking
for an alternative approach. I asked one of my teammates to help me design and run a small
experiment to try increase number of feedback loops within spikes.

We chose a story (feature) about integrating the product with a third party API. At this point,
the team did not have experience of working with the third party in question and was not aware of
its interaction requirements or constraints. Due to the number of unknowns, we converted the story
into a spike. Spike which we could use for our small experiment.

The acceptance criteria for the experiment was simple - at any given point during a spike, we
should be able to ask another engineer on the team to pick up the work, without ever interacting
with the original developer, but also without a slowdown in delivery. The assumption was that
committing every small unit of individual’s learning into the codebase would expose all the new
knowledge to others.

## First commit

When you break big unknown into smaller questions, the first question is always the hardest one to
make small enough. In our case, it ended up being “What is the core API URL?”. The usual approach
to answering the question is pretty straight-forward - we scan through the third-party
documentation in search of just endpoints and the main URL, completely ignoring everything else.
However, as per our experiment, when we did find it, our job was not done. The learning cannot
complete until it is committed to the codebase.

How can we represent in code this simplest of answers to this smallest of questions, without it
being completely useless? The developer went with creating a new feature-flagged (hidden in the
production, but not in the UAT) controller with a simple HTTP status code check and a hardcoded
URL. They also added a controller template that was outputting said HTTP status code from API. On
top of that, they added the link to the new hidden page to the original ticket.

Now anyone with access to the ticket and codebase could verify progress. If you open the page and
see `404`, we did not find the correct URL. In reality, the page was showing `400` - `Bad
Request`, which meant that we were on the right track.

## Second commit

What is next? That `Bad Request` seemed to be what was blocking our further progress. Why API
considers our request “bad”? Developer scanned through the documentation and found the endpoint
required OAuth consumer key authorisation.

The engineer quickly created a test OAuth key, using third-party admin, and stored it within the
team’s shared secret vault (1Password), away from the codebase. They then changed the hidden
controller to use the key (via environment variable set outside of the codebase) and return the
content of third party API, in addition to the status code we already got. The template was
updated to show the API response.

After reloading the page, the developer had their first big epiphany. They just spotted that the
API returns content as `JSON` (content format), and, they identified the exact way third-party was
structuring the data within the response. Both insights have formed without once looking at the
third party documentation, which was remarkable. What was even more impressive, is that all the
knowledge is not in this one team member’s head - everybody could get to the same realisation by
just opening the hidden page.

## Feedback

The epiphany was a big turning point because the developer did flag initially that the entire
process felt weird and “pointless”. Thankfully, it did not take long before the experiment started
yielding positive outcomes. Moreover, the sudden insight into the structure of the third party
response was only the beginning.

One of the more interesting side-effects of the process was that the developer quickly realised
that the intended audience of the code, is the other team members, and not the computer. The
effect on codebase was profound. The developer started treating controller code not as a series of
machine instructions, but as a crime report. Descriptive, long variable names started popping out
throughout the codebase. Intention-revealing comments started to pop up around the place.

Also, with these small commits happening in a new, isolated part of the codebase, and being behind
the feature flag, there was no reason not to deploy them to test environments. The commits quickly
started flowing into the UAT environment.

At some point, somebody on the team shared the hidden page in UAT with the Product Owner. The
stakeholder ran to the team to talk about the feature being spiked. They looked at the `JSON`
returned and got worried. They did not worry because of the response structure, but because of the
data returned within it. The content that the third-party was returning was much more sparse than
the feature designs have accommodated for up until this point. The designer came over too, and
this team of three (PO, Dev and Designer) started reworking the feature design in the context of
the data they observed. The situation happened half-way through the original spike estimate.

## Cleaning up

At this point, you might think that, although the benefits are great, this hidden controller is
far from the final solution. The logic likely needs to be embedded into an existing controller and
a template, not live on the fridge of the codebase. The team had similar concerns.

What we learned is that when you go with small steps, it also becomes easier to move things around
and try different levels of abstractions with the benefit of a stable environment under your feet.

At some point towards the second half of the spike, the engineers started extracting chunks of
logic from the controller, into a dedicated object within the application core. Activity appeared
way easier to them as they now knew what the logic was doing and how - the solution was clear, the
only unknown at this point was the structure. The UI design, the functionality, and the structure
were all incrementally validated and confirmed by both the team and the Product Owner.

The team spent much time making the final integration easy. It turns out, when you spend time
breaking big decisions into small ones, although the first step does tend to be the hardest one,
the final step tends to be the easiest one.

## Takeaways

We ran a retrospective with the team post the experiment. One of the biggest learnings was that
approaching spike incrementally and committing every learning unit into codebase allowed us to
find the big problem very early, increase team awareness of the third party integration, including
the Product Owner, and, unexpectedly, improve the overall clarity of the codebase.

The team was so excited about the opportunities that they attempted an expanded experiment, where
we would apply similar fast-cadence commits to ordinary stories.

We quickly found that, with a decrease of unknowns, you tend to get way fewer benefits out of
tools aimed at taming uncertainty. With TDD, for example, one would naturally decrease the size of
test steps as they enter brand new problem space and do the opposite when tackling a
well-understood problem. Incremental learning committed to code seem to be operating within the
same dynamic.

Looking back at the experiment and the team, it also became clear that breaking a spike into
smaller committable units of learning requires a certain level of maturity from the engineer. As
previously stated, the first step, in particular, was the hardest. I wouldn’t advise leaving
junior team members on their own with this approach.

The thing that made it easier to sell said experiment and spot positive outcomes was that the team
in question had a sincere appreciation for incremental delivery and design. This experiment was a
sensible logic leap for them. If you think your team might be in the same boat, it might be worth
running the experiment for yourself. I surely would like to get more external feedback on it.
