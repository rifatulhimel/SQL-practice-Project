SELECT SUM(sales_amount) AS total_sales 
FROM gold.fact_sales

SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales

SELECT AVG(price) AS avg_price FROM gold.fact_sales

SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales

SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales

SELECT COUNT(product_key) AS total_products FROM gold.dim_products

SELECT COUNT(DISTINCT product_key) AS total_products FROM gold.dim_products

SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers

SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales



SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Products', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_key) FROM gold.dim_customers