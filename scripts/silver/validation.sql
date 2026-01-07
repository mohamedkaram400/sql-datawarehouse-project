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
