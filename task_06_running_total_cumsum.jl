# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 2. Пайплайны @chain, канонические пары и агрегации
# Задача 6: Накопительный итог (cumsum) с сохранением строк внутри групп
# Стандарт: julia-analytics (sort -> groupby -> transform(:col => cumsum))
# ==============================================================================

using DataFrames, Chain

mini_sales = DataFrame(
    pharmacy = ["Аптека №1", "Аптека №2", "Аптека №1", "Аптека №2"],
    day = [1, 1, 2, 2],
    revenue = [10000.0, 20000.0, 15000.0, 25000.0]
)

mini_sales_new = @chain mini_sales begin
    sort([:pharmacy, :day])
    groupby(:pharmacy)
    transform(:revenue => cumsum => :running_revenue)
end

println("Накопительный итог продаж по аптекам:")
println(mini_sales_new)
