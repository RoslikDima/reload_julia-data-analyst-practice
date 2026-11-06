# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 7. Оконные функции и ранжирование (Ranking, Row Number, Dense Rank)
# Задача 20 (Модуль 7, Задача 2): Плотный ранг (dense_rank) со связками
# Стандарт: julia-analytics (векторный indexin + unique/sort)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

rep_performance = DataFrame(
    rep_name = ["Иванов", "Петров", "Сидорова", "Кузнецов", "Смирнова"],
    region = ["Центр", "Центр", "Центр", "Центр", "Центр"],
    visits_count = [120, 150, 120, 180, 150]
)

rep_leaderboard = @chain rep_performance begin 
    transform(
        :visits_count => (v -> indexin(v, sort(unique(v), rev = true))) => :rank_place
    )
    sort(:rank_place)
end

println("Рейтинг медицинских представителей (Dense Rank):")
println(rep_leaderboard)
