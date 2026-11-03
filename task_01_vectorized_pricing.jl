# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 1. Векторный фундамент, broadcasting и семантика missing
# Задача 1: Векторный расчет отпускной стоимости с учетом НДС и скидок
# Стандарт: julia-analytics (векторизация, broadcast fusion, zero-allocation)
#
# Условие задачи:
# 1. Задан датафрейм df_raw с базовыми ценами (price) и скидками (discount).
# 2. Через @chain и векторную пару [:price, :discount] => ((p, d) -> ...):
#    - Заменить пропуски через векторный coalesce.(d, 0.0).
#    - Рассчитать final_price с учетом НДС (10%) в одну операцию без ByRow.
#    - Округлить до 2 знаков (round.(..., digits=2)).
# 3. Сохранить результат в pharma_pricing и вывести витрину.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

prices = [1200.0, 850.0, 2400.0, 450.0, 1600.0]
discounts = [0.05, missing, 0.10, missing, 0.07]
vat_rate = 0.10

df_raw = DataFrame(price = prices, discount = discounts)

pharma_pricing = @chain df_raw begin
    transform(
        [:price, :discount] => 
            ((p, d) -> round.(p .* (1.0 .- coalesce.(d, 0.0)) .* (1.0 + vat_rate), digits=2)) => 
            :final_price
    )
end

println("Векторный расчет отпускных цен (Стандарт julia-analytics):")
println(pharma_pricing)
