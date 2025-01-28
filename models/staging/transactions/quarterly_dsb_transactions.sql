 WITH source as (
    SELECT *
    FROM {{ source('main','transactions') }}
 ),

 transformed as (
    SELECT 
        CASE 
            WHEN "Online or In-Person" = 1 THEN 'Online'
            ELSE 'In-Person'
        END AS online_or_in_person,
        quarter(STRPTIME("Transaction Date", '%d/%m/%Y %H:%M:%S')) AS quarter,
        SUM(value) AS value
    FROM source
    WHERE "Transaction Code" LIKE '%DSB_%'
    GROUP BY 1, 2
 )

 SELECT *
 FROM transformed