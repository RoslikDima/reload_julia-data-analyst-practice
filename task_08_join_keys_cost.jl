# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 3. Реляционные операции (Joins), stack и unstack
# Задача 8 (Модуль 3, Задача 2): Соединение по разным именам ключей и расчет суммы
# Стандарт: julia-analytics (on = :colA => :colB, векторное умножение q .* p)
# ==============================================================================

using DataFrames, Chain

warehouse_moves = DataFrame(
    move_id = ["M-1", "M-2", "M-3", "M-4"],
    item_id = [501, 502, 501, 503],
    quantity = [10, 4, 15, 2]
)

price_guide = DataFrame(
    sku_id = [501, 502, 503],
    item_name = ["Амоксициллин", "Омепразол", "Цефтриаксон"],
    unit_price = [320.0, 180.0, 650.0]
)

calculated_moves = @chain warehouse_moves begin
    leftjoin(price_guide, on = :item_id => :sku_id)
    transform([:quantity, :unit_price] => ((q, p) -> q .* p) => :move_cost)
    sort(:move_cost, rev = true)
end

println("Движение склада с рассчитанной стоимостью:")
println(calculated_moves)
