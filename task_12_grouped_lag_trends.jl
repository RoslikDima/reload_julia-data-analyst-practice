# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 4. Временные ряды, лаги и смещения (ShiftedArrays.jl)
# Задача 12 (Модуль 4, Задача 3): Изолированный расчет лагов внутри групп
# Стандарт: julia-analytics (sort -> groupby -> transform с lag)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, ShiftedArrays

multi_store_sales = DataFrame(
    store = ["Аптека №1", "Аптека №2", "Аптека №1", "Аптека №2", "Аптека №1", "Аптека №2"],
    month = [1, 1, 2, 2, 3, 3],
    sales = [100000.0, 180000.0, 115000.0, 175000.0, 130000.0, 190000.0]
)

store_trends = @chain multi_store_sales begin
    sort([:store, :month])
    groupby(:store)
    transform(
        :sales => lag => :prev_sales,
        :sales => (s -> s .- lag(s)) => :diff_sales
    )
end

println("Динамика продаж по аптекам (изолированный лаг):")
println(store_trends)
