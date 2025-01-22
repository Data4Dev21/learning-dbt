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