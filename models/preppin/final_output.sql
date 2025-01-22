
SELECT 
    tr.online_or_in_person,
    tr.quarter AS quarter,
    tr.value,
    ut.quarterly_targets,
    (tr.value - ut.quarterly_targets) AS variance
FROM {{ ref('quarterly_dsb_transcations') }} tr
JOIN {{ ref('quarterly_targets') }} ut 
    ON tr.online_or_in_person = ut.online_or_in_person 
   AND CAST(ut.quarter AS INTEGER) = tr.quarter
