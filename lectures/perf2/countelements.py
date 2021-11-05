import timeit
import numpy as np

def countelements_bilinear(counts, sequence):
    counts.fill(0)
    for idx in range(len(counts)):
        counts[idx] = np.count_nonzero(sequence == idx)
    return counts

def countelements_linear(counts, sequence):
    counts.fill(0)
    for item in sequence:
        counts[item] += 1
    return counts

def closure(f, counts, sequence):
    def inner():
        f(counts, sequence)
    return inner

def run_timing_inner(m, n):
    sequence = np.random.randint(0, high=m, size=n)
    counts = np.zeros(m, dtype=int)
    tmr = timeit.Timer(closure(countelements_bilinear, counts, sequence))
    nq, tq = tmr.autorange()
    tmr = timeit.Timer(closure(countelements_linear, counts, sequence))
    nl, tl = tmr.autorange()
    return tq/nq, tl/nl

def run_timing(ms = 2**np.asarray(range(1,11)), ns = 2**np.asarray(range(10,21))):
    tqs = np.zeros((len(ms), len(ns)))
    tls = tqs.copy()
    for (i, m) in enumerate(ms):
        for (j, n) in enumerate(ns):
            tqs[i, j], tls[i, j] = run_timing_inner(m, n)
    return ms, ns, tqs, tls

def write_timing(filename, ms, ns, tqs, tls):
   with open(filename, "w") as io:
       for (i, m) in enumerate(ms):
            if i == 0:
                for n in ns:
                    io.write(",")
                    io.write(str(n))
                io.write("\n")
            io.write(str(m))
            for j in range(len(ns)):
                io.write(",(")
                io.write(str(tqs[i,j]))
                io.write(",")
                io.write(str(tls[i,j]))
                io.write(")")
            io.write("\n")
