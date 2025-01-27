SELECT 
        "Online or In-Person" as online_or_in_person,
        '1' AS quarter,
        q1 AS quarterly_targets
    FROM targets
    UNION ALL
    SELECT 
        "Online or In-Person" as online_or_in_person,
        '2' AS quarter,
        q2 AS quarterly_targets
    FROM targets
    UNION ALL
    SELECT 
        "Online or In-Person" as online_or_in_person,
        '3' AS quarter,
        q3 AS quarterly_targets
    FROM targets
    UNION ALL
    SELECT 
        "Online or In-Person" as online_or_in_person,
        '4' AS quarter,
        q4 AS quarterly_targets
    FROM  {{ source('main','targets') }}