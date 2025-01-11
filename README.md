# SQL Retail Sales Analysis - Beginner Project

This project showcases SQL skills by analyzing retail sales data. It includes data cleaning, exploration, and analysis to answer key business questions.

## Table of Contents
1. [Project Overview](#project-overview)
2. [Database Structure](#database-structure)
3. [Queries and Insights](#queries-and-insights)
4. [Challenges and Solutions](#challenges-and-solutions)
5. [Potential Improvements](#potential-improvements)
6. [How to Use This Project](#how-to-use-this-project)

---

## Project Overview
The primary objective is to demonstrate SQL proficiency by working with retail sales data. The project includes:
- Data Cleaning: Identifying and removing null or invalid records.
- Data Exploration: Understanding the dataset and extracting key metrics.
- Business Analysis: Addressing real-world business scenarios, such as identifying top customers and analyzing sales trends.

---

## Database Structure
The database consists of a single table named `retail_sales`, with the following schema:

| Column Name        | Data Type     | Description                              |
|--------------------|---------------|------------------------------------------|
| `transactions_id`  | INT           | Unique transaction ID.                   |
| `sale_date`        | DATE          | Date of the sale.                        |
| `sale_time`        | TIME          | Time of the sale.                        |
| `customer_id`      | INT           | Unique customer ID.                      |
| `gender`           | VARCHAR(15)   | Gender of the customer.                  |
| `age`              | INT           | Age of the customer.                     |
| `category`         | VARCHAR(15)   | Product category.                        |
| `quantity`         | INT           | Quantity of items sold.                  |
| `price_per_unit`   | FLOAT         | Price per unit.                          |
| `cogs`             | FLOAT         | Cost of goods sold.                      |
| `total_sale`       | FLOAT         | Total sale amount.                       |

---

## Queries and Insights

### Data Cleaning
- **Identify NULL Values:**
  ```sql
  SELECT *
  FROM retail_sales
  WHERE
      transactions_id IS NULL
      OR sale_date IS NULL
      OR sale_time IS NULL
      OR gender IS NULL
      OR category IS NULL
      OR quantity IS NULL
      OR cogs IS NULL
      OR total_sale IS NULL;
  ```

- **Remove NULL Values:**
  ```sql
  DELETE FROM retail_sales
  WHERE
      transactions_id IS NULL
      OR sale_date IS NULL
      OR sale_time IS NULL
      OR gender IS NULL
      OR category IS NULL
      OR quantity IS NULL
      OR cogs IS NULL
      OR total_sale IS NULL;
  ```

### Data Exploration
1. **Total Sales Count:**
   ```sql
   SELECT COUNT(*) AS total_sales FROM retail_sales;
   ```

2. **Unique Customers:**
   ```sql
   SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
   ```

3. **Distinct Categories:**
   ```sql
   SELECT DISTINCT category AS categories FROM retail_sales;
   ```

### Business Analysis
1. **Sales on a Specific Date (`2022-11-05`):**
   ```sql
   SELECT *
   FROM retail_sales
   WHERE sale_date = '2022-11-05';
   ```

2. **High-Quantity Clothing Sales in November 2022:**
   ```sql
   SELECT *
   FROM retail_sales
   WHERE category = 'Clothing'
       AND sale_date >= '2022-11-01'
       AND sale_date < '2022-12-01'
       AND quantity > 4;
   ```

3. **Total Sales by Category:**
   ```sql
   SELECT
       category,
       SUM(total_sale) AS net_sales
   FROM retail_sales
   GROUP BY category;
   ```

4. **Average Age of 'Beauty' Category Customers:**
   ```sql
   SELECT
       AVG(age) AS avg_age
   FROM retail_sales
   WHERE category = 'Beauty';
   ```

5. **Transactions with Total Sales > 1000:**
   ```sql
   SELECT *
   FROM retail_sales
   WHERE total_sale > 1000;
   ```

6. **Transactions by Gender and Category:**
   ```sql
   SELECT
       category,
       gender,
       COUNT(*) AS total_transactions
   FROM retail_sales
   GROUP BY category, gender
   ORDER BY category;
   ```

7. **Best-Selling Month per Year:**
   ```sql
   SELECT
       year,
       month,
       avg_sale
   FROM (
       SELECT
           YEAR(sale_date) AS year,
           MONTH(sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (
               PARTITION BY YEAR(sale_date)
               ORDER BY AVG(total_sale) DESC
           ) AS rank_values
       FROM retail_sales
       GROUP BY YEAR(sale_date), MONTH(sale_date)
   ) ranked_sales
   WHERE rank_values = 1;
   ```

8. **Top 5 Customers by Total Sales:**
   ```sql
   SELECT
       customer_id,
       SUM(total_sale) AS total_sales
   FROM retail_sales
   GROUP BY customer_id
   ORDER BY total_sales DESC
   LIMIT 5;
   ```

9. **Unique Customers by Category:**
   ```sql
   SELECT
       category,
       COUNT(DISTINCT customer_id) AS unique_customers
   FROM retail_sales
   GROUP BY category;
   ```

10. **Orders by Time Shifts (Morning, Afternoon, Evening):**
    ```sql
    WITH hourly_sales AS (
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
        COUNT(*) AS total_orders
    FROM hourly_sales
    GROUP BY shift;
    ```

---

## Challenges and Solutions
- **Handling NULL Values:** Ensured clean data by identifying and deleting incomplete records.
- **Optimizing Queries:** Utilized aggregate functions and window functions to efficiently compute results.
- **Time-based Analysis:** Leveraged SQL functions to group sales by specific time shifts.

---

## Potential Improvements
- Normalize the database by creating separate tables for customers and product categories.
- Add indexes on frequently queried columns (e.g., `sale_date`, `category`).
- Integrate visualization tools like Tableau or Power BI for deeper insights.

---


