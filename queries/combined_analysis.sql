SELECT 
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(SUM(oi.quantity * oi.unit_price)) OVER (ORDER BY DATE_TRUNC('month', o.order_date)) AS running_total_revenue,
    RANK() OVER (ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS revenue_rank
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY 1;