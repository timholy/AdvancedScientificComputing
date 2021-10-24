---
title: "Continuous integration, documentation, package versioning, and releases"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 23, 2021
geometry: margin=1in
output: pdf_document
---

# Sources for learning

Most problems on this homework focus on documentation and touch only superficially on YAML and crafting your own GitHub actions. This is because PkgTemplates takes care of setting up your Actions for you, and most of the time only minor tweaks are needed. The material below has a pretty comprehensive set of links; you should read this document (and perhaps keep it as a reference), but feel free to be selective about your exploration of the material it links to and focus on just the parts needed to solve the homework.

## Pkg and local development

Pkg allows you to distinguish between dependencies that are required to define your package from extra packages that may be needed for your tests. For this homework, use the [extras section](https://pkgdocs.julialang.org/v1/creating-packages/#Test-specific-dependencies-in-Julia-1.0-and-1.1) of your `Project.toml` to declare such dependencies. (The community seems somewhat mixed on whether the method developed for Julia 1.2 and above is actually an improvement, so we'll use the generic Julia 1.x approach.)

`Pkg.test` runs your tests in a "clean" environment decoupled from any other environment on your machine. This allows you to test whether the package depends on some special configuration on your machine. It is therefore different from `include("runtests.jl")` from within the REPL, which operates in whatever environment is active when you issue the command. It's worth noting that the test environment might be both more restrictive (it may lack packages you have installed in your default environment) and less restrictive (it may include packages in the `"extras"` section that you may not have installed).

Because `Pkg.test` starts a fresh Julia session, it is not [Revise](https://github.com/timholy/Revise.jl)-compatible. To be able to use Revise while developing, [TestEnv.jl](https://github.com/JuliaTesting/TestEnv.jl) allows you to replicate the test environment while using the REPL. Using this package is highly recommended.

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
2. Check `Pkg.status` to determine what versions you are using and then manually add those to the `[compat]` section. You should add `[compat]` for all true dependencies, and optionally for test-dependencies, but be aware that adding test-dependency compatibility constraints applies to all users and not just during your testing. *Bounds on all true dependencies are required to register a package with Julia's general registry.*

   You may not need to be specific about minor and/or patch versions, i.e., if you happen to be using `SomePkg v1.2.4`, then it's quite possible that all `v1.x.x` or `v1.2.x` versions would suffice.
3. For any test-dependencies, move the entry from `[deps]` to `[extras]` and [list them in the `Test` `[targets]`](https://pkgdocs.julialang.org/v1/creating-packages/#Test-specific-dependencies-in-Julia-1.0-and-1.1). Moving things from `[deps]` reduces the number of packages that Pkg will install when users `add` your package (the extras are added only upon running the tests).

Versioning is not just for packages: I often add `[compat]` bounds even to `Project.toml` files I create for local "scripts" (e.g., analyzing a particular data set), to increase the likelihood that this script will continue to be runnable in the future. (If desired, commit the `Manifest.toml` to the project's `git` history so that it becomes a permanent record of the exact versions you are using.)

Tools for managing compatibility:

- [CompatHelper](https://github.com/JuliaRegistries/CompatHelper.jl): stay up-to-date with your dependencies
- [RegistryCompatTools](https://github.com/KristofferC/RegistryCompatTools.jl): determine which packages may be "pinning" a package you want to update to an older version
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

??Clone from GitHub classroom? Or just continue from the TDD homework??

Needed:
- something that requires external packages (for [compat] exercises). Maybe graph layout (spectral) which I write and they just add a plotting package. (Do they write any of the plotting at all?)
- also a test-only dependency

## Copy/paste your source code & tests

## Customize the CI

Drop/add/modify a Julia version. But maybe get them to figure this out via the logs.

## Write docstrings

Ensure that one docstring references another.

Including a module docstring!

## Set up documentation

Write a tutorial page, an explanation page, and a reference page. We'll skip the "how-to" because this package is fairly simple and the tutorial should suffice for most users.

All examples in your tutorial should use doctests.

Add doctesting to tests

Build the documentation & view locally. Once working, set up the secrets for deployment. Also add previews to `docdeploy`.

## Ensure your README badges work

Because you haven't registered your package yet, the documentation for the "latest stable release" hasn't been generated (there is no such release). Rely on the "development" docs for this assignment (you can delete the "stable" badge).

## Bump version

Make this 1.0! (Sometimes people release 0.x versions for a while and then go to 1.0. Prior to Julia 1.0's release, basically all packages were on 0.x, and many still haven't transitioned.)
