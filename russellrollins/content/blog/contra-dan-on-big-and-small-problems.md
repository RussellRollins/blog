---
title: "Contra Dan on Big and Small Problems"
date: 2022-02-04T08:45:00-05:00
draft: false 
---

## Contra Dan on Big and Small Problems

My former coworker at HashiCorp, Dan Slimmon recently wrote a blog post titled
[Big Problems and Small Problems under load](https://blog.danslimmon.com/2022/02/03/big-problems-and-small-problems-under-load/).

I think it's a great post that gets at the heart of a common problem in big
SaaS applications, that most serious investigation and debugging of systemic
problems only happens when we're doing root cause analysis on a Big Problem.

While this post is called "Contra Dan", that's mostly because, "Dan is right
about everything he said, but failed to mention a caveat I think is so
important it puts his whole thesis at risk" is not a pithy title for a blog
post. Another important disclaimer is that Dan is a much more experienced and
expert SRE than I am. I've never actually held SRE as a job title, although I
have worked alongside people who hold that title in debugging and hardening complex systems.
Still, you should take all this with a grain of salt, to the extent we
disagree, Dan is probably in the right.

## Thesis

You should, of course, read the original source material, it's short and
quite good. But to summarize quickly, Dan says we should try to identify Small
Problems before they turn into Big Problems.

Dan:
> But [backchaining from Big Problems] is not the only way to identify Small
> Problems. We can go digging in our data and find them, endeavoring to solve
> them before they get a chance to cause a Big Problem.

Small Problems are easier to solve, since they have a small number of causes and a
small number of effects. In addition, Big Problems are __expensive__:

> But even if we’re just poking around in the dark, we’ll probably end up
> preventing some Big Problems, right? And Big Problems are expensive. I think,
> on balance, it’s worth the effort.

Big Problems are expensive because they end up affecting customers. They count
against our error budget and against our SLAs. But they're also expensive
because they involve bringing the blunt instrument of incident response to
bear. Incident response involves process, external interfaces, and high bandwidth
synchronous communications. This is for a good reason! But it's also expensive.

In the classic video game Half-Life, Gordon Freeman spends a lot of the time
he'd like to spend fixing problems bonking assorted ne'er-do-wells with a
crowbar. If you had solved the problem with the crystal on that silly little
cart before the resonance cascade you could have solved it in a quiet lab
without bonking anything. In this strained analogy, doing customer comms and
updating the status page is that level where you burn the big tentacle monster
with a rocket engine. Half-Life is weird. Solving Small Problems means we can
pick them out in isolation, without the additional incidence of stress caused
by an outage. This is a very good thing.

## Antithesis

So, why do I think Dan is missing something important? He talks about how
Big Problems are the result of complex emergent behavior of a system and
involve cascading failures of many Small Problems. Dan again:

> Big Problems, though, are always composed of smaller problems. Big Problems
> conditioned by load are not atomic novel phenomena. There’s a knot of
> interdependent processes, and when this knot gets pulled tight by load, it
> binds up.

A complex system is one where many of the effects are also causes. Where there
are not only long chains of dependencies, but sometimes those chains loop back
on themselves. The output of a component is, after some number of hops, also an
input to the same component.

The crucial distinction I think it is important to draw is between (terms I'm
going to make up now) **Primary** Effects and **Intermediate** Effects. Primary
Effects are, as Dan puts it, where "value comes out" of the system. If you run a widget
factory, the Primary Effect is making widgets. If you run a SaaS product, the
Primary Effect is serving customer API requests, responding to customer web
traffic, and background jobs syncing customer data. A decent heuristic: if you
can put the word customer in there, it's a Primary Effect. Intermediate Effects
are all the things you wouldn't draw on a UML diagram of your system. Linux
swapping pages to disk is an Intermediate Effect. Your SQL database row locking
or doing table scans is an Intermediate Effect. Intermediate Effects can
eventually cause Primary Effects and this often happens during the midst of a
Big Problem.

The problem with Intermediate Effects is it's too easy to become fixated on
them, especially if they are easier to measure than their associate Primary
Effects. There is some corollary of [Goodhart's Law](https://en.wikipedia.org/wiki/Goodhart%27s_law)
in which you tend to produce a lot of things that you measure and "score" on. Your goal
was to live the good life, you know material security is part of that, but it's
easy to measure your salary and hard to measure your satisfaction. After a
while you find your value function has gotten all out of whack. James C. Scott
would say something about [legibility](https://theanarchistlibrary.org/library/james-c-scott-seeing-like-a-state)
here.

Beware any scientific study that bases itself on Intermediate Effects. If the
claim is measuring thought or belief, but the actual study is analyzing fMRI
images you can almost always discount the value to zero. If a drug is claimed
to be effective for Alzheimer's and you find out it actually just reduces
amyloid plaques, your skepticism should be on alert.

The same goes for debugging. If you find yourself working on a lot of
Intermediate Effects, not only are you likely to waste time fixing things that
don't matter, you're also likely to miss useful solutions to Primary Effects.
If you find a slow query, you might spent time optimizing it. Or you might ask
yourself what part of the system uses it, how, and take an alternative approach
like an in-memory cache. Ask what the Primary Effect you're worried about is,
measure it, and try to solve it. If your approach to Small Problems is to pick
off a lot of negative Intermediate Effects, you're probably not optimizing
properly.

## Synthesis

Dan concludes:

> Ideally, nearly everybody in the org ought to be spending some of their time
> investigating mysteries. It ought to be an explicit part of the job.

On this, I completely agree. A refusal to dig into thorny problems, hiding
them behind an [Ugh Field](https://www.lesswrong.com/posts/EFQ3F6kmt4WHXRqik/ugh-fields)
and waiting for them to become overwhelming is a common failure mode. Management
often contributes to this, prioritizing features and legible changes over the
often slow and sometimes invisible work of fixing Small Problems.

Dan is, in my experience, extremely good at this. Noticing a Small Problem,
starting a [differential diagnosis](https://en.wikipedia.org/wiki/Differential_diagnosis)
document, and working through the leads or bringing in subject matter experts
until the problem is wrapped up. I think Dan applies some internal version of
the Intermediate/Primary Effects heuristic, which is why he doesn't tend to
spin his wheels fixing Small Problems that don't matter.

I think for most of us, making that distinction clear is valuable. It helps you
solve the right problems and it helps you sell the work as valuable up the
chain. It's hard to convince someone query optimization was a good use of time,
it's easy to convince them improving API response times for valuable customers
is.

Solve Small Problems, but only Small Problems with Primary Effects.
