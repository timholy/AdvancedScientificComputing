---
title: "Testing & principles of design"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 10, 2021
geometry: margin=1in
output: pdf_document
---

# Sources for learning

## Technical material

Julia's `Test` standard library is [documented here](https://docs.julialang.org/en/v1/stdlib/Test/#Basic-Unit-Tests).

## Background and context

*These readings are optional and provided merely for reference.*

Many bits of programming advice have been codified into [aphorisms](https://www.artima.com/weblogs/viewpost.jsp?thread=331531).
Similar lists can be found on many sites devoted to programming design.

Many of the online sources about good design principles mention the acronym [SOLID](https://en.wikipedia.org/wiki/SOLID),
which focuses on a paradigm known as ["object-oriented programming" (OOP)](https://en.wikipedia.org/wiki/Object-oriented_programming).
OOP was the dominant, in-fashion paradigm for new languages from the early 1990s until roughly 2010.
As the [limitations of OOP](https://en.wikipedia.org/wiki/Object-oriented_programming#Criticism) became more and more [apparent (see the section on the expression problem)](https://arstechnica.com/science/2020/10/the-unreasonable-effectiveness-of-the-julia-programming-language/), the SOLID framework is less approachable and relevant than it once was (some of the core ideas are still applicable, but the phrasing is coupled to the lingo of OOP).

[Test driven development (TDD)](https://en.wikipedia.org/wiki/Test-driven_development) arose from interest in making software more reliable and faster to write. This paradigm overlaps with [agile development](https://en.wikipedia.org/wiki/Agile_software_development), [extreme programming](https://en.wikipedia.org/wiki/Extreme_programming), and many others. You will find some strong opinions expressed online about any of these, and a tendency among some to turn the comparison of paradigms into a spectator sport. While "agile" has certainly become its own buzzword, a key point of the well-known [agile manifesto](https://agilemanifesto.org/) is that no one process deserves to become a "religion."

I encourage you to borrow good ideas wherever you find them, but not to feel like you have to adhere to a rigid set of rules.

# Important instructions

*Despite the advice above to avoid "adhering to a rigid set of rules," for this particular homework...*

When solving a part of a problem:

- add the tests and verify they fail (you haven't written the code yet). **Make a commit.**
- add the implementation and verify your new tests pass. **Make another commit.**
- move on to the next part of the problem.

Each of these might be just a few lines. We're deliberately breaking things up into small pieces.

For enrolled WashU students, **you will lose some points on this assignment if you don't write the tests first** (I will check the sequence of commits as well as the final outcome).

*This requirement applies only to this homework; in the remainder of the course, choose whatever workflow you prefer.*

## Why am I being forced to do this?

This lecture and homework focus on *process*, and so your development process is part of the assignment. In my personal experience, most people who come from a scientific background tend to underutilize structured testing, and the idea of writing the tests before the code seems entirely foreign. Whether that's a practice you later use routinely, occasionally, or never at all, my guess is that you'll learn most by trying it out. It can be frustrating and slower the first time or two, but like most things your assessment of its merits and weaknesses shifts after you get over the initial learning curve. There's enough value in these ideas that you should give them a try.

# Homework

## An algorithmic problem

Many problems in science are phrased in terms of graphs. Biological examples include graphs of interacting enzymes or proteins, graphs of connected neurons or brain regions, etc.  A graph

![A small two-component graph](smallgraph.png){ width=150px }

might be represented as

```julia
graph = [
          [2, 3],     # list of nodes that can be reached from node 1
          [1],        # list of nodes that can be reached from node 2
          [1],        # ", node 3
          [5],        # ", node 4
          [4]]        # ", node 5
```

Notice that this graph has two *connected components*, `[1,2,3]` and `[4,5]`.
(The numbering of the nodes is arbitrary; Fig. 1 could have scrambled the node numbering and then these wouldn't necessarily have come out in order. All that matters is the connectivity.)

Initially assuming the representation above, solve this problem as a sequence of steps described below. I will describe the functionality I want you to implement, but remember to **implement the tests first** and **make (at least) two commits per bullet point**:

- Starting from a given node, return the list of directly-connected neighbors. (This may seem trivial with the representation above, but you'll see the point in the final stage of this problem.)
- Starting from a given node, return the list of all nodes reachable (directly or via hopping from neighbor to neighbor) from that node. Your code should use the code you wrote in the first step.
- Identify all connected components of the graph. Your code should use the code you wrote above.
- Generalize your code so that it also supports a graph supplied in *adjacency matrix format*, in which the graph above is represented as

```julia
A = [
  1 1 1 0 0;
  1 1 0 0 0;
  1 0 1 0 0;
  0 0 0 1 1;
  0 0 0 1 1;
]
```

Generalize your code without converting the adjacency matrix into a neighbor-list format; use Julia's dispatch features to implement low-level methods, and then see if your high-level routines "just work."

Converting representations is not a big deal when dealing with small graphs, but if someone hands you a graph with a billion edges, some formats may fit in your computer's memory while others may not. Representation-agnostic code has a better chance than representation-specific code of being generalizable to different input formats.

## A concept-encapsulation problem

Here we're going to implement a computational analog of a simple mathematical concept, the [interval](https://en.wikipedia.org/wiki/Interval_(mathematics)). Your implementation should hew as much as possible to the mathematical notion, subject to the limitations of computers in mimicking mathematics. (E.g., floating-point numbers are an imperfect reflection of the mathematical concept of real-valued numbers.)  You can restrict your implementation to *closed intervals*.

Perform this as a sequence of these steps. I will describe the functionality I want you to implement, but remember to **implement the tests first** and **make (at least) two commits per bullet point**:

- Define an interval type (`Interval`) and make sure that `minimum(iv::Interval)` and `maximum(iv::Interval)` return the endpoints
- Implement `in` (equivalently, `∈` which is obtainable with `\in` followed by TAB) to test if a real number is within an interval
- Make `isempty` "do the right thing" with intervals
- Implement the mathematical notion of a subset. In julia, `issubset` or `⊆` (obtainable with the LaTeX command `\subseteq` followed by TAB) can be used. Your solution should leverage one of the previous steps.
- Implement intersection (`intersect` or `\cap` followed by TAB)
- Implement pretty-printing: closed brackets `[` and `]` are typically used in mathematics to denote closed intervals, but in Julia this already means arrays. To avoid ambiguity, use the unicode characters `'\u301a'` (prints as 〚) and `'\u301b'` (prints as 〛). Note the obligate use of character delimiters `'`.

## Bonus: combining algorithmic and concept-encapsulation in a single problem

This is not required, but if you sailed through the two problems above, give it a try! This one is deliberately less structured than the previous two, and designed to give you a chance to start visualizing how to break a problem down into a sequence of incremental steps on your own. Even if you don't finish it, just getting a start will hopefully be fun and help you solidify your understanding of both Julia and good development practices.

Many analysis problems can be solved in terms of the [nearest-neighbor problem](https://en.wikipedia.org/wiki/Nearest_neighbor_search). The "dumb" algorithm just checks all possible points and returns the closest one. However, when the number of points is very large, there is great interest in finding faster approaches. In two dimensions, one way to solve this problem fairly efficiently is via a [quadtree](https://en.wikipedia.org/wiki/Quadtree).
With the `Interval` type from the previous problem, you already have a modest head-start on implementing a quadtree:
you can use a tuple `(ix::Interval, iy::Interval)` to represent a box (or create your own `Box` type storing two intervals, if you prefer), and exploit some of the tools you built to make it easy to figure out which box a point falls into. You may also want to define a `Node` which may have 0 or 4 `children` as well as a collection of `points`; only [leaf-nodes](https://en.wikipedia.org/wiki/Tree_(data_structure)#Terminology) should have a non-empty list of `points`. But as long as you lead with the tests, your specific implementation is up to you.

Be sure to think about good test cases from the beginning. Some tips:

- having good tests allows you to refactor your algorithm without worrying that you'll introduce hidden breakage. Consider starting with a fully-tested and complete implementation of the "dumb" algorithm, and only then start implementing the quadtree.
Make sure you make intermediate commits! E.g., write the tests (commit), implement the dumb algorithm (commit), and then start working on the more sophisticated but more complicated algorithm. If desired, the simple algorithm can be kept as a reference.
- as you may have encountered in previous problems, there are some interesting "corner cases" to think about. See if you can come up with at least one specifically targeting complexities in the quadtree implementation.
