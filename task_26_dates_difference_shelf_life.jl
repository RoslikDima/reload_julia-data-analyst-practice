# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 9. Работа с датами и периодами (Dates.jl, группировка, интервалы)
# Задача 26 (Модуль 9, Задача 2): Разность дат и аудит остаточного срока годности
# Стандарт: julia-analytics (Dates.value(d1 - d2), ByRow булевы флаги, sort)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain, Dates

audit_date = Date(2026, 11, 1)

shelf_stock = DataFrame(
    batch = ["B-101", "B-102", "B-103", "B-104"],
    drug_name = ["Амоксициллин", "Цефтриаксон", "Омепразол", "Парацетамол"],
    expiry_date = [
        Date(2026, 11, 20), 
        Date(2027, 5, 15), 
        Date(2027, 1, 10), 
        Date(2026, 12, 1)
    ]
)

expiry_risk_audit = @chain shelf_stock begin
    transform(
        :expiry_date => ByRow(d -> Dates.value(d - audit_date)) => :days_left
    )
    transform(
        :days_left => ByRow(days -> days <= 90) => :is_expiring_soon
    )
    sort(:days_left)
end

println("Аудит сроков годности препаратов на складе:")
println(expiry_risk_audit)
