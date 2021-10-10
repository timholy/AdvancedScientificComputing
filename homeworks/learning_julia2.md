---
title: "Learning Julia (Part 2)"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 5, 2021
geometry: margin=1in
output: pdf_document
---

# Reading for week 2

This week, reading will be from a mix of the wiki and the manual:

- [Controlling the flow](https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow)
- [Types](https://en.wikibooks.org/wiki/Introducing_Julia/Types)
- [Functions](https://docs.julialang.org/en/v1/manual/functions/)
- [Methods](https://docs.julialang.org/en/v1/manual/methods/): just the sections "Defining methods," "Method ambiguities," "Parametric methods", and "Function-like objects"
- [Constructors](https://docs.julialang.org/en/v1/manual/constructors/)
- **as needed** [Frequently asked questions](https://docs.julialang.org/en/v1/manual/faq/) might contain the answer to something that's bothering you. Also see the resources on the [community page](https://julialang.org/community/).

As before, if these are confusing feel free to check out other sources; also appreciated is feedback about what sources worked for you; whether all, some, or none of the reading was useful; and specific points that you found confusing.

Additionally, a few workflow tips:

- **Debugging**: `@show x` will print `x = 7` if `x` has been assigned the value 7.  This can be very handy when debugging more complicated programs, particularly inside a function where a stream of values printed to the REPL may not be very meaningful unless you know the correspondence between printed values and particular variables.
  `@` indicates a macro, see [Metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming/) for more information.  If you passed `x` to a regular function, the callee receives the value but not the name of the variable used by the caller; in contrast, the macro receives a parsed version of the characters you typed, so the name is accessible.
- **More debugging**: For more difficult problems, Julia's debugger can be helpful.  See the VS Code docs from last week.  [Infiltrator](https://github.com/JuliaDebug/Infiltrator.jl) represents another popular approach to debugging.

# Assignment for week 2

The entire assignment is in the associated [`learning_julia2_exercises.jl`](learning_julia2_exercises.jl).
