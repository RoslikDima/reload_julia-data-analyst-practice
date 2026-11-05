# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 3. Реляционные операции (Joins), stack и unstack
# Задача 9 (Модуль 3, Задача 3): Перевод отчета из широкого формата в длинный (stack)
# Стандарт: julia-analytics (stack с именованными аргументами в @chain)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

wide_reports = DataFrame(
    pharmacy = ["Аптека №1", "Аптека №2", "Аптека №3"],
    Q1 = [1200000.0, 950000.0, 1400000.0],
    Q2 = [1350000.0, 1100000.0, 1380000.0]
)

long_reports = @chain wide_reports begin 
    stack(
        [:Q1, :Q2], 
        variable_name = :quarter,
        value_name = :revenue 
    )
    sort([:pharmacy, :quarter])
end

println("Квартальные отчеты в длинном формате (stack):")
println(long_reports)
