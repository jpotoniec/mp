#!/usr/bin/env python3

import math
import itertools

def prime_factors(n):
    """Returns all the prime factors of a positive integer"""
    factors = []
    d = 2
    while n > 1:
        while n % d == 0:
            factors.append(d)
            n /= d
        d = d + 1

    return factors

def order(a, b):
    x=1
    for i in range(a*b):
        x=(x*b)%(a*b-1)
        if x == 1:
            return i+1
    assert False


#safe_primes = [5, 7, 11, 23, 47, 59, 83, 107, 167, 179, 227, 263, 347, 359, 383, 467, 479, 503, 563, 587, 719, 839, 863, 887, 983, 1019, 1187, 1283, 1307, 1319, 1367, 1439, 1487, 1523, 1619, 1823, 1907]
#
#for p in safe_primes:
#    factors = prime_factors(p+1)
#    for l in range(1, len(factors)-1):
#        for f in itertools.combinations(factors, l):
#            a = 1
#            for val in f:
#                a *= val
#            b = (p+1)//a
#            if a < b:
#                if order(a, b) != a*b-2:
#                    print(a, b, order(a, b), a*b-1)
#
#assert False

a = 4
b = 6

def f(c, x):
    return (a*x+c)//b, (a*x+c)%b

x=1
for i in range(a*b):
    x=(x*b)%(a*b-1)
    if x == 1:
        print("Rząd:", i+1, "oczekiwany:", a*b-2, "lub", (a*b-2)//2)
        break

print("=========")

c, x = 2, 1
n = 100
hist = [0]*(a*b)
for i in range(n*(a*b-2)):
    c, x = f(c, x)
    hist[x] += 1
for i in range(a*b):
    print(i, hist[i])
#for i in range(b+1):
#    print(i, hist[i])
#print(sum(hist[0:b]))
#for val in hist[1:-1]:
#    assert val == n
#assert hist[0] == hist[-1] == 0
