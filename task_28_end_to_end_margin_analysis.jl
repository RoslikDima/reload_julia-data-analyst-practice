# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 10. Сквозные аналитические витрины (End-to-End Analytics Pipelines)
# Задача 28 (Модуль 10, Задача 1): Категорийный отчет по маржинальности
# Стандарт: julia-analytics (leftjoin, ByRow расчет маржи, combine, sort)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

fact_sales = DataFrame(
    order_id = [1001, 1002, 1003, 1004, 1005],
    sku = ["SKU-01", "SKU-02", "SKU-01", "SKU-03", "SKU-02"],
    quantity = [100, 50, 150, 200, 80],
    revenue = [60000.0, 45000.0, 90000.0, 140000.0, 72000.0]
)

dim_products = DataFrame(
    sku = ["SKU-01", "SKU-02", "SKU-03"],
    product_name = ["Амоксиклав", "Бисопролол", "Цефтриаксон"],
    category = ["Антибиотики", "Кардиология", "Антибиотики"],
    unit_cost = [350.0, 500.0, 420.0]
)

category_margin_summary = @chain fact_sales begin
    leftjoin(dim_products, on = :sku)
    transform([:quantity, :unit_cost] => ByRow((q, u) -> q * u) => :total_cost)
    transform([:revenue, :total_cost] => ByRow((r, t) -> r - t) => :margin_rub)
    groupby(:category)
    combine(
        :revenue => sum => :total_revenue,
        :margin_rub => sum => :total_margin
    )
    transform(
        [:total_revenue, :total_margin] => ByRow((r, m) -> round((m / r) * 100, digits = 1)) => :margin_pct
    )
    sort(:margin_pct, rev = true)
end

println("Категорийный отчет по маржинальности продаж:")
println(category_margin_summary)
