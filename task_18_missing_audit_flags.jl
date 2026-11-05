# ==============================================================================
# Репозиторий: reload_julia-data-analyst-practice
# Модуль 6. Очистка данных, обработка Missing и коалесценция
# Задача 18 (Модуль 6, Задача 3): Аудит пропусков через ismissing и булевы флаги
# Стандарт: julia-analytics (ByRow(ismissing), составные булевы флаги, мульти-сортировка)
# ==============================================================================

# Авторское решение (Dima Roslik):
using DataFrames, Chain

clients = DataFrame(
    client_id = [301, 302, 303, 304],
    phone = ["+79991112233", missing, "+79993334455", missing],
    email = [missing, "user2@mail.ru", "user3@gmail.com", missing]
)

loyalty_audit = @chain clients begin 
    transform(
        :phone => ByRow(ismissing) => :no_phone,
        :email => ByRow(ismissing) => :no_email
    )
    transform([:no_phone, :no_email] => ByRow((p, e) -> p || e) => :has_gap)
    sort([:has_gap, :client_id], rev = [true, false])
end

println("Аудит контактных данных клиентов:")
println(loyalty_audit)
