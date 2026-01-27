-- Data Cleaning And Validation

-- Check for null values

SELECT *
FROM retail_sales
WHERE sale_date IS NULL
   OR customer_id IS NULL
   OR category IS NULL
   OR total_sale IS NULL;

-- Check for duplicate values
  
SELECT transactions_id, COUNT(*)
FROM retail_sales
GROUP BY transactions_id
HAVING COUNT(*) > 1;

--Check for valid Numeric values
SELECT *
FROM retail_sales
WHERE quantiy <= 0
   OR price_per_unit <= 0
   OR total_sale <= 0;

-- Exploratory Data Analysis (EDA)
-- Total Revenue & Transactions

SELECT 
    SUM(total_sale) AS total_revenue,
    COUNT(transactions_id) AS total_transactions
FROM retail_sales;

--Sales by Product Category
SELECT 
    category,
    SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY category
ORDER BY revenue DESC;

-- Daily Sales Trend
SELECT 
    sale_date,
    SUM(total_sale) AS daily_sales
FROM retail_sales
GROUP BY sale_date
ORDER BY sale_date;

--Top 5 Customers by Revenue
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS customer_revenue
FROM retail_sales
GROUP BY customer_id
ORDER BY customer_revenue DESC

--Sales by Gender
SELECT 
    gender,
    SUM(total_sale) AS revenue
FROM retail_sales
GROUP BY gender;

--Average Spend by Age Group
   SELECT
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE '50+'
    END AS age_group,
    AVG(total_sale) AS avg_spend
FROM reatail_sales
GROUP BY
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE '50+'
    END;

--Profitability Analysis
SELECT
    transactions_id,
    total_sale - cogs AS profit
FROM retail_sales;

--Profit by Category

SELECT
    category,
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;


--Rank Categories by Revenue
SELECT
    category,
    SUM(total_sale) AS revenue,
    RANK() OVER (ORDER BY SUM(total_sale) DESC) AS revenue_rank
FROM retail_sales
GROUP BY category;

--Monthly Sales Trend
SELECT
    YEAR(sale_date) AS sales_year,
    MONTH(sale_date) AS sales_month,
    SUM(total_sale) AS monthly_sales
FROM retail_sales
GROUP BY
    YEAR(sale_date),
    MONTH(sale_date)
ORDER BY
    sales_year,
    sales_month;




