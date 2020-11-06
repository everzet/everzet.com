---
title: Impactful Reports
date: 2019-06-13
tags: [post, stakeholder-whisperer]
layout: post-layout
---

# Impactful Reports

<img style="margin-left: auto; margin-right: auto;"
src="/assets/images/impactful-reports.png"
alt="Impactful Reports">

Often, when building a software system, teams are asked to develop a series of reports or even a
generalized report builder. Every single requested report is hiding a need, which it was devised
to fulfill. Stating the need explicitly and reworking specifications to better reflect it, makes
it easier to plan, prioritize, and deliver the software that matters. Clearly stated objectives
allow teams to fundamentally challenge underlying assumptions and develop reporting capabilities
with a more significant impact.

Disregard of the underlying business need behind reporting leads to scope, budget, and complexity
creep in the delivery. Treating reports as givens makes them impossible to improve or prioritize
against other reports and features. If all reports are critical, no report is.

The only audience of the reporting activity is people. People interested in reports are
predominantly decision makers or professionals who participate in a decision-making process.
Reports’ sole purposes are to support and enable desired decisions and prevent undesired ones.

## Non-Negotiable Scope

A little while ago, I was facilitating a project discovery for an investment advisory business.
The project was a rebuild of the legacy system, responsible for the generation of the investment
reports for the clients of the firm.

The business clients were paying hefty sums of money to gain access to a report portfolio. That
was both a blessing for the business and an absolute nightmare for the project team. Every report
was “non-negotiable.” We could not de-scope a single report or remove a line item from any of
them. All we could do is to add new reports or funnel more information into existing ones, making
the rebuild a logistical nightmare.

If you took the problem at face value, the stance made sense. Old system reports were the core
product of the business. And clients were paying for this exact core product, for years. Removing
any part of it from the sum seemed like a clear breach of an agreement between the business and
its clients. After all, customers are paying for the reports themselves, are they not?

## Problems Solved, Not Solutions Delivered

There is an old saying that people do not buy washing machines; they buy their clothes clean. It
means that although washing machine customers are physically exchanging money for the devices,
they are paying to enable easier cleaning of their wardrobes. You can apply this to almost any
product - people do not buy cars, they buy higher status and getting from point A to point B
quicker.

What do investors buy when they purchase a report portfolio? They buy a report on new investments
to validate it is worth investing. They also buy a report in their current collection to check if
it is time to pull out of an individual investment. Quite directly, investors are buying reports
to make their investment decisions safer, more comfortable, and faster.

The best possible washing machine I can imagine is a magic wardrobe, where you put dirty clothes
in the evening and pick them up clean and fresh in the morning. In the same vein, my imaginary
ideal version of an investment report is a screen with a single sentence on it: “invest into A to
get B% return in C years.” Counter-intuitively, the ideal report for me is not the one with more
information, but the one with less — the small amount of very high-quality, trusted information.

## Tomorrow’s Solutions, Unconstrained By Yesterday

The technology that could enable us to provide one-sentence trusted recommendations to investors
is not quite there yet. However, there is still a significant amount of value in adopting the
mindset. The investment reporting project team started scheduling one-on-ones with investment and
data analysts within the business. We would print the latest examples of reports and spend time
talking with analysts about the decisions these reports are supposed to serve.

Unsurprisingly, our team, which was entirely new to the investment world, learned a lot about risk
management, options, assets, etc. We could tell that digging into the underlying investment
decisions was also an exciting topic for our business experts. In most cases, the analyst would
almost immediately point out a decision-making process around a particular report and data point.
Then there were situations where it was visibly hard for a stakeholder to pinpoint the exact
decision tree. Interestingly, the reports behind these tricky decision processes were the most
complicated ones in the product, surfacing the most significant amount of line items. It is quite
evident in retrospect - when we can not identify a small number of high-quality data points, we
tend to surface more low-quality information instead.

Using the insight gathered during the conversations, the team has updated the product
specifications. Rather than every feature specification (user story) describing a particular
report’ look & feel and individual line items, we would explain, in detail, the decision it is
making safer, more comfortable or faster. That allowed the team to start efficiently and
effectively prioritize reports and data within the context of the product. The business
stakeholders started fundamentally challenging data points or presentation choice of each report.
Every single report suddenly became negotiable and was openly and enthusiastically negotiated
between the business and the project team — a big win for everyone.

## Measuring Success

We did not stop at explicitly stating the decision-making process and using it for prioritization
and planning. We also started looking at what did “safer,” “easier,” and “faster” meant in every
individual case. Does an investor need to decide if they want to invest in a particular asset? How
much safer can this decision become? One of the items in the investor’s portfolio started
drastically underperforming, and they need to pull out quickly? How much faster can this decision
be made?

The team worked hard on attempting to quantify the individual impact a report could or should have
on the decision. That helped the business team to spot new opportunities and innovative features
during the rebuild. The investment portfolio is in danger? Why waiting for a report if we can send
the investor an immediate SMS alert? Not sure if the business they are about to invest into is
real or just a smoke screen of financial documentation? Here are some recent social interactions
of the company, right on the report.

We now fully moved from rewriting out of date reports to designing and planning innovative ways of
supporting valuable human processes. Teams gradually stopped talking about reports, line items,
and recipients and started talking about clients, investment decisions, and decision-making
processes. By making objectives behind particular solution not only explicit but tangible, you are
allowing a team to invent better solutions, not just rebuild mediocre ones.

## UIs Are Reports With Buttons

Can this reporting insight be applied to other aspects of software delivery? In my experience, it
absolutely can. As described above, the only objective of a report is to enable and support
particular decision-making behavior. What is a computer program user interface, other than a bunch
of visuals, texts, and controls? It is a medium to allow users efficiently enact educated
decisions onto the system.

User Interfaces are just reports with buttons. The only fundamental difference between a report
and an application interface is the speed and efficiency with which a decision can be carried out
and tracked. Interfaces provide users with controls to enact decisions and wrap these controls
into a sufficient amount of information to make the decisions safer, more comfortable, and faster.

One can apply the same approach we used above to any traditional interface build. Not sure if you
need more or less information on the screen? Ask what decision (action) you are trying to support
with it. Not sure if controls placed correctly or presented on the page? Ask if it makes the
preferred decision harder or slower.

Software systems we build are no different to any other product of humanity, minus art. We build
things to make our lives easier, to help us solve problems effectively and efficiently. But
sometimes solutions of yesterday get in the way of solving problems of today. Always keep an eye
on the problem solved, not just the solution used. Look for opportunities to make a real impact,
by making people’s work safer, more comfortable, and faster.
