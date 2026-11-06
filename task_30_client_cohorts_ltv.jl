# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 10. Сквозные аналитические витрины (End-to-End Analytics Pipelines)
# Задача 30 (Модуль 10, Задача 3): Аналитическая витрина клиентских когорт и LTV
# Стандарт: julia-analytics (groupby -> combine min/sum/length -> ByRow LTV binning -> sort)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

raw_orders = DataFrame(
    order_id = [1, 2, 3, 4, 5, 6, 7],
    client_id = [101, 102, 101, 103, 102, 101, 104],
    order_date = [
        Date(2026, 1, 15),
        Date(2026, 1, 20),
        Date(2026, 2, 10),
        Date(2026, 2, 15),
        Date(2026, 3, 5),
        Date(2026, 3, 20),
        Date(2026, 3, 22)
    ],
    order_amount = [3500.0, 4200.0, 5100.0, 1500.0, 1200.0, 2400.0, 850.0]
)

client_cohort_summary = @chain raw_orders begin 
    groupby(:client_id)
    combine(
        :order_date => minimum => :first_order_date,
        :order_amount => sum => :lifetime_value,
        :order_id => length => :total_orders
    )
    transform(
        :lifetime_value => ByRow(o -> o >= 10000.0 ? "VIP" :
                                      o >= 4000.0  ? "Лояльный" :
                                                     "Базовый") => :segment
    )
    sort(:lifetime_value, rev = true)
end

println("Аналитическая витрина когорт и LTV клиентов:")
println(client_cohort_summary)
