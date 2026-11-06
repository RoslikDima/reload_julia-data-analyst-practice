# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 9. Работа с датами и периодами (Dates.jl, группировка, интервалы)
# Задача 25 (Модуль 9, Задача 1): Агрегация продаж по календарным месяцам
# Стандарт: julia-analytics (Dates.format, groupby(:period), combine sum/length)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

daily_sales = DataFrame(
    order_id = [1, 2, 3, 4, 5],
    order_date = [
        Date(2026, 1, 10), 
        Date(2026, 1, 25), 
        Date(2026, 2, 5), 
        Date(2026, 2, 18), 
        Date(2026, 3, 2)
    ],
    amount = [15000.0, 22000.0, 18000.0, 31000.0, 42000.0]
)

monthly_aggregated_sales = @chain daily_sales begin
    transform(:order_date => ByRow(d -> Dates.format(d, "yyyy-mm")) => :period)
    groupby(:period)
    combine(
        :amount => sum => :total_revenue,
        :amount => length => :orders_count
    )
    sort(:period)
end

println("Ежемесячная агрегированная выручка:")
println(monthly_aggregated_sales)
