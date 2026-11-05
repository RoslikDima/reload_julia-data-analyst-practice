# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 5. Фильтрация, срезы и предикаты (subset, ByRow, regex)
# Задача 14 (Модуль 5, Задача 2): Выборка по списку значений (in) и булеву флагу
# Стандарт: julia-analytics (ByRow(c -> c in list), предикаты subset)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

pharmacy_stock = DataFrame(
    drug_name = ["Амоксициллин", "Аспирин", "Бисопролол", "Азитромицин", "Омепразол"],
    category = ["Антибиотики", "Анальгетики", "Кардиология", "Антибиотики", "Гастроэнтерология"],
    is_prescription = [true, false, true, true, false],
    stock_qty = [150, 420, 80, 210, 95]
)

focus_categories = ["Антибиотики", "Кардиология"]

target_prescription_stock = @chain pharmacy_stock begin
    subset(
        :category => ByRow(c -> c in focus_categories),
        :is_prescription => ByRow(i -> i == true)
    )
    sort(:drug_name)
end

println("Целевые рецептурные препараты в наличии:")
println(target_prescription_stock)
