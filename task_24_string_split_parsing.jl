# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 8. Категоризация, биннинг и условная логика (Case When, Splitting)
# Задача 24 (Модуль 8, Задача 3): Парсинг составных номенклатурных артикулов (split)
# Стандарт: julia-analytics (ByRow(split), парсинг типов parse(Int, ...))
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

batch_registry = DataFrame(
    batch_id = [701, 702, 703, 704],
    batch_code = [
        "CARDIO_2025_C12", 
        "ANTIBIOTIC_2026_A04", 
        "VITAMIN_2024_V99", 
        "CARDIO_2026_C15"
    ],
    units_count = [5000, 12000, 3400, 8500]
)

parsed_batches = @chain batch_registry begin
    transform(
        :batch_code => ByRow(code -> String(split(code, "_")[1])) => :drug_group,
        :batch_code => ByRow(code -> parse(Int, split(code, "_")[2])) => :production_year
    )
    sort(:production_year)
end

println("Распарсенный реестр производственных партий:")
println(parsed_batches)
