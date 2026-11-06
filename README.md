# 🚀 Julia Data Analyst Practice (30-Day Intensive)

Практический репозиторий аналитика данных на языке **Julia**, сфокусированный на построении высокопроизводительных analytical pipelines, ETL/ELT трансформациях и подготовке витрин данных.

Все задачи реализованы по современному стандарту **`julia-analytics`**:
* Цепочки преобразований через макрос `@chain` (`Chain.jl`).
* Построчные функции через предикат `ByRow(...)`.
* Агрегации и аналитические витрины через `combine(groupby(...), ...)`.
* Работа с временными интервалами и периодами через `Dates.jl`.
* Корректная обработка пропусков `Missing` через `coalesce` и фильтрацию предикатами.

---

## 🛠 Технологический стек
* **Язык:** Julia (v1.10+)
* **Манипуляция данными:** `DataFrames.jl`, `Chain.jl`
* **Календарная арифметика:** `Dates.jl`
* **Математика и статистика:** `Statistics.jl`, `StatsBase.jl`
* **Стандарты:** Clean Code, Vectorization, Strong Typing

---

## 📋 Карта выполненных модулей и задач (30 / 30)

| № | Модуль | Тема задачи | Файл решения |
|---|---|---|---|
| **01** | Модуль 1 | Векторная нормализация (Z-Score) | `task_01_zscore_normalization.jl` |
| **02** | Модуль 1 | Векторный прирост продаж (Growth Rate) | `task_02_vector_growth_rate.jl` |
| **03** | Модуль 1 | Фильтрация по порогу стандартного отклонения | `task_03_std_threshold_filtering.jl` |
| **04** | Модуль 2 | Пайплайн расчета выручки (`transform` + `ByRow`) | `task_04_revenue_pipeline.jl` |
| **05** | Модуль 2 | Агрегация по категориям (`groupby` + `combine`) | `task_05_category_aggregation.jl` |
| **06** | Модуль 2 | Кумулятивная сумма и расчет долей (`cumsum`) | `task_06_cumulative_shares.jl` |
| **07** | Модуль 3 | Обогащение справочником через `leftjoin` | `task_07_leftjoin_enrichment.jl` |
| **08** | Модуль 3 | Транспонирование из широкого формата в длинный (`stack`) | `task_08_wide_to_long_stack.jl` |
| **09** | Модуль 3 | Сводная таблица из длинного формата в широкий (`unstack`) | `task_09_long_to_wide_unstack.jl` |
| **10** | Модуль 4 | Расчет предыдущего периода через `lag` | `task_10_timeseries_lag.jl` |
| **11** | Модуль 4 | Скользящее среднее в окне (Rolling Mean) | `task_11_rolling_window_mean.jl` |
| **12** | Модуль 4 | Месячный темп роста MoM (%) через сгруппированный `lag` | `task_12_mom_growth_rate.jl` |
| **13** | Модуль 5 | Предикатная фильтрация чеков через `subset` | `task_13_subset_predicate_filter.jl` |
| **14** | Модуль 5 | Множественная фильтрация через оператор `in` | `task_14_isin_category_filtering.jl` |
| **15** | Модуль 5 | Топ-N записей внутри групп (`first(..., n)`) | `task_15_top_n_per_group.jl` |
| **16** | Модуль 6 | Обнаружение пропусков через `ismissing` | `task_16_detect_missing_values.jl` |
| **17** | Модуль 6 | Заполнение пропущенных цен через `coalesce` | `task_17_coalesce_defaults.jl` |
| **18** | Модуль 6 | Удаление неполных строк через `dropmissing` | `task_18_dropmissing_sanitization.jl` |
| **19** | Модуль 7 | Ранжирование строк (Row Number) внутри категорий | `task_19_row_number_ranking.jl` |
| **20** | Модуль 7 | Плотный ранг продаж (Dense Rank) | `task_20_dense_ranking.jl` |
| **21** | Модуль 7 | Накопительная доля выручки внутри групп (ABC-анализ) | `task_21_regional_cum_share.jl` |
| **22** | Модуль 8 | Сегментация чеков через вложенный тернарный оператор | `task_22_ternary_categorization.jl` |
| **23** | Модуль 8 | Мультиколоночная категоризация остатков склада | `task_23_multi_column_status.jl` |
| **24** | Модуль 8 | Парсинг составных номенклатурных кодов (`split`) | `task_24_string_split_parsing.jl` |
| **25** | Модуль 9 | Помесячная агрегация дат через `Dates.format` | `task_25_monthly_sales_aggregation.jl` |
| **26** | Модуль 9 | Контроль сроков годности (разность дат `Dates.value`) | `task_26_dates_difference_shelf_life.jl` |
| **27** | Модуль 9 | Квартальная аналитическая витрина (`quarterofyear`) | `task_27_quarterly_aggregation.jl` |
| **28** | Модуль 10 | Категорийный отчет по маржинальности (`leftjoin` + маржа) | `task_28_end_to_end_margin_analysis.jl` |
| **29** | Модуль 10 | Сверка выполнения плана продаж (Plan vs Fact, `outerjoin`) | `task_29_plan_fact_reconciliation.jl` |
| **30** | Модуль 10 | Аналитическая витрина клиентских когорт и LTV | `task_30_client_cohorts_ltv.jl` |

---
**Автор:** Dmitry Roslik  
**GitHub:** [@RoslikDima](https://github.com/RoslikDima)
