WITH legacy_dupes AS (
    {{ audit_helper.get_dupes(
        relation=ref('preppin'),
        columns=['id']
    ) }}
),
fact_dupes AS (
    {{ audit_helper.get_dupes(
        relation=ref('fct_transaction_targets'),
        columns=['id']
    ) }}
)
SELECT
    'legacy' AS table_name,
    COUNT(*) AS duplicate_count
FROM legacy_dupes
UNION ALL
SELECT
    'fact' AS table_name,
    COUNT(*) AS duplicate_count
FROM fact_dupes
