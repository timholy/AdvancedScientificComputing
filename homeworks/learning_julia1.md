---
title: "Learning Julia (Part 1)"
author: Timothy E. Holy, Washington University in St. Louis
date: Jan 31, 2023
geometry: margin=1in
output: pdf_document
---

# Installing Julia and setting up your environment

## `juliaup`

To install Julia, I recommend using [`juliaup`](https://github.com/JuliaLang/juliaup), which presumably (?) stands for "Julia updater." Julia as a *language* is stable (code you write today should work far into the future), but as an *experience* it keeps improving. `juliaup` makes it trivial to migrate to new julia versions, to have multiple versions installed simultaneously, and to select the one you prefer as your default.

Follow the instructions to install `juliaup` on the page linked above. Follow their advice to avoid use of software repositories (e.g., homebrew) and stick to the recommended methods.

Installing `juliaup` will automatically install the current stable release of Julia. At present (spring 2023), I also recommend installing and using the "beta" release:

```
juliaup add beta
juliaup default beta
```

as the upcoming Julia 1.9 has some features that make it more pleasant to use. (Notably, plotting, DataFrames/CSV files, etc are much faster on first use.) However, if you encounter trouble you can always go back to 1.8.x:

```
juliaup default release
```

that is the current stable release.

## Add the Julia extension for VS Code

Add support for Julia via the normal [extensions](https://code.visualstudio.com/docs/editor/extension-marketplace) mechanism:

- click on the extensions icon
- type `julia` in the search bar; the Julia extension should be the first entry
- click `Install`. You should see a new icon with 3 circles appear.
- **Important**: if you decide to use the `beta` version of Julia, click on the Julia extension in the search pane to open its full description. In the description page, click on "Switch to Pre-Release Version" (near the top).  Support for Julia 1.9 has not yet landed in the released version of the extension.

## Launch Julia from within VS Code

Open VS Code and then start the Julia REPL: on Windows the default key binding is `Alt-j Alt-o`. I'm not certain what it is on Macs, but on any platform you can discover it in the following way:

- in the menus across the top, click `View` -> `Command Palette...`
- in the palette search bar, type "julia repl"
- find the entry that says "Julia: Start REPL". Either click on it or note the assigned shortcut. If there is no shortcut, consider assigning one (click on the "gears" icon to configure).

After you do this, you should see the main editing pane split in two and after a short delay see

```
julia>
```

in the window. If so, congrats! You are ready to start playing interactively with Julia.

Note that there are many ways to run the Julia REPL, including via a separate terminal program and from Jupyter notebooks launched via Anaconda; the reading below will describe some of these other approaches in more detail.
This course will generally assume you're using the VS Code REPL, but there is nothing wrong with other approaches.

See [here for full documentation on VS Code-Julia integration](https://www.julia-vscode.org/docs/stable/).
One particularly worthwhile step: check the keybindings for [code execution](https://www.julia-vscode.org/docs/stable/userguide/runningcode/):

- in the menus across the top, click `View` -> `Command Palette...`
- in the palette search bar, type "julia execute"
- check the assigned shortcuts for various options, particularly "Julia: Execute Code in REPL"

I find the most useful one is "Julia: Execute Code in REPL", which executes any code you have selected in the edit pane. This greatly facilitates interactive development as it allows you to inspect the results of individual lines as you write and debug code in scripts and packages.

# Sources for learning

The [learning page](https://julialang.org/learning/) lists many resources for learning Julia.  You are allowed to consult any source, but here are some recommendations:

- for experienced programmers, [the wiki](https://en.wikibooks.org/wiki/Introducing_Julia) seems to be a fairly good blend of didactic and practical material presented in a compact, efficient manner.  I recommend this as your default source.  Its main weakness is that it's not completely "linear" so you may need to read other sections to understand some of the points in the section you're studying. One important point: **ignore their installation advice**, use the `juliaup` approach described above.
- if you need a little more systematic explanation, [Think Julia](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) provides a more polished experience at the expense of being longer
- the [manual](https://docs.julialang.org/en/v1/) is the most authoritative and up-to-date of all of these. Many chapters are excellent. The only reason I don't recommend it as a primary learning tool is that the manual is uneven in its expectations: some chapters are written for the needs of near-beginners, whereas making sense of others almost requires a computer science degree. Don't be afraid to consult the manual, it really is great in many places, but don't be discouraged about your own progress if the portions you happen to read end up being confusing.
- since all of you know at least one other language, the [Noteworthy differences page](https://docs.julialang.org/en/v1/manual/noteworthy-differences/) of the manual may help you get up to speed quickly.

## Reading for week 1

We'll mostly read the wiki (out of its default order, and with omission of some chapters).  A close second choice would be the corresponding manual chapters.

In the wiki:

- [The REPL](https://en.wikibooks.org/wiki/Introducing_Julia/The_REPL)
- Modules and packages:
  + [Intro to modules and packages](https://en.wikibooks.org/wiki/Introducing_Julia/Modules_and_packages)
  + [Pkg: getting started](https://pkgdocs.julialang.org/v1/getting-started)
  + [Pkg: managing packages](https://pkgdocs.julialang.org/v1/managing-packages)

  **Pro tip**: the two `Pkg` documentation pages were generated with [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/), which we'll learn to use in the course. Importantly, all of the pages it produces have a little "Version" indicator in the lower left. For `Pkg`, make sure the version matches your Julia version (type `Base.VERSION` in the REPL if you're unsure).  If you're reading documentation on a specific package, it should match the package version you have installed (see `Pkg.status` or `pkg> status`). If you're using a beta version of Julia, choose `dev`.
- [Arrays and tuples](https://en.wikibooks.org/wiki/Introducing_Julia/Arrays_and_tuples)
- [Strings and characters](https://en.wikibooks.org/wiki/Introducing_Julia/Strings_and_characters)
- [Dictionaries and sets](https://en.wikibooks.org/wiki/Introducing_Julia/Dictionaries_and_sets)
- [Controlling the flow](https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow). Particularly useful on the first homework are the parts on `for` loops, comprehensions, and generators.
- **as needed** [Frequently asked questions](https://docs.julialang.org/en/v1/manual/faq/) might contain the answer to something that's bothering you. Also see the resources on the [community page](https://julialang.org/community/).

## Problems

The problems are now distributed via GitHub classroom. See the [2021 edition](../README.md) of the course if you're using this externally.
