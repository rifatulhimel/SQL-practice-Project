CREATE VIEW gold.reports_product AS
WITH base_query AS (
SELECT
f.order_number,
f.customer_key,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
p.category,
p.product_name,
p.subcategory,
p.cost
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL),

product_aggregation AS (
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
	MAX(order_date) AS last_sales_date,
	COUNT(DISTINCT order_number) AS total_orders,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	ROUND(AVG(CAST(sales_amount AS FLOAT)/NULLIF(quantity,0)),1) AS avg_selling_price
FROM base_query
GROUP BY
	product_key,
	product_name,
	category,
	subcategory,
	cost
)

SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_sales_date,
	DATEDIFF(month, last_sales_date, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sales>50000 THEN 'High-Performer'
		WHEN total_sales>=10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segement,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	CASE
		WHEN total_orders=0 THEN 0
		ELSE total_sales/total_orders
	END AS avg_total_revenue,

	CASE
		WHEN lifespan=0 THEN total_sales
		ELSE total_sales/lifespan
	END AS avg_monthly_revenue

FROM product_aggregation
