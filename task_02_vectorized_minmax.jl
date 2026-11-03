# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 1. Векторный фундамент, broadcasting и семантика missing
# Задача 2: Векторная Min-Max нормализация признаков складов
# Стандарт: julia-analytics (extrema, loop fusion, broadcasting)
#
# Условие задачи:
# 1. Задан датафрейм warehouse_stats со складскими показателями.
# 2. Реализовать функцию min_max_scale на базе extrema и векторизации.
# 3. Через @chain рассчитать:
#    - turnover_norm (от 0.0 до 1.0, округление 3 знака).
#    - stock_norm (от 0.0 до 1.0, округление 3 знака).
# 4. Сохранить результат в scaled_warehouse_stats и вывести таблицу.
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

warehouse_stats = DataFrame(
    wh_id = ["WH-Central", "WH-North", "WH-South", "WH-East", "WH-West"],
    turnover_rub = [18500000.0, 9200000.0, 24100000.0, 14300000.0, 6800000.0],
    stock_units = [45000, 21000, 62000, 38000, 15000]
)

min_max_scale(v::AbstractVector) = let (mn, mx) = extrema(v)
    @. round((v - mn) / (mx - mn), digits = 3)
end

scaled_warehouse_stats = @chain warehouse_stats begin
    transform(
        :turnover_rub => min_max_scale => :turnover_norm,
        :stock_units => min_max_scale => :stock_norm
    )
end

println("Нормализованные показатели складов (julia-analytics):")
println(scaled_warehouse_stats)
