# As with the first half of this assignment, `learning_julia1_exercises.jl`,
# fill in the missing implementation and pass the `@test`s.
#
# If you're writing your code within the `@testset`, the functions will not be available outside it.
# (A `@testset` defines an enclosed scope that doesn't "pollute" the outside.)
# You may find this makes it harder to develop and debug your code.
# Remember that in VS Code you can select a range of lines and hit Ctrl-Enter to evaluate it,
# and that may make it easier to experiment in VS Code's Julia REPL.
#
# We're also extending your usage of Test by introducing `@test_throws`.
# Read its help to see what it does. When you pass argument(s) to the exception type, you check that, e.g.,
# a particular message will be passed to the user.
# Starting in Julia 1.8 it will be possible to check the error message without being concerned about
# the exception type. (https://github.com/JuliaLang/julia/pull/41888)

using Test

@testset "Learning Julia 2" begin
    # Problem 1 [Adapted from ThinkJulia, exercise 3-2]:
    # Create a function `rightjustify` that prints a string with the right number of leading spaces
    # so that the final character aligns with a chosen column.
    # I've given you the signature of one method; also create another method that supplies `stdout`
    # as the default `io` choice. See the style guide for more info about recommended best
    # practices for ordering arguments for Julia functions:
    # https://docs.julialang.org/en/v1/manual/style-guide/#Write-functions-with-argument-ordering-similar-to-Julia-Base
    function rightjustify(io::IO, str::AbstractString, col::Integer = 70)
        # fill me in!
    end
    # also define a method that doesn't have `io` supplied

    # here are my tests (don't modify this code)
    checkstr(ostr, refstr, len) = @test length(ostr) == len && endswith(ostr, refstr) && strip(ostr) == refstr
    for str in ("short", "kind of medium", "getting longer, but not too huge")
        checkstr(sprint(rightjustify, str),     str, 70)
        checkstr(sprint(rightjustify, str, 80), str, 80)
    end
    mktemp() do fname, io
        str = "send me to stdout!"
        redirect_stdout(io) do
            rightjustify(str)
        end
        seek(io, 0)
        checkstr(chomp(read(io, String)), str, 70)
    end


    # Problem 2: adapted from https://exercism.org/tracks/julia/exercises/robot-simulator
    # (Exercism is a site offering programming exercises in many different languages, with a nice
    #  framework for in-browser coding, automated testing, progress-monitoring, and even mentoring.)
    # The version of this problem on Exercism encourages you to develop a custom type, which is great,
    # but here we're going to treat it as an exercise in control-flow.
    # If you wish, you can put everything in a single function.
    #
    # A robot starts at a location `(x, y)`, where both `x` and `y` are integers, facing in a specified direction
    # ('N'=North, 'S'=South, 'E'=East, 'W'=West). `x` is the East-West axis and `y` the North-South axis.
    # You also supply a string, where each character of the string is one of the following:
    # - 'A': advance one step in the direction it's facing
    # - 'R': turn right
    # - 'L': turn left
    # When the robot turns, it pivots without changing its location. For example, "RAALAL" means:
    # 1. turn right
    # 2. advance two spaces
    # 3. turn left
    # 4. advance one space
    # 5. turn left
    #
    # Your code should return both the final position and the direction the robot is facing.
    # See if you can come up with a more efficient approach than a huge nest of `if...else...end`
    # statements. My solution is less than 20 lines of code.
    # Hint: some of the better solutions might use `%` or `mod1` (read their help strings).

    function robot_command(cmd, (x, y), dir)  # argument destructuring syntax: https://docs.julialang.org/en/v1/manual/functions/#Argument-destructuring
        # you write the body
    end

    # Single steps (these are deliberately written out in long form to avoid giving too much of the solution away)
    @test robot_command("R", (0, 0), 'N') == ((0, 0), 'E')
    @test robot_command("R", (0, 0), 'E') == ((0, 0), 'S')
    @test robot_command("R", (0, 0), 'S') == ((0, 0), 'W')
    @test robot_command("R", (0, 0), 'W') == ((0, 0), 'N')
    @test robot_command("L", (0, 0), 'N') == ((0, 0), 'W')
    @test robot_command("L", (0, 0), 'E') == ((0, 0), 'N')
    @test robot_command("L", (0, 0), 'S') == ((0, 0), 'E')
    @test robot_command("L", (0, 0), 'W') == ((0, 0), 'S')
    @test robot_command("A", (0, 0), 'N') == ((0, 1), 'N')
    @test robot_command("A", (0, 0), 'E') == ((1, 0), 'E')
    @test robot_command("A", (0, 0), 'S') == ((0, -1), 'S')
    @test robot_command("A", (0, 0), 'W') == ((-1, 0), 'W')
    @test_throws ErrorException("robot command K not recognized") robot_command("K", (0, 0), 'W')
    # Sequences
    for x in (7, 22), y in (3, -7)
        @test robot_command("RAALAL", (x, y), 'N') == ((x+2, y+1), 'W')
        @test robot_command("ARAAALA", (x, y), 'W') == ((x-2, y+3), 'W')
        for dir in ('N', 'E', 'S', 'W')
            @test robot_command("ALALALAL", (x, y), dir) == ((x, y), dir)
        end
    end


    # Problem 3: introduction to structures
    # Note that when you redefine structures, you may have to shut down your Julia session and restart it.
    # (Julia won't let you change an existing `struct` definition.)
    # a) create a new subtype of `Integer` called `MyInt`, one that stores an `Int` internally

    @test MyInt(3) isa Integer
    @test !ismutable(MyInt(3))

    # b) extend `Base`'s `==` so that you can compare `MyInt` against any other `Integer`s
    #    You can either `import Base: ==` and write `==(a, b)` methods, or write your new
    #    methods using module qualification, `Base.:(==)(a, b)`. The `:` is needed only for operators;
    #    when extending other functions, you don't need `:`.

    @test MyInt(3) == 3
    @test 2 == MyInt(2)
    @test MyInt(1) != MyInt(2)   # this will follow automatically if you define `==`
    @test MyInt(-2) == Int16(-2)

    # c) extend `+` so that `MyInt` "wraps around" at 5: `MyInt(5) + 1` return `MyInt(1)` and then it starts counting up again.

    @test MyInt(1) + 1  === MyInt(2)
    @test MyInt(2) + 1  === MyInt(3)
    @test MyInt(3) + 1  === MyInt(4)
    @test MyInt(4) + 1  === MyInt(5)
    @test MyInt(5) + 1  === MyInt(1)
    @test MyInt(4) + 2  === MyInt(1)
    @test MyInt(3) + 10 === MyInt(3)

    # d) also extend the `typemax` "trait" for `MyInt`. Read the docs for `typemax`, and then do `@edit typemax(UInt8)`
    #    to see how such methods are implemented. Mimic that definition.

    @test typemax(MyInt)    === MyInt(5)
    @test typemax(MyInt(2)) === MyInt(5)   # note you didn't have to write a method specifically for this test
    @test typemax(UInt8)    === 0xff       # just to make sure it's not broken

    # Problem 4: encapsulating data in objects & functions
    # a) Create a parametric `struct` representing a unit Gaussian in 1d: if `g isa Gaussian`, then
    #    - `g.μ` should return the mean (center) of the Gaussian, a scalar of type `T`
    #    - `g.σ` should return the standard deviation, a scalar also of type `T`
    #    Also, `T` should only be allowed to be a subtype of `Real`

    g = Gaussian(1.0, 0.5)
    @test g isa Gaussian{Float64}
    @test g.μ === 1.0
    @test g.σ === 0.5
    g = Gaussian(2, 5)
    @test g isa Gaussian{Int}
    @test g.μ === 2
    @test g.σ === 5
    @test_throws TypeError Gaussian{String}

    # b) make objects of type Gaussian callable (review https://docs.julialang.org/en/v1/manual/methods/#Function-like-objects
    #    as needed), so that `g(x)` returns `exp(-(x - μ)^2/(2*σ^2))`.

    g = Gaussian(1.0, 0.5)
    @test g(2) ≈ 0.1353352832366127
    @test g(2.0) == g(2)
    @test g(1.25) ≈ 0.8824969025845955
    g = Gaussian(2, 5)
    @test g(-3) ≈ 0.6065306597126334

    # c) now do the same thing with a *closure*, a function that wraps data.  Here's a demo:
    """
        f = adder(x)

    Return a function `f` that adds `x` to any number.
    """
    function adder(x)
        return y::Number -> x+y
    end
    f = adder(3)
    @test f isa Function
    @test f(2) == 5
    @test_throws MethodError f("hello")   # f isn't defined on strings because of the `y::Number`

    # Another way you could have written the above is
    # function adder(x)
    #     f = function(y::Number)
    #         return x + y
    #     end
    #     return f
    # end
    # If that's clearer to you, feel free to use that form.

    # Now you write one: `f = gaussian_closure(μ, σ)` should return a function `f` such that
    # `f(x) == exp(-(x - μ)^2/(2*σ^2))`. Enforce the fact that both `μ` and `σ` must be `Real`,
    # as must `x`, but don't require them to be the same type.

    f = gaussian_closure(2, 5)
    @test f isa Function
    @test f(-3) ≈ 0.6065306597126334
    @test_throws MethodError f("hello")
    @test_throws MethodError gaussian_closure("hello", 5)
    @test_throws MethodError gaussian_closure(2, [5])

    # Bonus points! (No need to turn anything in)
    # - make `Gaussian(3, 5.0)` work. Read about `promote`.
    # - make `Gaussian(3.0, 5.0)` print as `Gaussian(μ=3.0, σ=5.0)` and define an additional kwarg-constructor,
    #   with default values of 0 and 1 for `μ` and `σ`, respectively.
end
