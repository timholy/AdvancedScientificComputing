# In this file, you'll fill in some blanks, and the associated `@test` lines thereafter will check whether
# you've done it correctly. We'll cover testing systematically later in the course.
# For now, know that:
#   - `@test` checks whether the following expression is `true`
#   - `@testset` wraps a collection of tests and gathers statistics. Here, I'm using it just so you can
#     run all the tests even if you have some that fail. (Without `@testset`, execution stops at the first
#     failing test)
#
# Example: if you see
#
#     # Set `a` to be an array with two items, `1` and `7`
#     a =
#     @test length(a) == 2 && a[1] == 1 && a[2] == 7
#
# notice the blank after `a =`: you would edit this to
#
#     # Set `a` to be an array with two items, `1` and `7`
#     a = [1, 7]
#     @test length(a) == 2 && a[1] == 1 && a[2] == 7
#
# Ideally, running the test file passes all tests.
#
# Also, it may be helpful to note you can comment out a block of code using matching `#=`, `=#`, but
# in VS Code it's often just as easy to select the whole range and use Ctrl-/ (⌘/ on Mac) to toggle between
# commented and uncommented. A good working strategy is to start by commenting out all the tests and then
# uncomment them one-by-one as you address them. That way, you can run the test script for each new test
# and check whether all work so far.


using Test

# Try the "gimmee" now!

# Set `a` to be an array with two items, `1` and `7`
a =
@test length(a) == 2 && a[1] == 1 && a[2] == 7

# OK, now let's get serious!

@testset "Learning Julia 1" begin
    # Create a range of all integers from 2 to 5, inclusive
    r =
    @test isa(r, AbstractUnitRange) && first(r) == 2 && last(r) == 5

    # Create an array that stores `Float64`s but otherwise holds the same values as `r` above
    rf =
    @test eltype(rf) == Float64 && rf == r

    # Create a matrix equal to a 2x2 identity matrix (1 on the diagonal, zero on the corners)
    M =
    @test size(M) == (2,2) && M[1,1] == M[2,2] == 1 && M[1,2] == M[2,1] == 0

    # Create a vector of `String`s that has 3 undefined elements, then make the middle one equal to "Julia"
    vstr =
    # you will need one more line here
    @test length(vstr) == 3 && eltype(vstr) == String && !isassigned(vstr, 1) && !isassigned(vstr, 3) && vstr[2] == "Julia"

    # Create two ranges, `row` and `col`: row should go from 1 to 3 (integers) and `col` should contain the even numbers between 2 and 8.
    # Use broadcasting to form a matrix of their product.
    row =
    col =
    m =
    @test isa(row, AbstractUnitRange) && isa(col, AbstractRange) && first(row) == 1 && last(row) == 3 &&
          first(col) == 2 && last(col) == 8 && step(col) == 2
    @test m ==
    [ 2   4   6   8;
      4   8  12  16;
      6  12  18  24
    ]

    # Create a tuple with a `String`, an `Int`, and a `Float64` (of your choice) in that order
    t =
    @test isa(t, Tuple) && isa(t[1], String) && isa(t[2], Int) && isa(t[3], Float64)

    # Create a NamedTuple with fields `make` and `model` with values "Honda" and "Odyssey", respectively
    nt =
    @test nt.make == "Honda"
    @test nt.model == "Odyssey"
    @test isa(nt, NamedTuple)

    # Split this string into words
    str = "Advanced scientific computing"
    sstr =
    @test length(sstr) == 3 && sstr[1] == "Advanced" && sstr[2] == "scientific" && sstr[3] == "computing"

    # Now things will start getting a bit (just a bit) harder
    # If it's useful to write a `for` loop, feel free to look ahead to https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow#For_loops_and_iteration
    # Some problems can be solved in a single line using a comprehension or generator, https://en.wikibooks.org/wiki/Introducing_Julia/Controlling_the_flow#Comprehensions

    # Alphabetize the words in this string, omitting any that contain a 'u'
    # Do not type the answer directly, generate it by exploiting Julia's string-manipulation functions
    animals = "dog cat opossum feline antelope chimp octopus salamander"
    aanimals =  # feel free to use multiple lines to solve this; `aanimals` should hold your final answer
    @test aanimals == ["antelope", "cat", "chimp", "dog", "feline", "salamander"]

    # Compute the sum of the ascii codes in `animals`, excluding spaces
    sascii =
    @test sascii == 5257

    # What is the most common letter, excluding spaces, in `animals` above?
    d =     # this variable should be a dictionary
    mostcommon =    # compute this from `d`
    @test keytype(d) == Char && valtype(d) == Int
    @test d['l'] == 3
    @test mostcommon == 'o'

    # Determine all the unique characters in `animals` using a Set (including the space ' ' this time)
    chars =
    @test isa(chars, Set) && eltype(chars) == Char && length(chars) == 18 && 't' ∈ chars && 'z' ∉ chars
end
