-- SQL Retail Sales Analysis - Project 1

-- First We create The Database
CREATE DATABASE sql_project1;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales 
	(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age	INT,
		category VARCHAR(15),
		quantiy	INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT 
	);

SELECT * 
FROM retail_sales;

SELECT 
	COUNT(*)
FROM retail_sales;

-- Data Cleaning

SELECT * 
FROM retail_sales
WHERE 
	transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Deleting the Null values
DELETE from retail_sales
WHERE 
	transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) as total_customers FROM retail_sales;

-- How many categories we have?
SELECT DISTINCT category as categories FROM retail_sales;


-- Data Analysis & Business Key Problems & Answer
-- My Analysis & Findings

-- Q. 1 Write a SQL query to Retrieve all column for sales made on '2022-11-05'
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05' ;

-- Q. 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND sale_date >= '2022-11-01'
    AND sale_date < '2022-12-01'
    AND quantiy >= 4;

-- Q. 3 Write a SQL query to calculate the total sales (total_sales) for each category
SELECT 
	category,
    SUM(total_sale) as net_sales,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
;

-- Q. 4 Write a SQL query to find the average age of customers who purchased items form the 'Beauty' category
SELECT 
	AVG(age) as avg_Age
FROM retail_sales
WHERE category = 'Beauty'
;


-- Q. 5 Write a SQL query to fin all transactions where the total_sales is greater than 1000. 
SELECT *
FROM retail_sales
WHERE total_sale > 1000;


-- Q. 6 Write a SQL query to find the total number of transactions (transactions_id) made by each gender in each category

SELECT
	DISTINCT category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
	BY
	category,
    gender
ORDER BY 1
;

-- Q. 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT
	year,
    month,
    avg_sale
FROM
(
SELECT
	YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (
    PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) as rank_values
FROM retail_sales
GROUP BY 1, 2
) as avg_sales
WHERE rank_values = 1
;

-- Q. 8 Write a SQL query to find the op 5 customers based on the highest total sales

SELECT 
	customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Q. 9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT 
	category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY categor
;

-- Q. 10 Write a SQL query to creae each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evenng > 17)

WITH hourly_sales
AS 
(
SELECT *,
	CASE
		WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT
	shift,
	COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift


-- END of the project


    