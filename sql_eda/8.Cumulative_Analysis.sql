/*

Cumulative Analysis

Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

*/

-- Calculate the total sales per month
-- and the running total sales over time
SELECT
order_month,
total_sales,
SUM(total_sales) OVER (ORDER BY order_month) AS running_total,
ROUND(AVG(avg_price) OVER (ORDER BY order_month)) AS moving_average
FROM (
	SELECT 
	(DATE_TRUNC('MONTH', order_date))::DATE AS order_month,
	SUM(sales) AS total_sales,
	AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY order_month
) t;