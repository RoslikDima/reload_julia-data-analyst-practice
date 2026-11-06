# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 7. Оконные функции и ранжирование (Ranking, Row Number, Dense Rank)
# Задача 21 (Модуль 7, Задача 3): Кумулятивная доля выручки внутри групп (ABC-анализ)
# Стандарт: julia-analytics (sort -> groupby -> cumsum ./ sum внутри transform)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

regional_stores = DataFrame(
    region = ["Север", "Юг", "Север", "Юг", "Север", "Юг"],
    store = ["Аптека №1", "Аптека №4", "Аптека №2", "Аптека №5", "Аптека №3", "Аптека №6"],
    revenue = [200000.0, 450000.0, 500000.0, 150000.0, 300000.0, 400000.0]
)

abc_regional_summary = @chain regional_stores begin
    sort([:region, :revenue], rev = [false, true])
    groupby(:region)
    transform(
        :revenue => (r -> round.(cumsum(r) ./ sum(r) .* 100, digits = 2)) => :cum_share_pct
    )
end

println("Накопительная доля продаж внутри регионов (ABC):")
println(abc_regional_summary)
