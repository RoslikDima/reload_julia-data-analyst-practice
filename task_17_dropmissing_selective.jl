# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 6. Очистка данных, обработка Missing и коалесценция
# Задача 17 (Модуль 6, Задача 2): Выборочное удаление пропусков через dropmissing
# Стандарт: julia-analytics (dropmissing([:cols]), сужение типов Union{Missing, T})
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

prescriptions = DataFrame(
    rx_id = [5001, 5002, 5003, 5004, 5005],
    doctor_id = [12, missing, 45, 12, missing],
    drug = ["Цефтриаксон", "Амоксициллин", missing, "Азитромицин", "Омепразол"],
    packs = [2, 1, 3, missing, 2]
)

valid_prescriptions = @chain prescriptions begin 
    dropmissing([:doctor_id, :packs])
    sort(:rx_id)
end

println("Валидные рецепты после очистки ключевых пропусков:")
println(valid_prescriptions)
