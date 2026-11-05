# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 2. Пайплайны @chain, канонические пары и агрегации
# Задача 5: Средний чек и расчет рыночной доли выручки по регионам
# Стандарт: julia-analytics (combine -> transform, векторные проценты)
# ==============================================================================

using DataFrames, Chain, Statistics

pharma_orders = DataFrame(
    region = ["Центр", "Северо-Запад", "Центр", "Юг", "Северо-Запад", "Центр", "Юг"],
    order_amount = [450000.0, 280000.0, 520000.0, 190000.0, 310000.0, 610000.0, 230000.0]
)

region_summary = @chain pharma_orders begin
    groupby(:region)
    combine(
        :order_amount => sum => :total_revenue,
        :order_amount => (v -> round(mean(v), digits = 2)) => :avg_ticket
    )
    transform(:total_revenue => (r -> round.(r ./ sum(r) .* 100, digits = 1)) => :share_pct)
    sort(:total_revenue, rev = true)
end

println("Региональная витрина с долями продаж:")
println(region_summary)
