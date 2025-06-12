SELECT 
	customer_id,
    CURRENT_DATE - MAX(order_date) AS recency,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary
FROM public.ecommerce_transactions 
GROUP BY customer_id
ORDER BY customer_id ASC
;