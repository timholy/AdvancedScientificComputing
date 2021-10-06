---
title: "Learning Julia (Part 1)"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 4, 2021
geometry: margin=1in
output: pdf_document
---

# Sources for learning

The [learning page](https://julialang.org/learning/) lists many resources for learning Julia.  You are allowed to consult any source, but here are some recommendations:

- for experienced programmers, [the wiki](https://en.wikibooks.org/wiki/Introducing_Julia) seems to be a fairly good blend of didactic and practical material presented in a compact, efficient manner.  I recommend this as your default source.  Its main weakness is that it's not completely "linear" so you may need to read other sections to understand some of the points in the section you're studying.
- if you need a little more systematic explanation, [Think Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) provides a more polished experience at the expense of being longer
- the [manual](https://docs.julialang.org/en/v1/) is pretty good and the most up-to-date of all of these.  While many chapters read well, a few have very high expectations (you almost need a computer science degree to read a few of them).
- since all of you know at least one other language, the [Noteworthy differences page](https://docs.julialang.org/en/v1/manual/noteworthy-differences/) of the manual may help you get up to speed quickly.

## Reading for week 1

We'll mostly read the wiki (out of its default order, and with omission of some chapters).  A close second choice would be the corresponding manual chapters.

In the wiki:

- [The REPL](https://en.wikibooks.org/wiki/Introducing_Julia/The_REPL)
- [Running code in VS Code](https://www.julia-vscode.org/docs/stable/userguide/runningcode/) (sadly, the documentation for the Julia VS Code extension is very incomplete, but this particular page is useful)
- Modules and packages:
  + [Intro to modules and packages](https://en.wikibooks.org/wiki/Introducing_Julia/Modules_and_packages)
  + [Pkg: getting started](https://pkgdocs.julialang.org/v1.6/getting-started/)
  + [Pkg: managing packages](https://pkgdocs.julialang.org/v1.6/managing-packages/)

  **Pro tip**: the two `Pkg` documentation pages were generated with [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/), which we'll learn to use in the course. Importantly, all of the pages it produces have a little "Version" indicator in the lower left. For `Pkg`, make sure the version matches your Julia version (`Base.VERSION`).  If you're reading documentation on a specific package, it should match the package version you have installed (see `Pkg.status` or `pkg> status`).
- [Arrays and tuples](https://en.wikibooks.org/wiki/Introducing_Julia/Arrays_and_tuples)
- [Strings and characters](https://en.wikibooks.org/wiki/Introducing_Julia/Strings_and_characters)
- [Dictionaries and sets](https://en.wikibooks.org/wiki/Introducing_Julia/Dictionaries_and_sets)
- [Controlling the flow](https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow). Particularly useful on the first homework are the parts on `for` loops, comprehensions, and generators.
- **as needed** [Frequently asked questions](https://docs.julialang.org/en/v1/manual/faq/) might contain the answer to something that's bothering you. Also see the resources on the [community page](https://julialang.org/community/).

## Problems

### Fill-in-the blank problems

Answers here should be pasted into the Markdown file.  If you need an introduction to Markdown, see an [overview](https://www.markdownguide.org/getting-started/) and [syntax](https://www.markdownguide.org/basic-syntax/) (the corresponding "cheat sheet" page is useful for a quick reminder).

1. Show how you access the help from the REPL on `+`, and then demonstrate two ways of using `+`.  (Use the REPL; in this case, the VS Code documentation browser may be more confusing than helpful.) Paste your answer below:

2. Read the help on the `include` function; the `[]` around `mapexpr` represents optional arguments (you can ignore `mapexpr`, it is used only in very special circumstances).   Note that this is another way to run code, in addition to the methods described on the VS Code page.  (No response is needed for this "question.")

3. The very important [XKCD package](https://github.com/joshday/XKCD.jl) allows you to analyze the history of the comic strip.  To demonstrate facility with modules, packages, and their documentation:
   - Add the XKCD package
   - Having read the documentation on GitHub, use the package to retrieve the most recent comic and paste its "img" URL here:
   - Many packages have their documentation in "Documenter" form. Do a web search to find the main documentation for "Dataframes.jl" and paste its URL here:

4. Use a comprehension to list all odd integers between 1 and 20 (inclusive). The `isodd` function can test if a number is odd. Paste your code below:

### Auto-tested problems

The remaining homework problems are in a separate file, [`learning_julia1_exercises.jl`](learning_julia1_exercises.jl).
This file starts with a comment at the top and you will fill in the details. If you run this file with `include` or hit the "play" button in the upper right corner in VS Code, when done you should pass all tests.

You're not restricted to use the subset of things assigned, you can use any "built-in" Julia construct.
But don't use external packages that do almost all the work for you, unless instructed by the problem.
