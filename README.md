**Customer RFM Analysis — SQL & Power BI** 
**Project Overview** 

This project analyzes customer purchasing behavior, customer segmentation, churn risk, revenue performance, and product performance using MySQL and Power BI. 

The project applies RFM (Recency, Frequency, Monetary) analysis to understand customer purchasing behavior and classify customers into meaningful segments. The analysis also identifies customers based on churn risk and evaluates revenue contribution across customer segments and product categories. 

The final Power BI dashboard contains four pages that provide customer-level analysis, revenue analysis, product performance, and an executive summary with business recommendations. 

**Objectives**

• Analyze customer purchasing behavior using transaction data. 
• Clean and prepare the data using SQL. 
• Calculate Recency, Frequency, and Monetary metrics. 
• Create RFM scores using quartile-based scoring. 
• Segment customers based on RFM behavior. 
• Classify customers based on churn risk. 
• Analyze revenue by customer segment and product category. 
• Identify top-performing products. 
• Analyze revenue trends over time. 
• Generate business insights and recommendations. 

**Tools & Technologies**

• MySQL 
• SQL 
• Power BI 
• DAX 
• RFM Analysis 
• Data Visualization 

**SQL Analysis**

SQL was used for data preparation, validation, transformation, customer-level analysis, RFM calculations, segmentation, and churn-risk classification. 

**Data Preparation**

The raw sales data was loaded into a staging table and prepared for analysis. 

The SQL process included: 

• Creating the database and staging table. 
• Reviewing the raw transaction data. 
• Identifying customer/header rows. 
• Separating customer information from transaction records. 
• Filling customer and region information using SQL window functions. 
• Removing non-transaction rows. 
• Converting dates and numeric fields into appropriate data types. 
• Creating a structured sales transaction table. 

**Data Validation**

The transaction data was validated using checks such as: 

• Total transaction count 
• Distinct customer count 
• Minimum transaction date 
• Maximum transaction date 
• Missing Customer ID checks 
• Duplicate Transaction ID checks 

**RFM Analysis**

RFM analysis was performed at the customer level. 

**Recency**

Measures how recently a customer made a purchase. 

**Frequency**

Measures how frequently a customer made transactions. 

**Monetary**

Measures the total amount spent by a customer. 

The RFM analysis uses June 30, 2025 as the analysis date. 

**RFM Scoring**

Customers were assigned RFM scores using the SQL NTILE(4) function. 

The scoring was based on: 

• Recency 
• Frequency 
• Monetary value 

The individual scores were combined to create an overall RFM score. 

**Customer Segmentation** 

Customers were classified into seven segments based on their RFM behavior: 

• Champions 
• Loyal Customers 
• Potential Loyalists 
• New Customers 
• At Risk 
• Need Attention 
• Lost Customers 

**Churn Risk Classification**

Customers were classified into three churn-risk categories based on Recency: 

• Low Risk — Recency ≤ 30 days 
• Medium Risk — Recency between 31 and 60 days 
• High Risk — Recency > 60 days  

**Power BI Dashboard**

The Power BI report contains four pages. 

**Page 1 — Customer RFM Analysis Dashboard**

This page provides an overview of customer behavior, RFM segmentation, and churn risk. 

KPIs: 

• Total Customers 
• Total Revenue 
• High Risk Customers 
• High Risk % 
• Average Recency 
• Average Frequency 

Visualizations: 

• Customer Distribution by Churn Risk 
• Customer Engagement & Value by Segment 
• Customer Distribution by Segment 
• Revenue by Customer Segment 

Interactive Slicers: 

• Customer Segment 
• Churn Risk 

**Page 2 — Customer & Revenue Analysis**

This page focuses on revenue contribution across customer segments and product categories. 

Visualizations: 

• Revenue by Product Category 
• Revenue Contribution by Customer Segment 
• Quantity vs Revenue by Product Category 
• Revenue by Customer Segment & Product Category 

**Page 3 — Transaction & Product Performance**

This page focuses on transaction trends and product-level performance. 

Visualizations: 

• Revenue Trend Over Time 
• Top Products by Revenue  
• Quantity Distribution by Product Category 
• Product Performance Details 

**Page 4 — Executive Summary & Business Insights**

This page summarizes the major findings from the analysis and presents business recommendations. 

Key areas: 

• Total Revenue 
• Total Customers 
• High Risk Customers 
• High Risk % 
• Key Business Insights 
• Recommended Actions 

**Key Business Insights**
**Customer Risk**

41% of customers are classified as High Risk, highlighting a significant customer-retention concern. 

**Customer Revenue**

At Risk customers contribute the highest revenue among the identified customer segments. 

**Product Performance**

Electronics is the leading product category by revenue, outperforming Furniture and Office Supplies. 

**Revenue Trend**

Revenue declines substantially from January to June, indicating the need to investigate the factors driving the decline. 

**Business Recommendations**
**Customer Retention**

Prioritize retention campaigns for High Risk customers and identify opportunities to move them into stronger customer segments. 

**Revenue Protection**

Focus on At Risk customers because they contribute the highest revenue. Use targeted offers and personalized engagement to reduce potential revenue loss. 

**Product Strategy**

Strengthen the Electronics category while identifying opportunities to improve the performance of Furniture and Office Supplies. 

**Revenue Improvement**

Investigate the significant revenue decline from January to June and identify the main factors contributing to the decrease. 

**Customer Segmentation**

Develop segment-specific strategies to retain At Risk customers, re-engage Lost Customers, and nurture Potential Loyalists toward higher-value segments. 

**Project Outcome**

This project demonstrates how SQL and Power BI can be combined to transform transaction data into meaningful customer and business insights. 

The analysis helps identify: 

• High-value customers 
• Customers at risk of churn 
• Customer segments 
• Revenue-driving segments 
• High-performing product categories 
• Top-performing products 
• Revenue trends 

The resulting Power BI dashboard provides an interactive view of customer behavior, churn risk, revenue performance, product performance, and business recommendations. 
