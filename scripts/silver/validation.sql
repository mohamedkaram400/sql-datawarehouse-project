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

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info


SELECT * FROM silver.crm_cust_info;