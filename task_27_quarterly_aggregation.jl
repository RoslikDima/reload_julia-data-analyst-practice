# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 9. Работа с датами и периодами (Dates.jl, группировка, интервалы)
# Задача 27 (Модуль 9, Задача 3): Квартальная группировка и расчет средних отгрузок
# Стандарт: julia-analytics (Dates.quarterofyear, combine sum + lambda round(mean))
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates, Statistics

shipments = DataFrame(
    shipment_id = [201, 202, 203, 204, 205, 206],
    sale_date = [
        Date(2026, 1, 15),
        Date(2026, 2, 20),
        Date(2026, 4, 10),
        Date(2026, 6, 25),
        Date(2026, 7, 5),
        Date(2026, 9, 30)
    ],
    shipped_packs = [1400, 2200, 3100, 1900, 4500, 2800]
)

quarterly_shipments_summary = @chain shipments begin 
    transform(:sale_date => ByRow(q -> "$(Dates.year(q)) - Q$(Dates.quarterofyear(q))") => :quarter)
    groupby(:quarter)
    combine(
        :shipped_packs => sum => :total_shipped,
        :shipped_packs => (x -> round(mean(x), digits = 1)) => :avg_shipment
    )
    sort(:quarter)
end

println("Квартальные итоги отгрузок дистрибьюторам:")
println(quarterly_shipments_summary)
