-- Anomaly Check
SELECT *
FROM ecommerce_transactions
ORDER BY decoy_noise
LIMIT 100
;

-- Step 1: Hitung RFM Score
WITH rfm_raw AS (
  SELECT
    customer_id,
    CURRENT_DATE - MAX(order_date) AS recency,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary
  FROM ecommerce_transactions
  GROUP BY customer_id
),

-- Step 2: Buat Kuartil berdasarkan Score
rfm_scored AS (
  SELECT *,
    NTILE(2) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(2) OVER (ORDER BY frequency) AS f_score,
    NTILE(2) OVER (ORDER BY monetary) AS m_score
  FROM rfm_raw
),

-- Step 3: Segmentasi
rfm_segmented AS (
  SELECT *,
    CONCAT(r_score, f_score, m_score) AS rfm_score,
    CASE
      WHEN r_score = 2 AND f_score = 2 AND m_score = 2 THEN 'Very Loyal Customers'
      WHEN r_score = 2 AND f_score = 2 AND m_score = 1 THEN 'Loyal Customers'
      WHEN r_score = 2 AND f_score = 1 AND m_score = 2 THEN 'Potential Customers'
      WHEN r_score = 2 AND f_score = 1 AND m_score = 1 THEN 'Reguler Customers'
      WHEN r_score = 1 AND f_score = 2 AND m_score = 2 THEN 'At Risk Customers'
      WHEN r_score = 1 AND f_score = 2 AND m_score = 1 THEN 'Low Engagement Customers'
	  WHEN r_score = 1 AND f_score = 1 AND m_score = 2 THEN 'Potential Churn'
	  ELSE 'Churn'
    END AS segment
  FROM rfm_scored
)
SELECT * FROM rfm_segmented
;

-- Step 4: Repeat Purchase Bulanan
WITH monthly_orders AS (
  SELECT
    customer_id,
    DATE_TRUNC('month', order_date) AS order_month,
    COUNT(order_id) AS orders_in_month
  FROM ecommerce_transactions
  GROUP BY customer_id, order_month
)
SELECT
  customer_id,
  order_month,
  orders_in_month
FROM monthly_orders
WHERE orders_in_month > 1
ORDER BY order_month, customer_id
;
