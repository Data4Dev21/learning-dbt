--import ctes
--dependencies

WITH transactions as (
    SELECT *
    FROM {{ ref('quarterly_dsb_transactions') }}
),

targets as (
    SELECT *
    FROM {{ ref('quarterly_targets') }}
),
--final cte
--marts
final as (
    SELECT 
    tr.online_or_in_person,
    tr.quarter,
    tr.value,
    ut.quarterly_targets,
    (tr.value - ut.quarterly_targets) AS variance
FROM transactions tr
JOIN targets ut 
    ON tr.online_or_in_person = ut.online_or_in_person 
   AND CAST(ut.quarter AS INTEGER) = tr.quarter
)

--Simple select statement
    SELECT * 
    FROM final
