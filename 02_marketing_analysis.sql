-- ======================================================
-- MARKETING ANALYSIS
-- Marketing Customer Analytics Project
-- ======================================================

-- This script calculates key business metrics and insights
-- from the cleaned marketing dataset.


/* ============================================================
   CUSTOMER OVERVIEW KPIs
   KPI 1 — Total Customers
   KPI 2 — Total Revenue
   KPI 3 — Average Revenue per Customer
   ============================================================ */

WITH a AS (
    SELECT
        COUNT(*) AS total_customers,
        SUM(mnt_total) AS total_revenue
    FROM v_marketing_clean
)
SELECT
    total_customers,
    total_revenue,
    ROUND(1.0 * total_revenue / total_customers, 2) AS avg_revenue_per_customer
FROM a;


/* ============================================================
   CUSTOMER BEHAVIOUR ANALYSIS
   ============================================================ */

-- KPI 4 — Purchase Distribution by Sales Channel
-- Compare how customers purchase: web, catalog, or store

WITH a AS (
    SELECT
        'web' AS channel,
        SUM(num_web_purchases) AS total_purchases,
        ROUND(
            (1.0 * SUM(num_web_purchases) /
            SUM(num_web_purchases + num_catalog_purchases + num_store_purchases)) * 100,
            2
        ) AS share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'catalog' AS channel,
        SUM(num_catalog_purchases) AS total_purchases,
        ROUND(
            (1.0 * SUM(num_catalog_purchases) /
            SUM(num_web_purchases + num_catalog_purchases + num_store_purchases)) * 100,
            2
        ) AS share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'store' AS channel,
        SUM(num_store_purchases) AS total_purchases,
        ROUND(
            (1.0 * SUM(num_store_purchases) /
            SUM(num_web_purchases + num_catalog_purchases + num_store_purchases)) * 100,
            2
        ) AS share_percent
    FROM v_marketing_clean
)

SELECT
    *
FROM a
ORDER BY total_purchases DESC;


-- KPI 5 — Average Recency
-- Recency = days since last purchase
-- Lower value = more active customer

SELECT
    ROUND(AVG(recency)) AS avg_recency_days
FROM v_marketing_clean;


/* ============================================================
   MARKETING CAMPAIGN PERFORMANCE
   ============================================================ */

-- KPI 6 — Campaign Acceptance Rate

WITH a AS (
    SELECT
        'cmp1' AS cmp,
        ROUND((1.0 * SUM(accepted_cmp1) / COUNT(id)) * 100, 2) AS acceptance_rate_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'cmp2' AS cmp,
        ROUND((1.0 * SUM(accepted_cmp2) / COUNT(id)) * 100, 2) AS acceptance_rate_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'cmp3' AS cmp,
        ROUND((1.0 * SUM(accepted_cmp3) / COUNT(id)) * 100, 2) AS acceptance_rate_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'cmp4' AS cmp,
        ROUND((1.0 * SUM(accepted_cmp4) / COUNT(id)) * 100, 2) AS acceptance_rate_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'cmp5' AS cmp,
        ROUND((1.0 * SUM(accepted_cmp5) / COUNT(id)) * 100, 2) AS acceptance_rate_percent
    FROM v_marketing_clean
)
SELECT
    cmp,
    acceptance_rate_percent
FROM a
ORDER BY acceptance_rate_percent DESC;


-- KPI 7 — Best Performing Campaign
-- Insight from previous table:
-- campaign with the highest acceptance_rate_percent


-- KPI 8 — Last Campaign Response Rate

SELECT
    ROUND((1.0 * SUM(response) / COUNT(id)) * 100, 2) AS last_campaign_response_rate_percent
FROM v_marketing_clean;


/* ============================================================
   CUSTOMER SEGMENTATION
   ============================================================ */

-- KPI 9 — Revenue by Education

SELECT
    education,
    SUM(mnt_total) AS total_revenue
FROM v_marketing_clean
GROUP BY education
ORDER BY total_revenue DESC;


-- KPI 10 — Revenue by Marital Status

SELECT
    marital_status,
    SUM(mnt_total) AS total_revenue
FROM v_marketing_clean
GROUP BY marital_status
ORDER BY total_revenue DESC;


-- KPI 10b — Revenue by Number of Children

SELECT
    children,
    COUNT(*) AS number_of_customers,
    SUM(mnt_total) AS total_revenue_per_segment,
    ROUND(AVG(mnt_total), 2) AS avg_revenue,
    ROUND((1.0 * SUM(mnt_total) / (SELECT SUM(mnt_total) FROM v_marketing_clean)), 2) AS total_revenue_share_percent
FROM v_marketing_clean
GROUP BY children
ORDER BY total_revenue_per_segment DESC;


--- 10c kids no kids
select 
case 
	when children >0 then 'family_with_children' else 'no_children' end as family_status,
	COUNT(*) AS number_of_customers,
	sum(mnt_total) as total_revenue,
	ROUND(AVG(mnt_total), 2) AS avg_revenue,
    ROUND((1.0 * SUM(mnt_total) / (SELECT SUM(mnt_total) FROM v_marketing_clean)), 2) AS total_revenue_share_percent
	
from 
v_marketing_clean
group by family_status;

-- =========================================================
-- CUSTOMER SPENDING ANALYSIS
-- =========================================================

-- KPI 11 — Spending by Product Category
-- Compare revenue generated by each product category

WITH a AS (
    SELECT
        'wines' AS category,
        SUM(mnt_wines) AS total_revenue,
        ROUND(
            (1.0 * SUM(mnt_wines) / SUM(mnt_total)) * 100,
            2
        ) AS revenue_share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'fruits' AS category,
        SUM(mnt_fruits) AS total_revenue,
        ROUND(
            (1.0 * SUM(mnt_fruits) / SUM(mnt_total)) * 100,
            2
        ) AS revenue_share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'meat_products' AS category,
        SUM(mnt_meat_products) AS total_revenue,
        ROUND(
            (1.0 * SUM(mnt_meat_products) / SUM(mnt_total)) * 100,
            2
        ) AS revenue_share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'fish_products' AS category,
        SUM(mnt_fish_products) AS total_revenue,
        ROUND(
            (1.0 * SUM(mnt_fish_products) / SUM(mnt_total)) * 100,
            2
        ) AS revenue_share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'sweet_products' AS category,
        SUM(mnt_sweet_products) AS total_revenue,
        ROUND(
            (1.0 * SUM(mnt_sweet_products) / SUM(mnt_total)) * 100,
            2
        ) AS revenue_share_percent
    FROM v_marketing_clean

    UNION ALL

    SELECT
        'gold_products' AS category,
        SUM(mnt_gold_prods) AS total_revenue,
        ROUND(
            (1.0 * SUM(mnt_gold_prods) / SUM(mnt_total)) * 100,
            2
        ) AS revenue_share_percent
    FROM v_marketing_clean
)

SELECT
    *
FROM a
ORDER BY total_revenue DESC;


