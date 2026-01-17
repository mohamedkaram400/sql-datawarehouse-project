-- ==================================== CRM CUST INFO ==================================== --

-- Check for nulls or duplicates in primary key
-- Expected: No Result
select cst_id,
COUNT(*) AS repcs
from bronze.crm_cust_info 
group by cst_id
having COUNT(*) > 1 or cst_id is null;

-- Check fo unwanted Spaces
-- Expectation: No Results
SELECT cst_firstname
FROM silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver.crm_cust_info   
where cst_lastname != TRIM(cst_lastname);

-- Data Standardization & Consistency
SELECT DISTINCT cst_material_status
FROM silver.crm_cust_info

-- Make sure there is only two gender (Male, Female)
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info


SELECT * FROM silver.crm_cust_info;


-- ==================================== CRM PRD INFO ==================================== --


-- Check for nulls or duplicates in primary key
-- Expected: No Result
SELECT prd_id,
COUNT(*) AS repcs
FROM silver.crm_prd_info 
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check fo unwanted Spaces
-- Expectation: No Results
SELECT prd_nm
FROM silver.crm_prd_info 
WHERE prd_nm != TRIM(prd_nm);

SELECT prd_cost
FROM silver.crm_prd_info 
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Make sure start date less than end date
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt


SELECT * FROM silver.crm_prd_info


-- ==================================== CRM SLS DETAILS ==================================== --


-- Check for Invalid Dates
SELECT
NULLIF(sls_order_dt, 0) AS sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101

-- Check for Invalid Dates Orders
SELECT 
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


    -- Check Data Consistency: Between Sales, Qty, and Price
    -- >> Sales = Qty * Price
    -- Values must not be NULL, zer, or negtive 
    SELECT DISTINCT
    sls_quantity,
    sls_sales,
    sls_price

    FROM silver.crm_sales_details
    WHERE sls_sales != sls_quantity * sls_price
    OR sls_sales IS NULL
    OR sls_quantity IS NULL
    OR sls_price IS NULL

    OR sls_sales <= 0
    OR sls_quantity <= 0
    OR sls_price <= 0

SELECT * FROM silver.crm_sales_details



-- ==================================== ERP CUST AZ12 ==================================== --


SELECT DISTINCT gndr 
FROM silver.erp_loc_a101

SELECT * FROM silver.erp_cust_az12

-- ==================================== ERP LOC A101 ==================================== --

SELECT cid
FROM bronze.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM bronze.crm_cust_info)

SELECT DISTINCT cntry 
FROM silver.erp_loc_a101

SELECT * FROM silver.erp_loc_a101

-- ==================================== ERP PX CAT G1V1 ==================================== --

SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance)

SELECT DISTINCT cat FROM silver.erp_px_cat_g1v2

SELECT DISTINCT subcat FROM silver.erp_px_cat_g1v2

SELECT DISTINCT maintenance FROM silver.erp_px_cat_g1v2
