using BenchmarkTools

function countelements_bilinear!(counts::AbstractVector{Int}, sequence)
    for idx in eachindex(counts)
        counts[idx] = count(==(idx), sequence)
    end
    return counts
end

function countelements_linear!(counts::AbstractVector{Int}, sequence)
    fill!(counts, 0)
    for item in sequence
        counts[item] += 1
    end
    return counts
end

function run_timing(m::Integer, n::Integer)
    sequence = rand(1:m, n)
    counts = Vector{Int}(undef, m)
    tq = @belapsed countelements_bilinear!($counts, $sequence) seconds=1
    tl = @belapsed countelements_linear!($counts, $sequence) seconds=1
    return tq, tl
end

function run_timing(ms, ns)
    tqs = Matrix{Float64}(undef, length(ms), length(ns))
    tls = similar(tqs)
    for (i, m) in enumerate(ms), (j, n) in enumerate(ns)
        tqs[i, j], tls[i, j] = run_timing(m, n)
    end
    return tqs, tls
end
function run_timing()
    ms, ns = 2 .^(1:10), 2 .^(10:20)
    return (ms, ns, run_timing(ms, ns)...)
end

function write_timing(filename, ms, ns, tqs, tls)
   open(filename, "w") do io
       for (i, m) in enumerate(ms)
            if i == 1
                for n in ns
                    print(io, ",", n)
                end
                println(io)
            end
            print(io, m)
            for j in eachindex(ns)
                print(io, ",(", tqs[i,j], ",", tls[i,j], ")")
            end
            println(io)
        end
    end
end

main(filename="timing_jl.csv") = write_timing(filename, run_timing()...)
