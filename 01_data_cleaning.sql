-- ======================================================
-- DATA PREPARATION
-- Marketing Customer Analytics Project
-- ======================================================

-- This script prepares the dataset for analysis.
-- It creates cleaned views and performs basic data checks.

/* ============================================================
   STEP 1 — CLEAN VIEW
   ============================================================ */
drop view v_marketing_clean;


CREATE OR REPLACE VIEW v_marketing_clean AS
SELECT
    "ID" AS id,

    -- Fix unrealistic birth years
    CASE
        WHEN "Year_Birth" BETWEEN 1920 AND EXTRACT(YEAR FROM CURRENT_DATE)
        THEN "Year_Birth"
        ELSE NULL
    END AS year_birth,

    -- Calculate customer age
    CASE
        WHEN "Year_Birth" BETWEEN 1920 AND EXTRACT(YEAR FROM CURRENT_DATE)
        THEN EXTRACT(YEAR FROM CURRENT_DATE) - "Year_Birth"
        ELSE NULL
    END AS age,

    "Education" AS education,
    "Marital_Status" AS marital_status,
    "Income" AS income,
    "Kidhome" AS kidhome,
    "Teenhome" AS teenhome,

    -- Total number of children in household
    "Kidhome" + "Teenhome" AS children,

    "Recency" AS recency,

    "MntWines" AS mnt_wines,
    "MntFruits" AS mnt_fruits,
    "MntMeatProducts" AS mnt_meat_products,
    "MntFishProducts" AS mnt_fish_products,
    "MntSweetProducts" AS mnt_sweet_products,
    "MntGoldProds" AS mnt_gold_prods,

    -- Total customer spending across all product categories
    "MntWines"
    + "MntFruits"
    + "MntMeatProducts"
    + "MntFishProducts"
    + "MntSweetProducts"
    + "MntGoldProds" AS mnt_total,

    "NumDealsPurchases" AS num_deals_purchases,
    "NumWebPurchases" AS num_web_purchases,
    "NumCatalogPurchases" AS num_catalog_purchases,
    "NumStorePurchases" AS num_store_purchases,
    "NumWebVisitsMonth" AS num_web_visits_month,

    "AcceptedCmp1" AS accepted_cmp1,
    "AcceptedCmp2" AS accepted_cmp2,
    "AcceptedCmp3" AS accepted_cmp3,
    "AcceptedCmp4" AS accepted_cmp4,
    "AcceptedCmp5" AS accepted_cmp5,

    "Response" AS response,
    "Complain" AS complain,

    TO_DATE("Dt_Customer", 'DD-MM-YYYY') AS dt_customer
FROM marketing_campaign;


/* ============================================================
   STEP 2 — DATA QUALITY CHECK
   ============================================================ */

-- income contains NULL values
-- NULL means missing income information (not zero income)
-- unrealistic Year_Birth values are converted to NULL in the clean view


/************* Check NULL values *************/

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(id) AS id_nulls,
    COUNT(*) - COUNT(year_birth) AS year_birth_nulls,
    COUNT(*) - COUNT(education) AS education_nulls,
    COUNT(*) - COUNT(marital_status) AS marital_status_nulls,
    COUNT(*) - COUNT(income) AS income_nulls,
    COUNT(*) - COUNT(kidhome) AS kidhome_nulls,
    COUNT(*) - COUNT(teenhome) AS teenhome_nulls,
    COUNT(*) - COUNT(children) AS children_nulls,
    COUNT(*) - COUNT(recency) AS recency_nulls,
    COUNT(*) - COUNT(mnt_wines) AS mnt_wines_nulls,
    COUNT(*) - COUNT(mnt_fruits) AS mnt_fruits_nulls,
    COUNT(*) - COUNT(mnt_meat_products) AS mnt_meat_products_nulls,
    COUNT(*) - COUNT(mnt_fish_products) AS mnt_fish_products_nulls,
    COUNT(*) - COUNT(mnt_sweet_products) AS mnt_sweet_products_nulls,
    COUNT(*) - COUNT(mnt_gold_prods) AS mnt_gold_prods_nulls,
    COUNT(*) - COUNT(mnt_total) AS mnt_total_nulls,
    COUNT(*) - COUNT(num_deals_purchases) AS num_deals_purchases_nulls,
    COUNT(*) - COUNT(num_web_purchases) AS num_web_purchases_nulls,
    COUNT(*) - COUNT(num_catalog_purchases) AS num_catalog_purchases_nulls,
    COUNT(*) - COUNT(num_store_purchases) AS num_store_purchases_nulls,
    COUNT(*) - COUNT(num_web_visits_month) AS num_web_visits_month_nulls,
    COUNT(*) - COUNT(accepted_cmp1) AS accepted_cmp1_nulls,
    COUNT(*) - COUNT(accepted_cmp2) AS accepted_cmp2_nulls,
    COUNT(*) - COUNT(accepted_cmp3) AS accepted_cmp3_nulls,
    COUNT(*) - COUNT(accepted_cmp4) AS accepted_cmp4_nulls,
    COUNT(*) - COUNT(accepted_cmp5) AS accepted_cmp5_nulls,
    COUNT(*) - COUNT(response) AS response_nulls,
    COUNT(*) - COUNT(complain) AS complain_nulls
FROM v_marketing_clean;


/************* Check duplicates *************/

SELECT
    id,
    COUNT(*) AS duplicate_count
FROM v_marketing_clean
GROUP BY id
HAVING COUNT(*) > 1;


/************* Check birth year range *************/

SELECT
    MIN(year_birth) AS min_year_birth,
    MAX(year_birth) AS max_year_birth
FROM v_marketing_clean;


/************* Check cleaned invalid birth years *************/

SELECT
    id,
    year_birth,
    age
FROM v_marketing_clean
WHERE year_birth IS NULL;

