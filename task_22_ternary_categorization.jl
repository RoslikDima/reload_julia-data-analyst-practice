# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 8. Категоризация, биннинг и условная логика (Case When, Splitting)
# Задача 22 (Модуль 8, Задача 1): Сегментация чеков через вложенный тернарный оператор
# Стандарт: julia-analytics (ByRow(nested ternary ?:), sort)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

orders_stream = DataFrame(
    order_id = [901, 902, 903, 904, 905],
    basket_sum = [4500.0, 750.0, 1850.0, 3100.0, 990.0]
)

segmented_orders = @chain orders_stream begin 
    transform(
        :basket_sum => ByRow(b -> b >= 3000.0 ? "Крупный чек" :
                                  b >= 1000.0 ? "Средний чек" :
                                                "Малый чек") => :segment
    )
    sort(:basket_sum, rev = true)
end

println("Сегментация заказов по глубине чека:")
println(segmented_orders)
