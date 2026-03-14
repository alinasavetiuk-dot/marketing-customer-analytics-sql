# Marketing Customer Analytics

SQL | Customer Analytics | Marketing Campaign Analysis

---

## Executive Summary

This project analyzes customer purchasing behavior and marketing campaign performance using SQL.

Key findings:

- The dataset contains 2,240 customers generating 1.36M in revenue.
- Average revenue per customer is 605, indicating strong customer value.
- Wine products generate over 50% of total revenue, making them the primary revenue driver.
- Customers without children spend nearly 3x more per person than families with children.
- Physical stores remain the dominant sales channel (46%), although digital channels represent more than half of purchases combined.

---

## Project Goals

The goal of this analysis is to better understand:

- customer purchasing behavior
- high-value customer segments
- product revenue distribution
- marketing campaign performance

---

## Dataset

Marketing Campaign Dataset  
Source: Kaggle  
https://www.kaggle.com/datasets/imakash3011/customer-personality-analysis

---

## Tools

- SQL
- PostgreSQL
- DBeaver

---

## SQL Skills Demonstrated

- Data aggregation
- Customer segmentation
- KPI calculation
- Marketing campaign analysis
- Revenue distribution analysis

---

## Key Insights

### Sales Channels

| Channel | Purchases | Share |
|---|---|---|
Store | 12970 | 46% |
Web | 9150 | 33% |
Catalog | 5963 | 21% |

Physical stores remain the dominant sales channel, although digital channels already account for more than half of purchases combined.

---

### Customer Segmentation

Customers without children generate the highest revenue per person and spend almost three times more per customer than families with children.

---

### Product Performance

Wine products dominate the product portfolio, generating over 50% of total revenue, followed by meat products (27%).

---

### Marketing Campaign Performance

Campaign cmp4 achieved the highest acceptance rate, while cmp2 significantly underperformed, suggesting differences in campaign targeting or messaging effectiveness.

The most recent campaign achieved a 14.9% response rate, which is considered strong compared to typical marketing campaign benchmarks.

---

## Project Structure

marketing-customer-analytics-sql
│
├── 01_data_cleaning.sql
├── 02_marketing_analysis.sql
└── README.md
