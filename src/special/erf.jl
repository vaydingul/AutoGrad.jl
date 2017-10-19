convel(x,y) = convel(eltype(x), y)
convel{T<:AbstractFloat}(::Type{T}, y) = convert(T, y)
convel{T}(::Type{T}, y) = y

erf1arg = [
(:erf, :(exp_dot(-abs2_dot(x))* convel(x,2/√π)), (-Inf,Inf)),     # \frac{2}{\sqrt{\pi}} \int_0^x e^{-t^2} dt
(:erfc, :(-exp_dot(-abs2_dot(x)) * convel(x,2/√π)), (-Inf,Inf)),   # 1-erf(x)
(:erfcx, :(2y.*x-2/sqrt(pi)), (-Inf,Inf)),           # erfc(x)*exp(x^2)
(:erfi, :(exp_dot(abs2_dot(x))*convel(x,2/√π)), (-Inf,Inf)),     # -i*erf(ix)
(:dawson, :(-2y.*x+1), (-Inf,Inf)),                  # \frac{\sqrt{\pi}}{2} e^{-x^2} erfi(x).
(:erfinv, :(exp_dot(abs2_dot(y))*convel(√π/2)), (-1,1)),       # erf(erfinv(x)) = x
(:erfcinv, :(-exp_dot(abs2_dot(y))*convel(√π/2)), (0,2)),      # erfc(erfcinv(x)) = x
]

for (f,g,r) in erf1arg
    bf = broadcast_func(f)
    @eval @primitive $f(x),dy,y  (dy.*($g))
    if bf != f
        @eval @primitive $bf(x),dy,y  (dy.*($g))
    end
    addtest1(f,r)
end
