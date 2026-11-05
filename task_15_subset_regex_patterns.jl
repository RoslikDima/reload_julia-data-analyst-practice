# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 5. Фильтрация, срезы и предикаты (subset, ByRow, regex)
# Задача 15 (Модуль 5, Задача 3): Фильтрация по регулярным выражениям (Regex)
# Стандарт: julia-analytics (ByRow(p -> contains(p, regex)), subset)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

drug_catalog = DataFrame(
    product = [
        "Парацетамол 500 мг",
        "Амоксиклав 1000 мг",
        "Ибупрофен 200 мг",
        "Цефтриаксон 1000 мг",
        "Аспирин 500 мг"
    ],
    price = [45.0, 780.0, 120.0, 540.0, 95.0]
)

affordable_high_dose = @chain drug_catalog begin 
    subset(
        :product => ByRow(p -> contains(p, r"500|1000")),
        :price => ByRow(pr -> pr < 600.0)
    )
    sort(:price)
end

println("Доступные препараты высоких дозировок (500/1000 мг):")
println(affordable_high_dose)
