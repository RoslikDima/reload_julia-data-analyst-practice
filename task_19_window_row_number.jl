# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 7. Оконные функции и ранжирование (Ranking, Row Number, Dense Rank)
# Задача 19 (Модуль 7, Задача 1): Оконный номер строки и топ-N в группах
# Стандарт: julia-analytics (sort -> groupby -> eachindex -> subset)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

sales_catalog = DataFrame(
    category = [
        "Кардиология", "Антибиотики", "Кардиология", 
        "Антибиотики", "Кардиология", "Антибиотики"
    ],
    drug = [
        "Бисопролол", "Амоксициллин", "Амлодипин", 
        "Азитромицин", "Лозартан", "Цефтриаксон"
    ],
    revenue = [120000.0, 310000.0, 95000.0, 240000.0, 150000.0, 180000.0]
)

top_drugs_by_category = @chain sales_catalog begin
    sort([:category, :revenue], rev = [false, true])
    groupby(:category)
    transform(eachindex => :rank_in_cat)
    subset(:rank_in_cat => ByRow(r -> r <= 2))
end

println("Топ-2 препарата по выручке в каждой категории:")
println(top_drugs_by_category)
