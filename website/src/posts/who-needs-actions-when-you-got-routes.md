---
title: Who Needs Actions When You Got Routes
date: 2010-11-11
tags: [post, tech, migrated]
layout: post-layout
original: https://everzet.com/post/1542206325/who-needs-actions-when-you-got-routes
---

# Who Needs Actions When You Got Routes

Really. Who need to name their controller actions, when we got routes?

Why we need to name object methods? It’s because PHP need to identify which one of object methods
you call. Why we need to name controller actions? It’s because framework need to identify which
action user calls? NO! Framework already knows what action to call thanks to Routing mechanisms.

So, action names is, in reality, unnecessary middlemen. Because of that, we always dissatisfied
with our controllers & got different action naming scheme in different applications or/and even
controllers! How to call this action? `updateUserAction()` or `updateAction()` or
`saveUserAction()`???

## Thinking in URLs

Some time ago i read Rethinking Rails 3 routes article by PeepCode & it opened my eyes. REST!

## REST

Who needs routes when we could map collections, objects & their methods to controller actions itself?

In REST, to get user, you send

```
[GET] /users/:slug
```

to get all users:

```
[GET] /users
```

to update single user, send

```
[PUT] /users/:slug
```

to create new user, send POST with new user data to collection:

```
[POST] /users
```

But how about custom actions on collections & objects? All custom collection actions has GET HTTP
method. To perform new action on users collection, call:

```
[GET] /users/new
```

Custom object action always has PUT HTTP method, because we updating object:

```
[PUT] /users/:slug/ban
[PUT] /users/:slug/vote
```

And you can even nest resources inside resources:

```
[GET] /users/:slug/comments
[GET] /users/:slug/comments/:id
[POST] /users/:slug/comments
[PUT] /users/:slug/comments/:id/hide
```

## RESTful Controllers

Yesterday, we (i & Bulat (avalanche123)) started to think about RESTful controllers for Symfony2.
And we came to the idea of action naming convention, which will lead us to:

* consistent, self-explanatory controller actions names.
* routes autogeneration from actions names. Means, that you don’t need to think about 2 id’s from
  now on (route & action name) – you will think only about action name in context of what it does.

The result is a Symfony2 bundle called RestfulControllersBundle. It’s fully tested, but have some
missing parts (custom requirements & route name specification).

What it does is adds restful routes loader, which takes RESTfull controller class & tries to
create routes by parsing it’s action methods signatures by next rules:

1. finds methods with Action suffix
1. gets methods names without suffix
1. shifts first camelCased word from name, which becomes HTTP method
1. loops through all camelCased segments of name & finds if it collection or object. Collections
   doesn’t need & doesn’t have appropriate action arguments, but objects has.
    1. If segment is collection – add it to resulting URL
    1. If segment is object – pluralize it user => users, add identification argument name to id
       ...UserAction($slug) => users/:slug & add it to resulting URL
1. finds if specified HTTP method is correct HTTP method (get|put|post|delete). If yes – moves to
   step 7
1. If specified HTTP method is not get/put/post/delete – finds if last resource in URL is
   collection or object
    1. If last resource is collection – set HTTP method to GET & add custom method to resulting
       URL newUsers() => [GET] /users/new
    1. If last resource is object – set HTTP method to PUT & add custom method to resulting URL
       banUser($slug) => [PUT] /users/:slug/ban
1. Create route from URL & HTTP method, which maps to current action.

That’s all for now.

