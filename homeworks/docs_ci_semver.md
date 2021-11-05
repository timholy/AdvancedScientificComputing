---
title: "Continuous integration, documentation, package versioning, and releases"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 23, 2021 (updated Oct 30, 2021)
geometry: margin=1in
output: pdf_document
---

# Sources for learning

Most problems on this homework focus on documentation and touch only superficially on YAML and crafting your own GitHub actions. This is because PkgTemplates takes care of setting up your Actions for you, and most of the time only minor tweaks are needed. The material below has a pretty comprehensive set of links; you should read this document (and perhaps keep it as a reference), but feel free to be selective about your exploration of the material it links to and focus on just the parts needed to solve the homework.

## Pkg and local development

Pkg allows you to distinguish between dependencies that are required to define your package from extra packages that may be needed for your tests. For this homework, use the [extras section](https://pkgdocs.julialang.org/v1/creating-packages/#Test-specific-dependencies-in-Julia-1.0-and-1.1) of your `Project.toml` to declare such dependencies. (The community seems somewhat mixed on whether the method developed for Julia 1.2 and above is actually an improvement, so we'll use the generic Julia 1.x approach.)

`Pkg.test` runs your tests in a "clean" environment decoupled from any other environment on your machine. This allows you to test whether the package depends on some special configuration on your machine. It is therefore different from `include("runtests.jl")` from within the REPL, which operates in whatever environment is active when you issue the command. It's worth noting that the test environment might be both more restrictive (it may lack packages you have installed in your default environment) and less restrictive (it may include packages in the `[extras]` section that you may not have installed).

Because `Pkg.test` starts a fresh Julia session, it is not [Revise](https://github.com/timholy/Revise.jl)-compatible. To be able to use Revise while developing, [TestEnv.jl](https://github.com/JuliaTesting/TestEnv.jl) allows you to replicate the test environment while using the REPL. Using this package is highly recommended. **Tip**: if you edit the `Project.toml` file after creating a test environment, the changes may not be incorporated. You can just enter `TestEnv.activate("MyPkg")` a second time, and it will switch to a new test environment incorporating the changes (no need to restart Julia unless this changes package versions by more than Revise can handle).

## Continuous integration (CI) via GitHub Actions

There are numerous CI providers. In this course, we'll use one built-in to GitHub: GitHub Actions.
Here are a few links:

- [overview](https://github.com/features/actions)
- [julia-actions](https://github.com/julia-actions): useful actions for Julia packages
- [YAML](https://en.wikipedia.org/wiki/YAML): the "language" used to write actions. If you're writing or heavily editing YAML files, you may find it helpful to install VS Code's YAML extension. (Note: GitHub Actions accepts some syntaxes that get [incorrectly flagged as invalid](https://github.com/SchemaStore/schemastore/issues/1899) by the extension.) The web editor for Actions (enter `.github/workflows` and click the pencil icon for individual files) also gives you visual feedback about what GitHub thinks might be wrong with your actions.
- [Actions](https://docs.github.com/en/actions/learn-github-actions): main documentation for using & creating GitHub Actions

## Documentation

Documentation has a major impact on adoption of your work. Writing good documentation is a learnable skill. One of the best sources I've found describes [four categories of documentation](https://documentation.divio.com/), and we will loosely use that framework in this course.

Most Julia packages that contain documentation beyond the README create it using [Documenter.jl](https://juliadocs.github.io/Documenter.jl/stable/). By calling `PkgTemplates.Template` with the `Documenter` plugin, the basic `docs/` folder gets set up automatically for you; this allows you to skip certain portions of Documenter's own documentation. To save you some time, here are specific sections you'll need for the homework (read other sections as needed):

- [markdown reference](https://docs.julialang.org/en/v1/stdlib/Markdown/) in case you're still getting comfortable with Markdown
- [adding docstrings](https://juliadocs.github.io/Documenter.jl/stable/man/guide/#Adding-Some-Docstrings)
- [cross-referencing](https://juliadocs.github.io/Documenter.jl/stable/man/guide/#Cross-Referencing)
- [pages in the sidebar](https://juliadocs.github.io/Documenter.jl/stable/man/guide/#Pages-in-the-Sidebar)
- [doctests in REPL style](https://juliadocs.github.io/Documenter.jl/stable/man/doctests/#REPL-Examples)
- [preserving data across doctests](https://juliadocs.github.io/Documenter.jl/stable/man/doctests/#Preserving-Definitions-Between-Blocks)
- [doctests in testing](https://juliadocs.github.io/Documenter.jl/stable/man/doctests/#Doctesting-as-Part-of-Testing) so you notice if your docs break
- [deployment](https://juliadocs.github.io/Documenter.jl/stable/man/hosting/#travis-ssh)

Optional documentation add-ons and alternatives:

- [DocstringExtensions](https://juliadocs.github.io/DocStringExtensions.jl/stable/) provides convenient syntax for common tasks.
- [Literate](https://fredrikekre.github.io/Literate.jl/v2/) allows you to weave together code and more extensive documentation and supports a variety of output formats.

## Semantic versioning

Make releases when you've fixed a bug or implemented new features. Julia packages generally follow [semantic versioning](https://semver.org/), with modifications to the rules for [compatibility for pre-1.0 releases](https://pkgdocs.julialang.org/v1/compatibility/#compat-pre-1.0).

## Compatibility

Manage versioning of you dependencies as you would of your own package. The [`[compat]` section of your Project.toml](https://pkgdocs.julialang.org/v1/compatibility/) allows you to specify the allowed versions of your dependencies.
I recommend declaring both lower and upper bounds, i.e., use `DataFrames = "1"` rather than `DataFrames = ">= 1"` because the latter exposes you to risk of breakage (you can't predict what the developers will choose to do in future breaking versions).

A typical workflow goes like this:

1. `Pkg.add` the packages to the environment and get things working. Use this for both true dependencies and test-dependencies; both will be added to the `[deps]` section, but we'll fix that later.
2. Check `Pkg.status` to determine what versions you are using and then manually add those to the `[compat]` section. You should add `[compat]` for all true dependencies, and optionally for test-dependencies, but be aware that adding test-dependency compatibility constraints applies to all users and not just during your testing. (Adding test dependencies to `[compat]` prioritizes test reliability; not adding them prioritizes installation flexibility for users who may not need to run your tests. I am not aware of any clear guidance as to which is better, so this may be mostly a matter of personal preference.) *Bounds on all true dependencies (those in `[deps]`) are required to register a package with Julia's general registry.*

   You may not need to be specific about minor and/or patch versions, i.e., if you happen to be using `SomePkg v1.2.4`, then it's quite possible that `SomePkg = "1"` or `SomePkg = "1.2"` would suffice.
3. For any test-dependencies, move the entry from `[deps]` to `[extras]` and [list them in the `Test` `[targets]`](https://pkgdocs.julialang.org/v1/creating-packages/#Test-specific-dependencies-in-Julia-1.0-and-1.1). Moving things from `[deps]` reduces the number of packages that Pkg will install when users `add` your package (the extras are added only upon running the tests).

Versioning is not just for packages: I often add `[compat]` bounds even to `Project.toml` files I create for local "scripts" (e.g., analyzing a particular data set), to increase the likelihood that this script will continue to be runnable in the future. (If desired, commit the `Manifest.toml` to the project's `git` history so that it becomes a permanent record of the exact versions you are using.)

Tools for managing compatibility:

- [CompatHelper](https://github.com/JuliaRegistries/CompatHelper.jl): stay up-to-date with your dependencies
- [RegistryCompatTools](https://github.com/KristofferC/RegistryCompatTools.jl): determine which packages may be holding back a package you'd like to update
- [LocalRegistry](https://github.com/GunnarFarneback/LocalRegistry.jl) if you are running your own (or your group's own) package registry.

Finally, in cases of conflict, remember the [conflict-resolution documentation](https://pkgdocs.julialang.org/latest/managing-packages/#conflicts). Keeping environments "lean" ("developer tools" in your default environment, and separate environments for individual packages & projects) is the easiest way to reduce the frequency of such conflicts.  Remember that you can use `pkg> activate --temp` to play around with a new package without making it part of a particular reusable environment.


## Releases

### One-time setup

PkgTemplates should have set you up with the [TagBot action](https://github.com/marketplace/actions/julia-tagbot) on your repository, but if not you can copy/paste the workflow manually.
Then, activate the [Registrator app](https://github.com/JuliaRegistries/Registrator.jl) for all repositories in your GitHub account.

### When making a release

Making a release is incredibly easy using the [app interface](https://github.com/JuliaRegistries/Registrator.jl#via-the-github-app): just bump the `version` in your `Project.toml` (you can make simple edits directly in your browser) and make a commit comment on GitHub. Be sure to check the general registry PR (after it has finished running its tests) for any constraints on the release.

For major release events (new packages, important new functionality, or key breaking changes), posting an announcement on Julia discourse's [package announcements](https://discourse.julialang.org/c/package-announcements) is recommended.

# Homework problems

## Check out the repository

Check out the repository, which is privately hosted on GitHub classroom. Ask Tim for a link. **Only those students who completed the "Testing and design (TDD)" homework are eligible for this assignment**. This homework builds on that one, and includes answers for a portion of that problem set.

## Get the repository working locally

The initial repository should fail its tests. Check out a branch and fix it so that it passes tests. **Make changes only of the following kinds**:

- add packages to the project (`Pkg.add`) with their corresponding `[compat]` entries (you can choose whether to list test-only dependencies in `[compat]`, but you will lose points if you do not add `[compat]` for true dependencies)
- add `using` statements to the `src/` and/or `test/` code

When adding packages, distinguish what's needed for the package itself and what's a test-only dependency (see [Pkg and local development](#pkg-and-local-development)). For each missing call, here are the packages you'll need to add to the project:

- `@test_reference`: [ReferenceTests](https://github.com/JuliaTesting/ReferenceTests.jl)
- `scatterplot`: [UnicodePlots](https://github.com/JuliaPlots/UnicodePlots.jl) Seemingly straight from the 1980s, this is everyone's favorite "text-only" plotting package. While Julia has multiple (too many...) more sophisticated graphical plotting packages, this one has the advantage of being runnable even on headless servers (as used by default on GitHub Actions for Ubuntu) and easy to work into the docs via a doctest. There are ways to use and test a true graphical plotting package, but for the purposes of this class, the simplicity and robustness of UnicodePlots are compelling advantages. Besides, it's quite charming and even occasionally useful.

You can add them incrementally in response to error messages and use the stacktrace to figure out whether each is a "real" dependency or a test-dependency.

## Push the package up to GitHub and fix your CI

Submit the branch as a pull request on GitHub. While the package should work locally, you will discover that it doesn't pass CI. Read the logs and determine why. *The failure should be in one of your tests.* If it fails prior to (e.g., in the build stage), loosen some of your `[compat]` bounds and try again. (The error may be in an indirect dependency, but you can resolve it by loosening bounds on the direct dependency, giving Julia more flexibility to find a compatible version.)

To fix the test failure, **do not edit the test**. (This is a small exercise in editing your GitHub Actions.) Instead:

- from the logs, determine which call is failing in the tests. Read the help for the failing call and note that it requires a particular minimum version of Julia.
- edit the `CI.yml` action to test two compatible versions of Julia (one should be the minimum version needed to make the test pass as determined from the help).
- edit the `[compat]` section of `Project.toml` to make your package installable only on compatible versions of Julia

## Write docstrings

Add docstrings for all the exported names of the package, include a module-docstring (which you can generate with `ModuleDocstrings` after adding the others). Ensure:

- that the docstring for `reachable` includes a reference to `connected_nodes`. (Once you build the documentation in the next step, there should be a clickable link from the docstring of `reachable` to the docstring for `connected_nodes`.)
- there should be an example (under an `# Examples` section) for at least one of your docstrings. Examples should be short and work if copy/pasted into the REPL (after loading your package). Make sure it is marked with `jldoctest`.

Writing good documentation can take quite a lot of time, so **to reduce the demands of this homework I will not critique the quality of your writing or clarity of your examples as long as all the key parts are there**. (This is "quick and dirty" documentation, and my main interest is in having you experience the entire workflow.)

## Set up documentation

I will ask you to write a tutorial page and a reference page. For reasons of time (and becaue this is simple package), we will skip "how-to" and "explanation." To save yourself time, you can be quite brief but do not omit any essential components. Here are the key steps (remember, documentation on the necessary components is linked [above](#documentation)):

1. Create an empty file, `docs/src/tutorial.md`
2. Title the "page" `# Tutorial`
3. Add brief text showing how to create a graph and then plot it. (To keep this exercise short, don't include any other functionality in the tutorial.) Use the graph `graph = [[2,3,4], [1,3,4], [1,2], [1,5,6], [4,6], [4,5]]`.

   All examples in your tutorial should use doctests--remember, a key part of a good tutorial is that *it must work*. Using doctests ensures that you don't need to test it manually for each change to the package. Use a named doctest, e.g., `jldoctest tutorial`, so that you can use separate code-blocks, one showing its creation and another showing how it looks when graphed. Your doctest should include the output of the plot as created by `UnicodePlots`.

4. List `tutorial.md` in the `make.jl` file. You don't (yet) need to make modifications to `index.md`.
5. Also in `make.jl`, change the "timholy/CIandDocsExercise.jl" to "AdvancedScientificComputingInJuliaWashU/ci-and-docs-*" where you replace `*` with your user name (this should appear in the URL for this repository). **This is only needed because we're operating with GitHubClassroom, this is not something you'd do for a "normal" package.**
6. Build the documentation. Here's a reliable way in VS Code (assuming you're in the package's environment to start with):

    ```julia
    julia> using CIandDocsExercise

    shell> cd docs
    /home/tim/Documents/teaching/scicomputing/homeworks/CIandDocsExercise/docs

    (CIandDocsExercise) pkg> activate .
    Activating environment at `~/Documents/teaching/scicomputing/homeworks/CIandDocsExercise/docs/Project.toml`

    julia> include("make.jl")
    ```

7. View the docs in your browser (open `docs/build/index.html`). For now, you'll note that your reference material appears in `index.html`. (We'll fix that next.) Check that your tutorial looks roughly as intended. This might be a good time to make a commit.
8. Create a blank `reference.md`. Move the function-documentation currently in `index.md` to `reference.md` and give that page a title (I chose `# Reference`). Write a tiny bit of narrative text in `index.md` to explain what this package is about.
9. Build your documentation again and check that it looks good.
10. Add a `doctest` step to your tests to make sure your documentation doesn't inadvertently break. **Tip**: if you get `UndefVarError` errors when running doctests, it's likely that the tests are running without loading your package. Consider using the syntax `jldoctest; setup=:(using CIandDocsExercise)` so that the test will first load the package without you including it in the example. (If you prefer to add it as a manual step in the example, that's fine too.) See [setup code](https://juliadocs.github.io/Documenter.jl/stable/man/doctests/#Setup-Code) for more information.
11. Once working, set up the secrets for deployment.
12. In `deploydocs` (called from `make.jl`), turn on previews.
13. Submit as a PR. Check that the doc build worked. *If you get doctest failures on an older Julia version but not on 1.6*: Julia changed the way it prints arrays in 1.6. This effects the outcome of some doctests. You may be able to fix this by adding `filter=r"(Vector{.*}|Array{.*})"` to your `jldoctest` line; see [filtering doctests](https://juliadocs.github.io/Documenter.jl/stable/man/doctests/#Filtering-Doctests) for more information. Once you have this working locally (i.e., you haven't broken anything!), add another commit and push again.
14. Inspect the preview by clicking on the "Details" of the "deploy" Action (this typically takes ~15 minutes to show up, at least for the first time, and you'll get a "Site not found" 404 error until then), and merge. **NOTE**: normally this would be straightforward. But because all of these repositories are private, the actual publication of the site is blocked, so the preview link will not work. (You'll have to enjoy the documentation on your own laptop.)


## Ordinarily: ensure your README badges work

Once merged to `main` on GitHub, typically you should wait a few minutes for your documentation to build and then see whether the documentation badge works. Because you haven't registered your package yet, the documentation for the "latest stable release" hasn't been generated (there is no such release). Rely on the "development" docs for this assignment (you can delete the "stable" badge).

However, this won't work because the repository is private. Don't worry about this step.

## Bump version

Make this 1.0! (Sometimes people release 0.x versions for a while and then go to 1.0. Prior to Julia 1.0's release, basically all packages were on 0.x, and many still haven't transitioned.)

Were this a real package, it might be time to register it. (But don't do that.)

## Enable autograde

Uncomment the "autograde" tests (at the end of `runtests.jl`) and check that they pass (or get them passing) locally. Submit another PR. Get it passing CI (it probably will all on its own), merge, and you're done!
