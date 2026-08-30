show databases;

CREATE DATABASE customer_rfm_analysis;

USE customer_rfm_analysis;

CREATE TABLE staging_sales (
    Transaction_ID VARCHAR(50),
    Date VARCHAR(50),
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(100),
    Product_Category VARCHAR(100),
    Quantity VARCHAR(50),
    PPU VARCHAR(50),
    Amount VARCHAR(50),
    Customer_ID VARCHAR(50),
    Region VARCHAR(100)
);

DESCRIBE staging_sales;

SELECT COUNT(*) AS total_rows
FROM staging_sales;

SELECT *
FROM staging_sales
LIMIT 10;

SELECT *
FROM staging_sales
LIMIT 10;

SELECT *
FROM staging_sales
WHERE Transaction_ID LIKE 'Customer-%'
LIMIT 20;

USE customer_rfm_analysis;

DROP TABLE IF EXISTS raw_staging;

CREATE TABLE raw_staging (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    Transaction_ID VARCHAR(50),
    Date_raw VARCHAR(50),
    Product_ID VARCHAR(50),
    Product_Name VARCHAR(200),
    Product_Category VARCHAR(100),
    Quantity VARCHAR(50),
    PPU VARCHAR(50),
    Amount VARCHAR(50)
);

INSERT INTO raw_staging
    (Transaction_ID, Date_raw, Product_ID, Product_Name,
     Product_Category, Quantity, PPU, Amount)
SELECT
    Transaction_ID, Date, Product_ID, Product_Name,
    Product_Category, Quantity, PPU, Amount
FROM staging_sales;

SELECT COUNT(*) AS total_rows
FROM raw_staging;

SELECT COUNT(*) AS customer_header_rows
FROM raw_staging
WHERE Transaction_ID LIKE 'Customer-%';

SELECT COUNT(*) AS transaction_rows
FROM raw_staging
WHERE Transaction_ID NOT LIKE 'Customer-%';

# Create a cleaned table
USE customer_rfm_analysis;

DROP TABLE IF EXISTS clean_sales;

CREATE TABLE clean_sales AS
WITH filled_data AS (
    SELECT
        row_id,
        Transaction_ID,
        Date_raw,
        Product_ID,
        Product_Name,
        Product_Category,
        Quantity,
        PPU,
        Amount,

        MAX(
            CASE
                WHEN Transaction_ID LIKE 'Customer-%'
                THEN Transaction_ID
            END
        ) OVER (
            ORDER BY row_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Customer_ID,

        MAX(
            CASE
                WHEN Transaction_ID LIKE 'Customer-%'
                THEN Date_raw
            END
        ) OVER (
            ORDER BY row_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS Region

    FROM raw_staging
)

SELECT
    Transaction_ID,
    Date_raw AS Transaction_Date,
    Product_ID,
    Product_Name,
    Product_Category,
    Quantity,
    PPU,
    Amount,
    Customer_ID,
    Region
FROM filled_data
WHERE Transaction_ID NOT LIKE 'Customer-%';

SELECT COUNT(*) AS clean_transactions
FROM clean_sales;

SELECT *
FROM clean_sales
LIMIT 10;

DESCRIBE clean_sales;

SELECT 
    Transaction_Date,
    STR_TO_DATE(Transaction_Date, '%d.%m.%Y') AS converted_date
FROM clean_sales
LIMIT 10;

# Create sales_transactions
USE customer_rfm_analysis;

DROP TABLE IF EXISTS sales_transactions;

CREATE TABLE sales_transactions AS
SELECT
    Transaction_ID,
    STR_TO_DATE(Transaction_Date, '%d.%m.%Y') AS Transaction_Date,
    Product_ID,
    Product_Name,
    Product_Category,
    CAST(Quantity AS UNSIGNED) AS Quantity,
    CAST(REPLACE(PPU, ',', '') AS DECIMAL(15,2)) AS PPU,
    CAST(REPLACE(Amount, ',', '') AS DECIMAL(15,2)) AS Amount,
    Customer_ID,
    Region
FROM clean_sales;

DESCRIBE sales_transactions;

SELECT COUNT(*) AS total_transactions


FROM sales_transactions;

SELECT *
FROM sales_transactions
LIMIT 10;

# Validate the final transaction table

# 1. Number of customers
SELECT COUNT(DISTINCT Customer_ID) AS total_customers
FROM sales_transactions;

# 2. Date range
SELECT
    MIN(Transaction_Date) AS first_purchase,
    MAX(Transaction_Date) AS last_purchase
FROM sales_transactions;

# 3. Check missing Customer IDs
SELECT COUNT(*) AS missing_customer_ids
FROM sales_transactions
WHERE Customer_ID IS NULL
   OR TRIM(Customer_ID) = '';

# 4. Check duplicate transaction IDs   
SELECT
    Transaction_ID,
    COUNT(*) AS duplicate_count
FROM sales_transactions
GROUP BY Transaction_ID
HAVING COUNT(*) > 1;   

# **** Create the Customer RFM Table *****

# Find the analysis date
SELECT MAX(Transaction_Date) AS analysis_date
FROM sales_transactions;

# Calculate RFM
USE customer_rfm_analysis;

DROP TABLE IF EXISTS customer_rfm;

CREATE TABLE customer_rfm AS
SELECT
    Customer_ID,

DATEDIFF(
    (SELECT MAX(Transaction_Date) FROM sales_transactions),
    MAX(Transaction_Date)
) AS Recency,

    COUNT(DISTINCT Transaction_ID) AS Frequency,

    SUM(Amount) AS Monetary

FROM sales_transactions

GROUP BY Customer_ID;

SELECT *
FROM customer_rfm
LIMIT 10;

SELECT COUNT(*) AS total_customers
FROM customer_rfm;

# Check the RFM distribution
# recency distribution
SELECT
    MIN(Recency) AS min_recency,
    MAX(Recency) AS max_recency,
    AVG(Recency) AS avg_recency
FROM customer_rfm;
# freguency distribution
SELECT
    MIN(Frequency) AS min_frequency,
    MAX(Frequency) AS max_frequency,
    AVG(Frequency) AS avg_frequency
FROM customer_rfm;
# monetary distribution
SELECT
    MIN(Monetary) AS min_monetary,
    MAX(Monetary) AS max_monetary,
    AVG(Monetary) AS avg_monetary
FROM customer_rfm;

# *** RFM Scoring ***
USE customer_rfm_analysis;

DROP TABLE IF EXISTS customer_rfm_scored;

CREATE TABLE customer_rfm_scored AS
WITH rfm_scores AS (
    SELECT
        Customer_ID,
        Recency,
        Frequency,
        Monetary,

        NTILE(4) OVER (
            ORDER BY Recency DESC
        ) AS R_Score,

        NTILE(4) OVER (
            ORDER BY Frequency ASC
        ) AS F_Score,

        NTILE(4) OVER (
            ORDER BY Monetary ASC
        ) AS M_Score

    FROM customer_rfm
)

SELECT
    Customer_ID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score
FROM rfm_scores;

SELECT *
FROM customer_rfm_scored
ORDER BY RFM_Score DESC
LIMIT 15;

# Create Customer Segments
USE customer_rfm_analysis;

DROP TABLE IF EXISTS customer_segments;

CREATE TABLE customer_segments AS
SELECT
    Customer_ID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    RFM_Score,

    CASE
        WHEN R_Score >= 4
             AND F_Score >= 4
             AND M_Score >= 4
            THEN 'Champions'

        WHEN R_Score >= 3
             AND F_Score >= 3
             AND M_Score >= 3
            THEN 'Loyal Customers'

        WHEN R_Score >= 3
             AND F_Score >= 2
            THEN 'Potential Loyalists'

        WHEN R_Score = 4
             AND F_Score = 1
            THEN 'New Customers'

        WHEN R_Score <= 2
             AND F_Score >= 3
             AND M_Score >= 3
            THEN 'At Risk'

        WHEN R_Score <= 2
             AND F_Score >= 2
            THEN 'Need Attention'

        ELSE 'Lost Customers'
    END AS Customer_Segment

FROM customer_rfm_scored;

SELECT
    Customer_Segment,
    COUNT(*) AS Customer_Count,
    SUM(Monetary) AS Total_Revenue
FROM customer_segments
GROUP BY Customer_Segment
ORDER BY Customer_Count DESC;

# *** Add Churn Risk***

# Check Recency range
SELECT
    MIN(Recency) AS Min_Recency,
    MAX(Recency) AS Max_Recency,
    ROUND(AVG(Recency), 2) AS Avg_Recency
FROM customer_segments;

# Add Churn Risk
ALTER TABLE customer_segments
ADD COLUMN Churn_Risk VARCHAR(20);

SET SQL_SAFE_UPDATES = 0;

UPDATE customer_segments
SET Churn_Risk =
    CASE
        WHEN Recency <= 30 THEN 'Low Risk'
        WHEN Recency <= 60 THEN 'Medium Risk'
        ELSE 'High Risk'
    END;

SET SQL_SAFE_UPDATES = 1;

SELECT
    Churn_Risk,
    COUNT(*) AS Customer_Count,
    SUM(Monetary) AS Total_Revenue
FROM customer_segments
GROUP BY Churn_Risk
ORDER BY
    CASE Churn_Risk
        WHEN 'High Risk' THEN 1
        WHEN 'Medium Risk' THEN 2
        WHEN 'Low Risk' THEN 3
    END;
    
SELECT
    Customer_Segment,
    Churn_Risk,
    COUNT(*) AS Customer_Count,
    SUM(Monetary) AS Total_Revenue
FROM customer_segments
GROUP BY
    Customer_Segment,
    Churn_Risk
ORDER BY
    Customer_Segment,
    Churn_Risk;

SELECT
    Customer_Segment,
    Churn_Risk,
    COUNT(*) AS Customer_Count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Customer_Segment),
        2
    ) AS Segment_Risk_Percentage,
    SUM(Monetary) AS Total_Revenue
FROM customer_segments
GROUP BY
    Customer_Segment,
    Churn_Risk
ORDER BY
    Customer_Segment,
    Churn_Risk;