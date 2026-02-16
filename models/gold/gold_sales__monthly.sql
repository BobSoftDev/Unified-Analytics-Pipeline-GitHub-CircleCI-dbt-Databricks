{{ config(
    materialized='view',
    schema='gold',
    alias='gold_sales__monthly'
) }}

SELECT 
    date_trunc('month', sale_date) as report_month,
    sum(sale_amount) as total_monthly_revenue,
    count(distinct sale_id) as transaction_count
FROM {{ ref('sales__cleaned') }}
GROUP BY 1
ORDER BY 1 DESC