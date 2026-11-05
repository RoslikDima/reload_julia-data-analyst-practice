# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 4. Временные ряды, лаги и смещения (ShiftedArrays.jl)
# Задача 10 (Модуль 4, Задача 1): Расчет прироста выручки день-к-дню (DoD)
# Стандарт: julia-analytics (ShiftedArrays.lag, параллельные пары в transform)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, ShiftedArrays

daily_revenue = DataFrame(
    day = [1, 2, 3, 4, 5],
    revenue = [45000.0, 48500.0, 47200.0, 52000.0, 56400.0]
)

revenue_growth = @chain daily_revenue begin
    sort(:day)
    transform(
        :revenue => lag => :prev_revenue,
        :revenue => (r -> r .- lag(r)) => :revenue_diff
    )
end

println("Прирост выручки день-к-дню (DoD):")
println(revenue_growth)
