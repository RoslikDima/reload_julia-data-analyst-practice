# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 3. Реляционные операции (Joins), stack и unstack
# Задача 7 (Модуль 3, Задача 1): Обогащение фактов чеков через leftjoin
# Стандарт: julia-analytics (реляционные связки в @chain)
# ==============================================================================

using DataFrames, Chain

sales_facts = DataFrame(
    order_id = [101, 102, 103, 104],
    sku_id = [1, 2, 1, 3],
    quantity = [2, 1, 5, 1]
)

products_dim = DataFrame(
    sku_id = [1, 2, 3],
    product_name = ["Аспирин", "Парацетамол", "Ибупрофен"],
    category = ["Анальгетики", "Жаропонижающие", "НПВП"]
)

enriched_sales = @chain sales_facts begin 
    leftjoin(products_dim, on = :sku_id)
end

println("Обогащенные данные по заказам (leftjoin):")
println(enriched_sales)
