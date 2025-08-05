SELECT
customer_segment
age_group,
COUNT(customer_number) AS total_customers,
SUM(total_sales) total_sales
FROM 
gold.report_customers
GROUP BY
customer_segment