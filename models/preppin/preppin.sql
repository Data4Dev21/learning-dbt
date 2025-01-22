WITH cte AS (
    SELECT 
        CASE 
            WHEN tr."Online or In-Person" = 1 THEN 'Online'
            ELSE 'In-Person'
        END AS online_or_in_person,
        quarter(STRPTIME(tr."Transaction Date", '%d/%m/%Y %H:%M:%S')) AS quarter,
        SUM(tr.value) AS value
    FROM transactions tr
    WHERE "Transaction Code" LIKE '%DSB_%'
    GROUP BY 1, 2
),
unpivoted_targets AS (
    SELECT 
        "Online or In-Person",
        '1' AS quarter,
        q1 AS quarterly_targets
    FROM targets
    UNION ALL
    SELECT 
        "Online or In-Person",
        '2' AS quarter,
        q2 AS quarterly_targets
    FROM targets
    UNION ALL
    SELECT 
        "Online or In-Person",
        '3' AS quarter,
        q3 AS quarterly_targets
    FROM targets
    UNION ALL
    SELECT 
        "Online or In-Person",
        '4' AS quarter,
        q4 AS quarterly_targets
    FROM targets
)
SELECT 
    tr.online_or_in_person,
    tr.quarter AS quarter,
    tr.value,
    ut.quarterly_targets,
    (tr.value - ut.quarterly_targets) AS variance
FROM cte tr
JOIN unpivoted_targets ut 
    ON tr.online_or_in_person = ut."Online or In-Person" 
   AND CAST(ut.quarter AS INTEGER) = tr.quarter
