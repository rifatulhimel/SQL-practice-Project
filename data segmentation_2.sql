WITH customer_spending AS
(
SELECT
c.customer_key,
SUM(f.sales_amount) AS total_spending,
MIN(f.order_date) AS first_date,
MAX(f.order_date) AS final_date,
DATEDIFF (month, MIN(f.order_date), MAX(f.order_date)) AS lifespan
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key=c.customer_key
GROUP BY c.customer_key
)

SELECT
customer_segment,
COUNT(customer_key) AS total_customers
FROM (
SELECT
customer_key,
CASE WHEN lifespan >=12 AND total_spending > 5000 THEN 'VIP'
	 WHEN lifespan >=12 AND total_spending<=5000 THEN 'Regular'
	 ELSE 'New'
END customer_segment
FROM customer_spending ) t
GROUP BY customer_segment
ORDER BY total_customers DESC