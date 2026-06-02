
/*

Stored Procedure: Load Bronze Layer (Source -> Bronze)

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It truncates the bronze tables before loading data.
    
Usage Example:
    CALL bronze.load_bronze

*/

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
