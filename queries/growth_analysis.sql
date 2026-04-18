SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue,
    LAG(SUM(oi.quantity * oi.unit_price)) OVER (ORDER BY DATE_TRUNC('month', o.order_date)) AS prev_month_revenue,
    (SUM(oi.quantity * oi.unit_price) - LAG(SUM(oi.quantity * oi.unit_price)) OVER (ORDER BY DATE_TRUNC('month', o.order_date))) / 
    LAG(SUM(oi.quantity * oi.unit_price)) OVER (ORDER BY DATE_TRUNC('month', o.order_date)) * 100 AS growth_percentage
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;