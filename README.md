# Customer RFM Analysis — SQL & Power BI

## Project Overview

This project analyzes customer purchasing behavior using **MySQL and Power BI**.

The analysis applies **RFM (Recency, Frequency, Monetary)** methodology to understand customer behavior, segment customers based on purchasing patterns, identify churn-risk customers, and analyze revenue and product performance.

The project combines SQL-based data preparation and analysis with an interactive Power BI dashboard to generate actionable business insights and recommendations.

---

## Business Objectives

- Clean and prepare raw transaction data using SQL.
- Build a structured transaction-level dataset.
- Calculate Recency, Frequency, and Monetary metrics.
- Assign RFM scores using quartile-based scoring.
- Segment customers based on purchasing behavior.
- Identify customers based on churn risk.
- Analyze revenue by customer segment and product category.
- Identify top-performing products.
- Analyze revenue trends over time.
- Generate business insights and recommendations.

---

## Tools & Technologies

- **MySQL**
- **SQL**
- **Power BI**
- **DAX**
- **RFM Analysis**
- **Data Visualization**

---

## Project Workflow

```text
Raw Transaction Data
        ↓
Data Cleaning & Transformation using SQL
        ↓
Transaction Validation
        ↓
Customer-Level RFM Calculation
        ↓
RFM Scoring
        ↓
Customer Segmentation
        ↓
Churn Risk Classification
        ↓
Power BI Data Model
        ↓
Interactive Dashboard
        ↓
Business Insights & Recommendations

## SQL Analysis
1. Data Preparation

The raw sales data was loaded into a staging table and analyzed for data quality and structure.

The SQL workflow included:

Creating the database and staging table.
Identifying customer/header rows.
Separating customer information from transaction records.
Filling customer and region information using window functions.
Removing non-transaction rows.
Converting date and numeric fields into appropriate data types.
Creating a structured sales transaction table.

2. Data Validation

The transaction data was validated using checks such as:

Total transaction count
Distinct customer count
Minimum and maximum transaction dates
Missing Customer ID checks
Duplicate Transaction ID checks

3. RFM Analysis

Customer-level RFM metrics were calculated:

Recency — Number of days since the customer's most recent purchase.
Frequency — Number of distinct transactions made by the customer.
Monetary — Total amount spent by the customer.

The RFM analysis uses June 30, 2025 as the analysis date.

4. RFM Scoring

Customers were assigned scores using NTILE(4):

Recency score
Frequency score
Monetary score

The three scores were combined to create an overall RFM score.

5. Customer Segmentation

Customers were classified into seven customer segments:

Champions
Loyal Customers
Potential Loyalists
New Customers
At Risk
Need Attention
Lost Customers

6. Churn Risk Classification

Customers were classified based on their Recency:

Low Risk — Recency ≤ 30 days
Medium Risk — Recency between 31 and 60 days
High Risk — Recency > 60 days
Power BI Dashboard

The Power BI report contains four analytical pages.

Page 1 — Customer RFM Analysis

This page provides an overview of customer behavior and RFM-based analysis.

Key metrics
Total Customers
Total Revenue
High Risk Customers
High Risk %
Average Recency
Average Frequency
Visualizations
Customer Distribution by Churn Risk
Customer Engagement & Value by Segment
Customer Distribution by Segment
Revenue by Customer Segment
Interactive Filters
Customer Segment
Churn Risk

Page 2 — Customer & Revenue Analysis

This page focuses on revenue distribution across customer segments and product categories.

Visualizations
Revenue by Product Category
Revenue Contribution by Customer Segment
Quantity vs Revenue by Product Category
Revenue by Customer Segment & Product Category

Page 3 — Transaction & Product Performance

This page focuses on transaction trends and product-level performance.

Visualizations
Revenue Trend Over Time
Top Products by Revenue
Quantity Distribution by Product Category
Product Performance Details

Page 4 — Executive Summary

This page summarizes the major findings from the analysis and translates them into business actions.

Key Business Insights
41% of customers are classified as High Risk, indicating a significant customer-retention concern.
At Risk customers contribute the highest revenue among the identified customer segments.
Electronics is the leading product category by revenue.
Revenue declines substantially from January to June, indicating a need to investigate the drivers of the decline.

Recommended Actions 
Prioritize retention campaigns for High Risk customers. 
Use targeted offers and personalized engagement for At Risk customers. 
Focus inventory and marketing efforts on high-performing product categories. 
Investigate the factors contributing to the decline in monthly revenue. 
Develop segment-specific strategies to improve customer retention and customer value. 

Key Business Insights: 
Customer Risk 
41% of customers are classified as High Risk, highlighting a significant customer-retention concern. 

Customer Revenue: 
At Risk customers contribute the highest revenue among the identified customer segments. 

Product Performance: 
Electronics is the leading product category by revenue, outperforming Furniture and Office Supplies. 

Revenue Trend: 
Revenue declines substantially from January to June, indicating the need to investigate the factors driving the decline. 

Business Recommendations 
Customer Retention 
Prioritize retention campaigns for High Risk customers and identify opportunities to move them into stronger customer segments. 

Revenue Protection 
Focus on At Risk customers, as they contribute the highest revenue. Use targeted offers and personalized engagement to reduce potential revenue loss. 

Product Strategy 
Strengthen the Electronics category while identifying opportunities to improve the performance of Furniture and Office Supplies. 

Revenue Improvement 
Analyze the significant revenue decline from January to June and identify the main factors driving the decrease. 

Customer Segmentation 
Develop segment-specific strategies to retain At Risk customers, re-engage Lost Customers, and nurture Potential Loyalists toward higher-value segments. 
