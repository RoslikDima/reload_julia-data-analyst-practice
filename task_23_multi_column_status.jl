# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 8. Категоризация, биннинг и условная логика (Case When, Splitting)
# Задача 23 (Модуль 8, Задача 2): Мультиколоночная категоризация складских запасов
# Стандарт: julia-analytics (ByRow([:col1, :col2] -> cond), ternary logic)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

warehouse_stock = DataFrame(
    drug = ["Цефтриаксон", "Витамин C", "Инсулин", "Парацетамол", "Ибупрофен"],
    is_vital = [true, false, true, true, false],
    stock_qty = [0, 45, 0, 320, 80]
)

stock_audit = @chain warehouse_stock begin 
    transform(
        [:stock_qty, :is_vital] => ByRow((s, i) ->
            (s == 0 && i == true) ? "Критический дефицит" :
            (s < 100)             ? "Низкий запас" :
                                    "Норма"
        ) => :inventory_status
    )
    sort(:stock_qty)
end

println("Аудит складских остатков и статусов запаса:")
println(stock_audit)
