---
title: Introducing Modelling by Example
date: 2014-10-03
tags: [post, product]
layout: post-layout

permalink: posts/2014/10/introducing-modelling-by-example/index.html
---

# Introducing Modelling by Example

For the last year I have been experimenting with the new approach to a Behaviour-Driven
Development, which could be summarised as "Ubiquitous Language is a thing again". The core premise
of this approach is that if you take Ubiquitous Language seriously and push for it in your
scenarios, you open the door to doing a Domain-Driven Design while you're doing Behaviour-Driven
Development's red-green-refactor cycle. By embedding Ubiquitous Language in your scenarios, your
scenarios naturally become your domain model, which you can use to develop the most important part
of your application - a core domain.

## End-to-end testing

End-to-end automation is the most common way of using Gherkin-based BDD tools. The first thing
people think about when they see Gherkin is "I can test my website with this". Nowadays we know
that this is not the only way to use these tools. Matt Wynne has [a brilliant
article](https://cukes.info/blog/2014/09/10/when-cucumbers-go-bad) about this. You can indeed use
your scenarios written in Gherkin to drive implementation of the lower layers of your application.

But even if you take the approach of avoiding end-to-end, your choice is still binary - you either
drive your core domain with your scenarios, or you drive the interface. That is until you start
treating the feature as a driver for different layers of your application. What if you can use the
same feature to develop different layers of the application separately?

Not only can you avoid going end-to-end when you're doing BDD, there is a way to test your
application at multiple levels using the same behavioural examples. And as controversial as it
sounds, this will make a lot of sense when you really dig into it.

## Ubiquitous Language

For a long time we have been preaching that this:

    Scenario: Showing delivery cost for a product on the basket page
      Given there is a product:
        | name  | White Marker |
        | price | £5           |
      And I am on the "/catalogue" page
      When I click "Buy" in the "White Marker" product block
      And I go to the "/basket" page
      Then I should see a list with 1 product
      And the overall price should be shown as £9

is a bad Gherkin scenario. Scenarios should be written closer to this style:

    Scenario: Getting the delivery cost for a single product under £10
      Given a product named "White Marker" and priced £5 was added to the catalogue
      When I add the "White Marker" product from the catalogue to the picked up basket
      Then the overall basket price should be £9

But why is that? We mostly give two reasons for choosing the second version over the first one:

1. There is practically no business information in the first scenario, it describes how you plan
   to implement the feature, not what behaviour you're supporting with it.
2. The first scenario also locks you to a very specific implementation of your feature (a
   particular web UI), making the scenario very fragile and open to constant modifications.

I want to focus on the third reason, Ubiquitous Language, which is the language the team and the
stakeholders create together in order to talk about business problems, it is one of the two most
important concepts in BDD and the first scenario does not represent or use Ubiquitous Language,
while the second one does.

The reason Ubiquitous Language is so important is because we generally have an issue called the
"cost of translation". The business uses language natural to the business to describe their
requirements. We then translate those requirements into a language developers can understand, and
developers then translate it even further into code. We have two layers of indirection here and it
costs our industry money, incorrect translations are the primary cause of features that damage
businesses instead of helping them.

In recent years our industry has started to actively search for a solution to reduce the "cost of
translation" at different levels. The most prominent examples are the BDD (Behaviour-Driven
Development) and DDD (Domain-Driven Design) communities, which focus on minimising or even
eliminating translation costs using Ubiquitous Language. The difference is that they focus on
different layers: BDD focuses primarily on eliminating translation costs in conversations, while
DDD focuses primarily on eliminating translation costs in the code. What if we actually stopped
separating these efforts?

Let's reiterate - having Ubiquitous Language not only helps you to facilitate conversations, but
also model your core domain in a language both you and your business can understand. Imagine a
case where developers can discuss a purely technical problem using language that allows the
business to not only understand them, but to correct them and fully take part in the conversation.
I genuinely believe that for some time the general BDD community has focused too much on the
benefits of conversation about requirements, almost completely ignoring the benefits of modelling
the domain of the business.

## BDD scenarios as a domain model

Lets look at what technically happens when you write a scenario like this:

    Scenario: Getting the delivery cost for a single product under £10
      Given a product named "White Marker" and priced £5 was added to the catalogue
      When I add the "White Marker" product from the catalogue to the picked up basket
      Then the overall basket price should be £9

First of all, you and your entire team is getting a clear understanding of the business concept
behind the user-story you're developing. But even more importantly, you're also getting a choice
at which level to start implementing this feature. Yes, you still can go through the web interface
using a web crawler, but what if instead you decide to develop the domain core first?

There is a growing interest in layered and Hexagonal architecture across the industry. Developers
are starting to realise that mixing the problem and solution spaces is not the best way to design
a product. The most effective way to enforce an architecture where the domain is separated from
the infrastructure is to build these layers in separation from each other.

So what if we decide to use the same feature to drive the different layers of your application
separately?

## Designing the core domain using scenarios

As soon as we have discussed and captured our feature, and are at the point of implementing it, we
can then use any Gherkin-enabled BDD tool like Cucumber, Behat, or SpecFlow. However, instead of
going through the UI in a classical end-to-end approach, what if instead we went directly through
the core domain?

As soon as you run your BDD test tool, it'll generate your first step definitions for you. For
this article I'll use PHP as my language of choice and Behat as my tool of choice. Let's look at
our first step:

    /**
     * @Given a product named :name and priced £:price was added to the catalogue
     */
    public function aProductNamedAndPricedWasAddedToTheCatalogue($name, $price)
    {
    }

Now here's an interesting question - what code should we write in this step definition? In the
case of an end-to-end approach we'd write web crawler code that mimics the conversation between
the web user and the website we're building. When using a core domain approach we'd write code
that reflects the language the stakeholder used to describe the his needs. Simply put, we would
try to make our code as close as technically possible to the conversation we had. In our case -
we'd just mimic whatever the step says as closely as the underlying programming language allows us
to do:

    /**
     * @Given a product named :name and priced £:price was added to the catalogue
     */
    public function aProductNamedAndPricedWasAddedToTheCatalogue($name, Money $price)
    {
        $aProduct = Product::namedAndPriced($name, $price);
        $this->catalogue->add($aProduct);
    }

All we have done here is repeat whatever was stated in the conversation using Ubiquitous Language
with the code:

    a product named ... and priced ...
    =>
    $aProduct = Product::namedAndPriced($name, $price);

    ... was added to the catalogue
    =>
    $this->catalogue->add($aProduct);

What is a `Product`? It is an as yet nonexistent class you will need to create as a part of the
red-green-refactor loop. What is `$this->catalogue`? It looks like an infrastructure boundary that
we do not want to care about for now, thus we'll just go with `InMemoryCatalogue`, in our context
constructor:

    public function __construct()
    {
        $this->catalogue = new InMemoryCatalogue();
    }

You then run your BDD testing tool and do whatever you tend to do in order to make it green by
describing, test-driving, specifying and implementing classes or/and objects.

How easy was that? It's almost like we clearly modelled the domain without actually talking about
modelling! Surely this is a contrived example? Lets look at the second step:

    /**
     * @When I add the :name product from the catalogue to the picked up basket
     */
    public function iAddTheProductFromTheCatalogueToMyBasket($name)
    {
        $basket = Basket::pickUp();
        $basket->addProductFromCatalogue($name, $this->catalogue);
    }

Again, all we have done here is repeated whatever we stated in the scenario, which on its own was
just a clear reflection of the conversation we had with a key stakeholder:

    ... the picked up basket
    =>
    $basket = Basket::pickUp();

    add the ... product from the catalogue to the picked up basket
    =>
    $basket->addProductFromCatalogue($name, $this->catalogue);

What is a `Basket`? It is a nonexistent class you need to create as part of the red-green-refactor
loop.

The point I'm trying to make is that the fact that it is easy to align your code to the scenarios
written in Ubiquitous Language is not a coincidence, it is a natural outcome of using a shared
languge as a driver of your conversation and red-green-refactor loop. As a matter of fact, that's
exactly how Eric Evans discovers domain models. The process he calls "walking through scenarios":

> To cross-check all the decisions, we have to constantly step through scenarios to confirm that
> we can solve application problems effectively.
> --- Eric Evans, Domain-Driven Design: Tackling Complexity in the Heart of Software

For the last year I have been working on different domains using this practice and it has worked
every single time. It doesn't matter if you're describing e-commerce, a chess tournament system, a
conference planning tool or even a cargo shipping utility, examples written in Ubiquitous Language
always align with the core domain you're developing.

## Designing the UI using scenarios

When we're done with the core domain and our application works as our scenarios require it to, we
can start thinking about the next steps. It could be the case that we decide to go further and
implement even more scenarios or features purely on the domain layer - no UI or infrastructure.
Alternatively, you could decide that now is a time to move onto actually exposing developed
behaviour through the interface.

It is important to note that the way I look at infrastructure when doing Modelling by Example is
very different to the common perspective of it being an important part of the application.

For me, infrastructure is just a way to make a scenario pass, but only the scenario that fails
because of a lack of infrastructure. I will introduce a user interface whenever I want a user to
interact with the domain core, but I will introduce infrastructure only when a scenario step fails
because there is no other way to carry data between user interactions. Infrastructure is a tool,
not a goal on its own.

The way I approach a UI implementation is that I choose one or two scenarios (not all of them) and
tag them with `@critical` or `@core` tag:

    @critical
    Scenario: Getting the delivery cost for a single product under £10
      Given a product named "White Marker" and priced £5 was added to the catalogue
      When I add the "White Marker" product from the catalogue to the picked up basket
      Then the overall basket price should be £9

I then create a separate Context object (World in Cucumber) that will have the same step
definitions as the previous domain-focused Context, but the implementation meaning of these steps
will change.

The way it goes is you don't care how data gets into the system, so your `Given` step definitions
of the UI Context will usually repeat the step definitions of the domain Context one-to-one, at
least at the beginning of the red-green-refactor loop:

    /**
     * @Given a product named :name and priced £:price was added to the catalogue
     */
    public function aProductNamedAndPricedWasAddedToTheCatalogue($name, Money $price)
    {
        $aProduct = Product::namedAndPriced($name, $price);
        $this->catalogue->add($aProduct);
    }

When you hit your first UI-based `When` step, is when you will actually need to simulate the user
interaction using Capybara, Mink or any other web crawler. This is where you simulate a user
actually going through the web interface and doing an action:

    /**
     * @When I add the :name product from the catalogue to the picked up basket
     */
    public function iAddTheProductFromTheCatalogueToMyBasket($name)
    {
        $this->visit('/products');
        $product = $this->find('css', ".products li:contains('{$name}')");
        $product->click('Add to basket');
    }

As soon as you hit this step, your tool will complain that there's no `/products` page or route in
your app. As soon as you fix that problem you'll have another message saying that the `.products`
element is not found on the page. As soon as you update your template to actually print the
products in the catalogue, you'll get an exception that `li` containing `$name` is not on the
page.

That is your first infrastructure problem. Your `Given` steps add products to the catalogue, but
the catalogue is not persisted across processes. This is why you add a persistence layer, not
because every app should have a MySQL connection. So you go and update the `Given` and `When`
steps accordingly and implement the application, throughout the process trying to make it green.

This process goes on until your scenario becomes green, and as soon as it does you have a working
and tested domain core and UI. Even more importantly than that, you have a lot of very fast
acceptance tests (because they're not using the UI or infrastructure) and only a small fraction of
slow smoke tests that cover the `core` or `critical` journeys.

## Shorter feedback loops

The most obvious benefit of this approach is the fact that we have drastically decreased our
feedback loop. Instead of starting from scratch and trying to implement a full-stack solution with
the domain core, infrastructure and UI in one scenario implementation stage (that might take
ages), we break this one big task into two. We took away everything that is not related to the
core business problem solution, thus decreasing the time from an empty project folder to a working
solution that we can iterate on.

I have even had examples where the product owner was positively impressed with the fact that he
can see a feature working after just a couple of hours, even without UI or infrastructure. This
allows you to start iterating on a solution much faster than you usually would, where everyone
waits for you to establish database, web and UI infrastructures.

## Domain and scenarios evolving together

Another interesting side-effect of using scenarios as a domain model and pushing them straight to
the code, is the fact that your code and scenarios start evolving together. The link between your
scenarios and application becomes much stronger - refining the domain core and having insights
often leads to rephrasing of scenarios and vice versa.

I actually had an example of that just recently. We worked on a feature for the conference
organisation domain. We missed the important concept that a conference has an identity (its name).
That caused some struggle during the UI building phase because, it turns out, it is extremely hard
to persist or load things without identity!

We had a chat with the product owner and discovered that the reason things didn't fit together is
because we missed that very important domain concept. It wasn't a technical concept, it was a
consequence of the fact that we missed conference names in our conversation and examples. We then
went back and added this missing concept to the scenarios, which forced us to do a small and very
quick refactoring in the domain core, at which point the struggle just went away. Things started
to fit together again.

## Infrastructure leakage

Speaking of the infrastructure phase, there is one benefit that I didn't mention in the previous
sections - identifying what I call "infrastructure leakage". The reason why I didn't mention so
far it is because in order to get this benefit you need to use Behat (a PHP Cucumber alternative).
Since the release of v3, Behat allows you to define "suites" which are a way to tell Behat "test
these features with these step definitions". You can even tell Behat to run same feature through
different step definitions:

    # behat.yml configuration file
    default:
      suites:
        domain:
          contexts: [ BasketContext ]
        ui:
          contexts: [ WebBasketContext ]
          filters:  { tags: '@critical' }

When Behat is executed, all suites will be run.

The benefit of testing both the domain and UI layers at the same time is that you can detect when
the infrastructure starts interfering with or damaging your domain core (hence "infrastructure
leakage").

A couple of months ago I did some internal training at our company and we used Modelling by
Example with the same domain I have described here - adding products to a basket. We implemented
domain core first, which as you can imagine was rather easy and we then switched to the UI. As
soon as the team hit the "missing infrastructure" failure they started to implement the UI.

One of the trainees applied the Active Record pattern directly to the `Basket` object. As soon as
he ran his test suites an interesting thing happened - his next step in his UI-based suite started
passing, but the domain-based suite that had been green for the last hour started to fail. This
was because `Basket` started to persist itself when the domain core didn't expect that to happen.
The infrastructure detail had successfully leaked into the domain core, damaging it, and the tests
highlighted it to us. We've always said that Cucumber, Behat and SpecFlow are more design than
testing tools, and I think this is one of the best examples why.

Not using Behat? Push [Aslak](https://twitter.com/aslak_hellesoy),
[Matt](https://twitter.com/mattwynne) and [Julien](https://twitter.com/jbpros) to add suites to
Cucumber! In the meantime you just can do two completely separate testing environments and make
sure you are regularly running both.

## In conclusion

In all, after using this practice for almost a year now I'm still surprised by how well it works
and I'm still discovering amazing benefits and side-effects of developing applications through
tight example-based conversations in Ubiquitous Language. This practice didn't seem much at the
beginning but over time has transformed into something much bigger and I have a feeling that I'm
just getting started with it.

Last week me, [Marcello](https://twitter.com/_md) and [Ciaran](https://twitter.com/CiaranMcNulty)
conducted our first one-day Modelling by Example workshop at the
[SymfonyLiveUK](http://london2014.live.symfony.com/workshops/#full-stack-bdd-with-symfony2) and I
think it was amazing. I'm looking forward to the spreading the word about it through conference
speaking or, who knows, maybe even writing a book. Exciting times.
