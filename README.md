# Tropical

[![Build Status](https://github.com/thofma/Tropical.jl/workflows/Run%20tests/badge.svg)](https://github.com/thofma/Tropical.jl/actions?query=workflow%3A%22Run%20tests%22+branch%3Amaster)

## Installation

In the REPL type

```julia
]add https://github.com/thofma/Tropical.jl
```

If you want to play with the package and make changes, type

```julia
]dev https://github.com/thofma/Tropical.jl
```

## Summary

First stab at tropical rings in Oscar. This implementation
inserts tropical rings and their elements into the Oscar
hierarchy as a *ring* and *ring elements*, making all the ring
functionality available. Here is a quick example:

```julia
julia> T = tropical_ring(min)
Tropical ring (min)

julia> T(2) * T(3)
(5)

julia> T(2) + T(0)
(0)

julia> one(T)
(0)

julia> zero(T)
∞

julia> Tx, x = T["x"]
(Univariate Polynomial Ring in x over Tropical ring (min), x)

julia> x^2 + x
x^2 + x
```

To create tropical polynomials, there is also a `@tropical` macro.

```julia
julia> T = tropical_ring(min)
Tropical ring (min)

julia> Tx, x = PolynomialRing(T, "x" => 1:3);

julia> @tropical min(1, x[1], x[2], 2*x[3])
x[1] + x[2] + x[3]^2 + (1)
```

For more examples see `test/runtests.jl`.

## More details

Internally, a tropical ring element is either a rational number
(of type `fmpq`) or infinity. To accommodate both conventions (min/max),
the types are parameterized by `T`, which is either `typeof(min)` or
`typeof(max)`. All this is hidden behind `+` and `*`.

At certain places Oscar (or the packages Oscar is built upon) assumes
that `R(1)` is the one of the ring `R` (and similar for zero). For this
reason we have to implement our own version of various functions, for
example printing of polynomials or zero/one of polynomial rings.
