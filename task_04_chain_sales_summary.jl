# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 2. Пайплайны @chain, канонические пары и агрегации
# Задача 4: Сводная выручка и количество чеков по аптечным сетям
# Стандарт: julia-analytics (groupby, combine, канонические пары)
# ==============================================================================

using DataFrames, Chain

chain_sales = DataFrame(
    pharmacy_chain = ["Ригла", "36.6", "Ригла", "Планета Здоровья", "36.6", "Ригла"],
    receipt_amount = [1250.0, 890.0, 3100.0, 1450.0, 2100.0, 950.0]
)

network_summary = @chain chain_sales begin
    groupby(:pharmacy_chain)
    combine(
        :receipt_amount => sum => :total_revenue,
        :receipt_amount => length => :receipts_count
    )
    sort(:total_revenue, rev = true)
end

println("Сводка по аптечным сетям:")
println(network_summary)
