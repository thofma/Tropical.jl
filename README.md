# Tropical

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

For more examples see `test/runtests.jl`.

## More details

Internally, a tropical ring elements is either a rational number
(of type `fmpq`) or infinity. To accommodate both conventions (min/max),
the types are parameterized by `T`, which is either `typeof(min)` or
`typeof(max)`.

At certain places Oscar (or the packages Oscar is built upon) assumes
that `R(1)` is the one of the ring `R` (and similar for zero). For this
reason we have to implement our own version of various functions, for
example printing of polynomials or zero/one of polynomial rings.
