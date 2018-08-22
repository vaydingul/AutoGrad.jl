include("header.jl")

o = (:delta=>1e-3,:verbose=>1)
using SpecialFunctions

@testset "specialfunctions" begin
    # `airy(k,x)` is deprecated, use `airyai(x)`, `airyaiprime(x)`, `airybi(x)` or `airybiprime(x)` instead.
    @test randcheck(airyai; o...) # @primitive airyai(x),dy (dy.*(airyaiprime.(x)))
    @test randcheck(airyaiprime; o...) # @primitive airyaiprime(x),dy (dy.*(x .* airyai.(x)))
    # airyaiprimex
    # airyaix
    @test randcheck(airybi; o...) # @primitive airybi(x),dy (dy.*(airybiprime.(x)))
    @test randcheck(airybiprime; o...) # @primitive airybiprime(x),dy (dy.*(x .* airybi.(x)))
    # airybiprimex
    # airybix
    # `airyprime(z::Number)` is deprecated, use `airyaiprime(z)` instead.
    # `airyx(k,x)` is deprecated, use `airyaix(x)`, `airyaiprimex(x)`, `airybix(x)` or `airybiprimex(x)` instead.
    # besselh
    # besselhx
    # besseli
    # besselix
    # besselj
    @test randcheck(besselj0; o...) # @primitive besselj0(x),dy (dy.*(-(besselj1.(x))))
    @test randcheck(besselj1; o...) # @primitive besselj1(x),dy (dy.*((besselj0.(x) - besselj.(2,x)) / 2))
    # besseljx
    # besselk
    # besselkx
    # bessely
    @test randcheck(bessely0,val_gt_0; o...) # @primitive bessely0(x),dy (dy.*(-(bessely1.(x))))
    @test randcheck(bessely1,val_gt_0; o...) # @primitive bessely1(x),dy (dy.*((bessely0.(x) - bessely.(2,x)) / 2))
    # besselyx
    # beta
    # cosint
    @test randcheck(dawson; o...) # @primitive dawson(x),dy,y (dy.*((-2y) .* x + 1))
    @test randcheck(digamma; o...) # @primitive digamma(x),dy,y (dy.*(trigamma.(x)))
    @test randcheck(erf; o...) # @primitive erf(x),dy,y (dy.*(exp.(-(abs2.(x))) * convert(eltype(x), 2 / √π)))
    @test randcheck(erfc; o...) # @primitive erfc(x),dy,y (dy.*(-(exp.(-(abs2.(x)))) * convert(eltype(x), 2 / √π)))
    @test randcheck(erfcinv,val_lt_2; o...) # @primitive erfcinv(x),dy,y (dy.*(-(exp.(abs2.(y))) * convert(eltype(x), √π / 2)))
    @test randcheck(erfcx; o...) # @primitive erfcx(x),dy,y (dy.*((2y) .* x - convert(eltype(x), 2 / √π)))
    @test randcheck(erfi; o...) # @primitive erfi(x),dy,y (dy.*(exp.(abs2.(x)) * convert(eltype(x), 2 / √π)))
    @test randcheck(erfinv,abs_lt_1; o...) # @primitive erfinv(x),dy,y (dy.*(exp.(abs2.(y)) * convert(eltype(x), √π / 2)))
    # eta
    @test randcheck(gamma,abs_gt_0; o...) # @primitive gamma(x),dy,y (dy.*(y .* digamma.(x)))
    # hankelh1
    # hankelh1x
    # hankelh2
    # hankelh2x
    @test randcheck(invdigamma; o...) # @primitive invdigamma(x),dy,y (dy.*(1 ./ trigamma.(y)))
    # lbeta
    # `lfact` is deprecated, use `lfactorial` instead.
    # lfactorial
    @test randcheck(lgamma,abs_gt_0; o...) # @primitive lgamma(x),dy,y (dy.*(digamma.(x)))
    # @test randcheck(polygamma) # @primitive polygamma(x1,x2),dy,y  nothing  unbroadcast(x2,dy.*polygamma(x1+1,x2))
    # sinint
    @test randcheck(trigamma,val_gt_0; o...) # @primitive trigamma(x),dy,y (dy.*(polygamma.(2,x)))
    # zeta
end
