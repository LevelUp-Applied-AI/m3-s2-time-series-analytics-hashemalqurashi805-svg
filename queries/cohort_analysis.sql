WITH first_purchase AS (
    SELECT customer_id, MIN(DATE_TRUNC('month', order_date)) AS cohort_month
    FROM orders
    GROUP BY 1
),
order_activities AS (
    SELECT 
        fp.cohort_month,
        DATE_PART('day', o.order_date - fp.cohort_month) AS days_since_first
    FROM orders o
    JOIN first_purchase fp ON o.customer_id = fp.customer_id
)
SELECT 
    cohort_month,
    COUNT(*) FILTER (WHERE days_since_first <= 30) AS retention_30d,
    COUNT(*) FILTER (WHERE days_since_first <= 60) AS retention_60d,
    COUNT(*) FILTER (WHERE days_since_first <= 90) AS retention_90d
FROM order_activities
GROUP BY 1 ORDER BY 1;