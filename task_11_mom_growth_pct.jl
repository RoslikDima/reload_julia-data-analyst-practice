# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 4. Временные ряды, лаги и смещения (ShiftedArrays.jl)
# Задача 11 (Модуль 4, Задача 2): Относительный темп прироста продаж (MoM %)
# Стандарт: julia-analytics (ShiftedArrays.lag, векторизованный расчет процентов)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, ShiftedArrays

monthly_sales = DataFrame(
    month = ["Янв", "Фев", "Мар", "Апр"],
    sales = [120000.0, 138000.0, 131100.0, 150765.0]
)

sales_dynamics = @chain monthly_sales begin
    transform(
        :sales => lag => :prev_sales,
        :sales => (s -> round.((s .- lag(s)) ./ lag(s) * 100, digits = 1)) => :growth_pct
    )
end

println("Динамика продаж MoM (%):")
println(sales_dynamics)
