{{ config(
    materialized='table',
    schema='silver'
) }}

WITH source_data AS (
    SELECT * FROM {{ ref('raw_sales') }}
),

cleaned_data AS (
    SELECT
        CAST(sale_id AS INT) AS sale_id,
        CAST(amount AS DECIMAL(10, 2)) AS sale_amount,
        CAST(sale_date AS DATE) AS sale_date,
        current_timestamp() AS processed_at
    FROM source_data
    WHERE sale_id IS NOT NULL
)

-- Final deduplication based on sale_id
SELECT * FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY sale_id ORDER BY processed_at DESC) as rn
    FROM cleaned_data
)
WHERE rn = 1