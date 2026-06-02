/*

DDL Script: Create Bronze Tables

Script Purpose:
	This script creates tables in the 'bronze' schema, dropping existing tables
	if they already exist.
	Run this script to re-define the DDL structure of 'bronze' Tables
	
*/

CREATE SCHEMA IF NOT EXISTS bronze;

DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
	cst_id int,
	cst_key varchar(50),
	cst_firstname varchar(50),
	cst_lastname varchar(50),
	cst_marital_status varchar(50),
	cst_gender varchar(50),
	cst_create_date date
);



DROP TABLE IF EXISTS bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
	prd_id int,
	prd_key varchar(50),
	prd_name varchar(50),
	prd_cost int,
	prd_line varchar(50),
	prd_start_dt timestamp,
	prd_end_dt timestamp
);

DROP TABLE IF EXISTS bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
	sls_ord_num varchar(50),
	sls_prd_key varchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_due_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
);

DROP TABLE IF EXISTS bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
	cid varchar(50),
	cntry varchar(50)
);

DROP TABLE IF EXISTS bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
	cid varchar(50),
	bdate date,
	gen varchar(50)
);

DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
	id varchar(50),
	cat varchar(50),
	subcat varchar(50),
	maintenance varchar(50)
);

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql AS $$
BEGIN
	BEGIN
		TRUNCATE TABLE bronze.crm_cust_info;
		COPY bronze.crm_cust_info
		FROM 'C:dataset_crm\cust_info.csv'
		WITH (FORMAT CSV, HEADER);
		
		
		TRUNCATE TABLE bronze.crm_prd_info;
		COPY bronze.crm_prd_info
		FROM 'C:dataset_crm\prd_info.csv'
		WITH (FORMAT CSV, HEADER);
		
		TRUNCATE TABLE bronze.crm_sales_details;
		COPY bronze.crm_sales_details
		FROM 'C:dataset_crm\sales_details.csv'
		WITH (FORMAT CSV, HEADER);
		
		TRUNCATE TABLE bronze.erp_cust_az12;
		COPY bronze.erp_cust_az12
		FROM 'C:dataset_erp\CUST_AZ12.csv'
		WITH (FORMAT CSV, HEADER);
		
		TRUNCATE TABLE bronze.erp_loc_a101;
		COPY bronze.erp_loc_a101
		FROM 'C:dataset_erp\LOC_A101.csv'
		WITH (FORMAT CSV, HEADER);
		
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		COPY bronze.erp_px_cat_g1v2
		FROM 'C:dataset_erp\PX_CAT_G1V2.csv'
		WITH (FORMAT CSV, HEADER);

	EXCEPTION 
		WHEN OTHERS THEN
			RAISE NOTICE 'Something went wrong: %', SQLERRM;
			RAISE;
	END;
		

END; 
$$;


