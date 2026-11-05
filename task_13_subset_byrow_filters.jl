# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 5. Фильтрация, срезы и предикаты (subset, ByRow, regex)
# Задача 13 (Модуль 5, Задача 1): Фильтрация целевых заказов через subset и ByRow
# Стандарт: julia-analytics (построчные предикаты ByRow, сортировка)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

orders = DataFrame(
    order_id = [1001, 1002, 1003, 1004, 1005],
    status = ["Подтвержден", "Отменен", "Подтвержден", "Подтвержден", "В обработке"],
    order_sum = [4200.0, 5100.0, 1800.0, 7500.0, 3200.0]
)

express_orders = @chain orders begin
    subset(
        :status => ByRow(s -> s == "Подтвержден"),
        :order_sum => ByRow(s -> s > 3000)
    )
    sort(:order_sum, rev = true)
end

println("Отобранные экспресс-заказы:")
println(express_orders)
