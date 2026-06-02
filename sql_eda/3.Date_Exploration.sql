/*

Date Range Exploration.

Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.
	
*/

-- Find the date of the first and last order
-- How many years of sales are available
SELECT 
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date,
AGE(MAX(order_date), MIN(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and oldest customer
SELECT 
MIN(birthdate) AS oldest_custemer,
MAX(birthdate) AS youngest_customer,
AGE(CURRENT_DATE, MIN(birthdate)) AS age_oldest_customer, -- to find how old the oldest customer today
AGE(CURRENT_DATE, MAX(birthdate)) AS age_youngest_customer -- to find how old the youngest customer today
FROM gold.dim_customers;