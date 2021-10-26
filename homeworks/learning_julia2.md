---
title: "Learning Julia (Part 2)"
author: Timothy E. Holy, Washington University in St. Louis
date: Oct 5, 2021
geometry: margin=1in
output: pdf_document
---

# Learning for week 2

## Main reading

This week, reading will be from a mix of the wiki and the manual:

- [Controlling the flow](https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow)
- [Types](https://en.wikibooks.org/wiki/Introducing_Julia/Types)
- [Functions](https://docs.julialang.org/en/v1/manual/functions/)
- [Methods](https://docs.julialang.org/en/v1/manual/methods/): just the sections "Defining methods," "Method ambiguities," "Parametric methods", and "Function-like objects"
- [Constructors](https://docs.julialang.org/en/v1/manual/constructors/)
- **as needed** [Frequently asked questions](https://docs.julialang.org/en/v1/manual/faq/) might contain the answer to something that's bothering you. Also see the resources on the [community page](https://julialang.org/community/).

As before, if these are confusing feel free to check out other sources; also appreciated is feedback about what sources worked for you; whether all, some, or none of the reading was useful; and specific points that you found confusing.

## Distinguishing identity and equality, and containers and their collection of items

In many programming languages, a common source of bugs and confusion arises in how *references* and *containers* are handled. To demonstrate the issues, let's create a vector with a single value in it:

```julia
julia> x = [1]
1-element Vector{Int64}:
 1
```

and then make a "vector of vectors":

```julia
julia> y = fill(x, 2)
2-element Vector{Vector{Int64}}:
 [1]
 [1]
```

Now let's modify the first entry in `y` to store 2 rather than 1:

```julia
julia> y[1][1] = 2
2
```

and then check `x` and `y`:

```julia
julia> y
2-element Vector{Vector{Int64}}:
 [2]
 [2]

julia> x
1-element Vector{Int64}:
 2
```

This often catches people by surprise. The reason is that `y` is a collection of *references* to other objects. You can think of `y[1]` as "pointing to" `x`, and in this case so does `y[2]`. Consequently, when you modify `y[1]`, you're actually modifying `x`.

One way to check what's happening is to use `===`, which means "identically equal." In the case of a container, it checks not just "do these two boxes have the same content?" but also "are they literally the same box?"  For example:

```julia
julia> x == x
true

julia> x === x
true
```

but

```julia
julia> [2] == [2]
true

julia> [2] === [2]
false
```

In the example with `x` we are literally dealing with the same container, whereas in the second case we are creating two different containers that happen to store the same value. In the case of `y`,

```julia
julia> y[1] === y[2]
true
```

and so it just holds two references to the same object.

`copy` behaves similarly, because it creates a "shallow copy":

```julia
julia> v1 = [[1]]
1-element Vector{Vector{Int64}}:
 [1]

julia> v2 = copy(v1)
1-element Vector{Vector{Int64}}:
 [1]

julia> v1 == v2
true

julia> v1 === v2
false

julia> v1[1] === v2[1]
true
```

So it creates a new *outer* container, but then copies the *references* rather than duplicating the internal array. If you need to copy recursively, you can use `deepcopy`. Note, however, that `deepcopy` can cause significant concerns of its own; these are well-described in the [Python documentation](https://docs.python.org/3/library/copy.html) which uses the same names as Julia. In real code, it's almost always better to know what you are dealing with and what you're trying to accomplish, and then handle it by more careful `copy`ing.

By understanding the issues, you can always get whatever behavior you actually want. For example, we could have created `y` like this:

```julia
julia> x = [1];

julia> y = [copy(x) for i = 1:2]
2-element Vector{Vector{Int64}}:
 [1]
 [1]

julia> y[1][1] = 2
2

julia> y
2-element Vector{Vector{Int64}}:
 [2]
 [1]

julia> x
1-element Vector{Int64}:
 1
```

Making sure that each *entry* of `y` is a separate copy of `x` divorces them from `x` and each other. However, had we wished to maintain the connection to `x` for the second entry but not the first, we could have done this:

```julia
julia> y = [copy(x), x]
2-element Vector{Vector{Int64}}:
 [1]
 [1]

julia> x[1] = 7
7

julia> y
2-element Vector{Vector{Int64}}:
 [1]
 [7]
```

It should be noted that this doesn't happen in Matlab, because Matlab uses a technique "behind the scenes" known as [copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write). This has the major advantage of preventing surprises like the one above, while also avoiding the worst performance costs of unnecessary copying. It has the major disadvantage of making it impossible to create functions that modify their inputs: in Matlab, you can't create a function like Julia's `push!` or any others with a `!`. You also can't create objects that "maintain their links" with others in a manner that supports mutation. Languages like Julia, Python, C, and many others therefore avoid copy-on-write.

## Workflow tips

Some debugging tips:

- `@show x` will print `x = 7` if `x` has been assigned the value 7.  This can be very handy when debugging more complicated programs, particularly inside a function where a stream of values printed to the REPL may not be very meaningful unless you know the correspondence between printed values and particular variables.
  `@` indicates a macro, see [Metaprogramming](https://docs.julialang.org/en/v1/manual/metaprogramming/) for more information.  If you passed `x` to a regular function, the callee receives the value but not the name of the variable used by the caller; in contrast, the macro receives a parsed version of the characters you typed, so the name is accessible.
- For more difficult problems, Julia's debugger can be helpful.  See the VS Code docs from last week.  [Infiltrator](https://github.com/JuliaDebug/Infiltrator.jl) represents another popular approach to debugging.

# Assignment for week 2

The entire assignment is in the associated [`learning_julia2_exercises.jl`](learning_julia2_exercises.jl).
