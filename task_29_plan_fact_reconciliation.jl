# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 10. Сквозные аналитические витрины (End-to-End Analytics Pipelines)
# Задача 29 (Модуль 10, Задача 2): Сверка Plan vs Fact с коалесценцией пропусков
# Стандарт: julia-analytics (outerjoin, coalesce missing -> 0.0, variance, execution_pct)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

plan_data = DataFrame(
    rep_id = ["REP-01", "REP-02", "REP-03", "REP-04"],
    plan_amount = [200000.0, 350000.0, 150000.0, 400000.0]
)

fact_data = DataFrame(
    rep_id = ["REP-01", "REP-02", "REP-03", "REP-05"],
    fact_amount = [240000.0, 315000.0, 180000.0, 95000.0]
)

result_29 = @chain plan_data begin
    outerjoin(fact_data, on = :rep_id)
    transform(
        :plan_amount => ByRow(p -> coalesce(p, 0.0)) => :plan_amount,
        :fact_amount => ByRow(f -> coalesce(f, 0.0)) => :fact_amount
    )
    transform([:fact_amount, :plan_amount] => ByRow((f, p) -> f - p) => :variance)
    transform(
        [:fact_amount, :plan_amount] => 
        ByRow((f, p) -> p > 0 ? round((f / p) * 100, digits = 1) : 100.0) => :execution_pct
    )
    sort(:execution_pct, rev = true)
end

println("Сверка выполнения плана продаж (Plan vs Fact):")
println(result_29)
