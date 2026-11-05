# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 6. Очистка данных, обработка Missing и коалесценция
# Задача 16 (Модуль 6, Задача 1): Заполнение пропусков через coalesce и расчет чека
# Стандарт: julia-analytics (ByRow(coalesce), последовательный transform)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

raw_receipts = DataFrame(
    receipt_id = [101, 102, 103, 104],
    price = [1200.0, 450.0, 3100.0, 890.0],
    discount = [0.10, missing, 0.15, missing]
)

clean_receipts = @chain raw_receipts begin
    transform(:discount => ByRow(d -> coalesce(d, 0.0)) => :discount_clean)
    transform([:price, :discount_clean] => ByRow((p, d) -> round(p * (1 - d), digits = 2)) => :final_amount)
    sort(:final_amount)
end

println("Очищенные чеки с итоговой суммой со скидкой:")
println(clean_receipts)
