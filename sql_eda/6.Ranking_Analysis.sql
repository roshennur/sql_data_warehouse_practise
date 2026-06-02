/*

Ranking Analysis

Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

*/

-- Which 5 product generate the highest revenue?
SELECT
p.product_name,
SUM(f.sales) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Which 5 product generate the lowest revenue?
SELECT
p.product_name,
SUM(f.sales) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
LIMIT 5;

-- Find top 5 highest revenue products with window function
SELECT *
FROM(
	SELECT
	p.product_name,
	SUM(f.sales) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales) DESC) AS rank_products 
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	    ON p.product_key = f.product_key
	GROUP BY p.product_name) t 
WHERE rank_products <= 5;
