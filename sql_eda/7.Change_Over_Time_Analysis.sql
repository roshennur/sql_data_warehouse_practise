/*

Change Over Time Analysis

Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

*/

-- Analyse sales performance over time

-- EXTRACT()
SELECT 
EXTRACT(YEAR FROM order_date) AS order_year,
EXTRACT(MONTH FROM order_date) AS order_month,
SUM(sales) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


-- DATE_TRUNC()
SELECT 
(DATE_TRUNC('MONTH', order_date))::DATE AS order_date,
SUM(sales) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY (DATE_TRUNC('MONTH', order_date))::DATE
ORDER BY (DATE_TRUNC('MONTH', order_date))::DATE;


-- to_char()
SELECT 
to_char(order_date, 'YYYY-MM') AS order_year_month,
SUM(sales) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY to_char(order_date, 'YYYY-MM')
ORDER BY to_char(order_date, 'YYYY-MM');