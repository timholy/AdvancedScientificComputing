---
title: "Testing & principles of design"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 10, 2021
geometry: margin=1in
output: pdf_document
---

# Learning

## Technical material

### The `Test` library

Julia's `Test` standard library is [documented here](https://docs.julialang.org/en/v1/stdlib/Test/#Basic-Unit-Tests).

### Code coverage

One simple (and imperfect) measure of "code quality" is the fraction of source-code lines that get "exercised" by your tests, a measure often called [code coverage](https://en.wikipedia.org/wiki/Code_coverage).
While using a web-based service is often easier (we'll use [Codecov](#codecov), see below), if you wish you can measure coverage locally and inspect the results yourself. To learn how to do this, see [working locally](https://github.com/JuliaCI/Coverage.jl#working-locally) in the Coverage.jl README.
Julia options are described [here](https://docs.julialang.org/en/v1/manual/command-line-options/) (in this context, see the `--code-coverage` option).

### Codecov

[CodeCov](https://about.codecov.io/) is a web service for inspecting code coverage data online and representing it graphically.
You'll set up this service for use with your account so that you and others can easily check your coverage.

Let's return to this PkgTemplates configuration line we introduced in the previous session:

```julia
tpl = Template(; plugins=[GitHubActions(), Codecov(), Documenter{GitHubActions}()])
```

The `Codecov()` part configures "GitHubActions" (more on that in the next session) to run your tests with Julia in coverage-collection mode, and then uses the [Coverage package](https://github.com/JuliaCI/Coverage.jl) to bundle up the coverage data in appropriate form for submission to Codecov. The data get stored in your personal Codecov account (for repositories you own) or ones associated with GitHub organizations (for repositories that are hosted within organizations). You can review the results at the Codecov site. If you turn on GitHub integration (see below), you'll also see reports within GitHub pull requests.

### Using Revise in conjunction with test-driven development

As acknowledged in lecture, sometimes it is difficult to capture a bug with a good, minimalistic test until you have verified that you genuinely understand the bug; sometimes, the only way to be sure you understand it is to fix it. You still want to be sure your test captures the bug (i.e., your new tests would fail without the fix), which basically means "backing out your fix" and re-running your test in the context of your test suite. The [Revise package](https://github.com/timholy/Revise.jl) can help automate [this process](https://timholy.github.io/Revise.jl/stable/#Secrets-of-Revise-%22wizards%22-1). This may not happen to you on this homework, but if it does, here's the workflow:

1. In VS Code, check out a branch and commit your candidate *test*.
2. In VS Code, [stash](https://git-scm.com/book/en/v2/Git-Tools-Stashing-and-Cleaning) the fix by clicking "..." (in the `git`/Source control view) followed by "Stash" and then "Stash" again. Give your stash a brief message.
3. Run your test and make sure it fails
4. Pop the stash (select "Pop stash..." from the same menu), run your test, and make sure it passes. Commit the fix.

If you discover your tests *don't* capture the problem, keep committing alterations to the test without committing the fix until you've successfully isolated the issue. *Optional*: for a cleaner `git` history, instead of making commits in VS Code using the check-mark, click "..." followed by "Commit" followed by "Commit staged (Amend)". This will modify your previous commit rather than creating a new one. *Never do this on main, only on branches*.

Note that stashing/unstashing can sometimes generate conflicts which must be managed carefully; if you run into trouble, try searching for solutions (I found [two](https://www.theserverside.com/video/How-to-easily-merge-and-resolve-git-stash-pop-conflicts) potential [pages](https://stackoverflow.com/questions/7751555/how-to-resolve-git-stash-conflict-without-commit) but you may find others more or less useful).

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

Despite the advice above to avoid "adhering to a rigid set of rules," for this particular homework:

- add the tests and verify they fail (you haven't written the code yet). **Make a commit.**
- add the implementation (preferably, a *minimal* implementation) and verify your new tests pass. **Make another commit.**
- move on to the next step in the problem.

Do this sequence for each numbered step of the assignment (you should end up with at least two commits per step). Each of these might be accomplished with just a few lines of code, we're deliberately breaking things up into small pieces. I will check the sequence of commits as well as the final outcome, and if you don't follow this workflow you will lose points.

*This requirement applies only to this homework; in the remainder of the course, choose whatever workflow you prefer.*

If you later add more tests ("whoops, I forgot to check if...") or modify existing tests, that's fine! This is a normal part of development. We'll talk a little more about the implications of such changes in the next session on package versioning and the release process.

## Why am I being forced to do this?

This lecture and homework focus on *process*, and so your development process is part of the assignment. In my personal experience, most people who come from a scientific background tend to underutilize structured testing, and the idea of writing the tests before the code seems entirely foreign.  If you want to be taken seriously as a coder, having good tests is starting to become *de rigueur*; you should henceforth expect to write tests for nearly all your code (and not just in this class).

Regardless of whether writing tests *first* becomes a practice you later use routinely, occasionally, or never at all, my guess is that you'll learn most by trying it out. It can be frustrating and slower the first few times, but like most things your assessment of its merits and weaknesses shifts after you get over the initial learning curve. There's enough value in these ideas that you should give them a try.

# Homework

## Setup

### Codecov

Log in to [CodeCov](https://about.codecov.io/) via your GitHub account.
Optionally (but recommended), [grant it access](https://github.com/apps/codecov) (click "Configure" in the upper right) to generate coverage reports on pull requests to repositories in your personal GitHub account. When you review the code in a PR, lines that lack coverage will be tagged with an individual notice, so you don't have to go visit Codecov to find out if there's missing test coverage.

### Create a package for your solutions to this homework

Use PkgTemplates to create a local package named "TDD", using the default template [above](#codecov).
Use the same procedures you used in the last assignment to sync the empty repository to your GitHub account.

This "package" will be fairly unusual, because it will consist of two unrelated problems (and optionally, a third having some overlap with the second). For each problem, store the tests (in `test/`) in a file, and do the same for the source code in `src/`; for example, you might have `graph.jl` in both `src/` and `test/` for the problem on graphs, and `interval.jl` in both for the problem on intervals.
Use `include` in both `TDD.jl` and `runtests.jl` to ensure that all your source & test files get woven into the package.

When solving the problems, you can use `export` statements if you want any names of your functions to be externally visible, or use module-qualification `TDD.myfunction(args...)` if you prefer not to have any exports. (Either choice is fine.)

While working with your package, either use the package's environment or `Pkg.develop` it in your main environment.

FYI: with our default template settings, PkgTemplates adds a Codecov "badge" to your README, so that others can see your overall test coverage. Codecov recently changed their security in response to a breach, and last time I checked, the badge created by PkgTemplates no longer works. If this bothers you (fixing it is not required for this assignment), get the Markdown for a new badge directly from Codecov: choose the package, then Settings (from the top banner), click on "Badge" (from the left menu), copy the Markdown, and paste it into your README.

## An algorithmic problem

Many problems in science are phrased in terms of [graphs](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)). Biological examples include graphs of interacting enzymes or proteins, graphs of connected neurons or brain regions, etc.  A graph

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
(The numbering of the *nodes*--also known as *vertices*--is arbitrary; Fig. 1 could have scrambled the node numbering and then these wouldn't necessarily have come out in order. All that matters is the connectivity.)

For this problem, there are two additional requirements:

- The graph above is effectively an [undirected graph](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)#Types_of_graphs) because all the connections go both ways. However, note that I've chosen to represent it in a form that could also be used for *directed* graphs. Your tests should include at least one example of a directed graph that isn't symmetric, and your code needs to return correct results for both undirected and directed graphs.
- Regardless of how the "user" represents the graph, nodes should be implicitly assumed to connect to themselves and your tests should enforce that result. (Self-connectivity is omitted from the representation in `graph` above.)

Initially assuming the representation above, solve this problem as a sequence of steps described below. While Julia has excellent graph packages (e.g., [Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl)), here I want you to design these algorithms yourself without the help of external packages. I will describe the functionality I want you to implement, but remember to implement and commit the tests first and then implement and commit the code needed to pass the tests you just committed:

1. Given a graph and starting node, return the list of directly-connected neighbors. Remember, your tests should enforce the fact that a node is connected to itself whether or not the user-supplied representation lists it explicitly: `i` should appear in the list of directly-connected neighbors of node `i`.
2. Given a graph and starting node, return the list of all nodes reachable (directly or indirectly via hopping from neighbor to neighbor) from that node. Your code should use (i.e., call) the code you wrote in the first step. If you're unfamiliar with the programming concepts needed to solve this problem, a hint is that there are two roughly equivalent approaches: [recursion](https://en.wikipedia.org/wiki/Recursion#In_computer_science) and iteration, the latter typically via a [stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)) or [queue](https://en.wikipedia.org/wiki/Queue_(abstract_data_type)). (Stacks tend to give you "depth-first search" and queues "breadth-first search"; if all this means nothing to you, it's likely that recursion will be the easier approach.)
3. Identify all connected components of the graph. Your code should use the code you wrote above. For directed graphs, use the notion of "weak" connectivity: two nodes are in the same component if either can be reached from the other.
4. Generalize your code so that it also supports a graph supplied in *adjacency matrix format*, in which the graph above is represented as

```julia
A = Bool[
  1 1 1 0 0;
  1 1 0 0 0;
  1 0 1 0 0;
  0 0 0 1 1;
  0 0 0 1 1;
]
```

If `A[row, col]` is `true`, then you can hop from `row` to `col` directly. (Note that `Bool[...]` is an easy way to construct arrays with `0 = false`, `1 = true`.)

Generalize your code **without converting the adjacency matrix into a neighbor-list format**; use Julia's dispatch features to implement low-level methods, so that your high-level routines (perhaps minimally modified) "just work." Make sure your code also works if you set all the diagonal elements of `A` to `false` (again, here we are decreeing that nodes are implicitly connected to themselves, whether that's included in the input representation or not).

Converting representations is not a big deal when dealing with small graphs, but if someone hands you a graph with a billion edges, some formats may fit in your computer's memory while others may not. Representation-agnostic code has a better chance than representation-specific code of being generalizable to different input formats.

At the end, submit this as a pull request to GitHub and use CodeCov to check your coverage. If there are untested lines, write new tests that exercise them. Use a commit message similar to "Improve test coverage" so that your instructor understands the sequence in which things happened. When you merge the pull request to `main`, **do not squash** (though if you accidentally do, I can see what it was before directly in the PR).

## A concept-encapsulation problem

Here we're going to implement a computational analog of a simple mathematical concept, the [interval](https://en.wikipedia.org/wiki/Interval_(mathematics)). Your implementation should hew as much as possible to the mathematical notion, subject to the limitations of computers in mimicking mathematics. (E.g., floating-point numbers are an imperfect reflection of the mathematical concept of real-valued numbers.)  In particular, an interval differs from a range like `3:5` in that `3:5` contains only 3 items (3, 4, and 5), whereas an `Interval(3, 5)` would contain all real numbers between 3 and 5 (an infinite number of values). You can restrict your implementation to *closed intervals*.

Perform this as a sequence of these steps. I will describe the functionality I want you to implement, but remember to implement the tests first and make (at least) two commits per step:

1. Define an interval type (`Interval`) and make sure that `minimum(iv::Interval)` and `maximum(iv::Interval)` return the endpoints. **Here and below, these refer to the `Base` functions**, i.e., provide new methods for `Base.minimum` and `Base.maximum`.
2. Implement `in` (equivalently, its Unicode equivalent obtainable with `\in` followed by TAB) to test if a real number is within an interval
3. Make `isempty` return `true` if supplied with an empty interval (think about how an empty interval might be defined; your implementation of `in` might give you a clue)
4. Implement the mathematical notion of a [subset](https://en.wikipedia.org/wiki/Set_(mathematics)#Subsets). In julia, this is queried with `issubset`. Its Unicode equivalent is obtainable with the LaTeX command `\subseteq` followed by TAB, and the converse is `\nsubseteq`TAB. Make sure your implementation is in agreement with the properties of subsets in the previous link.
5. Implement intersection (`intersect`, or `\cap` followed by TAB). Food for thought: is `union` an operation you can reasonably implement?
6. Implement pretty-printing: closed brackets `[` and `]` are typically used in mathematics to denote closed intervals, but in Julia this already means arrays. To avoid ambiguity, use the unicode characters `'\u301a'` and `'\u301b'`. (I don't know of a way to get this to tab-complete, so to see what they look like as Unicode, just print them.) Also ensure that empty sets print as `\emptyset`TAB.

   In Julia, you customize printing by writing a [`show` method](https://docs.julialang.org/en/v1/base/io-network/#Base.show-Tuple{IO,%20Any}).  `show` can also be defined in [3-argument variants](https://docs.julialang.org/en/v1/base/io-network/#Base.show-Tuple{IO,%20Any,%20Any}) for specific output forms--for example, to display an array as a PNG image--but you don't need to handle this variant.

## Bonus: combining algorithmic and concept-encapsulation in a single problem

This is not required, but if you sailed through the two problems above, feel free to give it a try! Even if you don't finish it, just getting a start will hopefully be fun and help you solidify your understanding of both Julia and good development practices. This one is deliberately less structured than the previous two, and designed to give you a chance to start visualizing how to break a problem down into a sequence of incremental steps on your own.

Many analysis problems can be solved in terms of the [nearest-neighbor problem](https://en.wikipedia.org/wiki/Nearest_neighbor_search). The "dumb" algorithm just checks all possible points and returns the closest one. However, when the number of points is very large, there is great interest in finding faster approaches. In two dimensions, one way to solve this problem fairly efficiently is via a [quadtree](https://en.wikipedia.org/wiki/Quadtree).
With the `Interval` type from the previous problem, you already have a modest head-start on implementing a quadtree:
you can use a tuple `(ix::Interval, iy::Interval)` to represent a box (or create your own `Box` type storing two intervals, if you prefer), and exploit some of the tools you built to make it easy to figure out which box a point falls into. You may also want to define a `Node` which may have 0 or 4 `children` as well as a collection of `points`; only [leaf-nodes](https://en.wikipedia.org/wiki/Tree_(data_structure)#Terminology) should have a non-empty list of `points`. But as long as you lead with the tests, your specific implementation is up to you.

Be sure to think about good test cases from the beginning. Some tips:

- having good tests allows you to refactor your algorithm without worrying that you'll introduce hidden breakage. Consider starting with a fully-tested and complete implementation of the "dumb" algorithm, and only then start implementing the quadtree.
Make sure you make intermediate commits! E.g., write the tests (commit), implement the dumb algorithm (commit), and then start working on the more sophisticated but more complicated algorithm. If desired, the simple algorithm can be kept as a reference.
- as you may have encountered in previous problems, there are some interesting "corner cases" to think about. See if you can come up with at least one specifically targeting complexities in the quadtree implementation.
