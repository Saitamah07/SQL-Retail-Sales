# SQL Retail Sales Analysis - Beginner Project

This project leverages SQL to analyze retail sales data. It includes data cleaning, exploration, and analysis through queries designed to address key business questions.

## Table of Contents
1. [Project Description](#project-description)
2. [Database Structure](#database-structure)
3. [Queries and Insights](#queries-and-insights)
4. [Potential Improvements](#potential-improvements)
5. [How to Use This Project](#how-to-use-this-project)

## Project Description
The goal of this project is to apply SQL concepts to perform:
- **Data Cleaning:** Handling null values and preparing the dataset.
- **Data Exploration:** Identifying key statistics such as total sales, unique customers, and categories.
- **Business Analysis:** Answering specific questions like top-selling months, best customers, and sales by time shifts.

## Database Structure
The project uses a table named `retail_sales` with the following columns:

| Column Name       | Data Type     | Description                              |
|-------------------|---------------|------------------------------------------|
| `transactions_id` | INT           | Unique transaction ID.                   |
| `sale_date`       | DATE          | Date of the sale.                        |
| `sale_time`       | TIME          | Time of the sale.                        |
| `customer_id`     | INT           | Unique customer ID.                      |
| `gender`          | VARCHAR(15)   | Customer's gender.                       |
| `age`             | INT           | Customer's age.                          |
| `category`        | VARCHAR(15)   | Product category.                        |
| `quantity`        | INT           | Quantity of items sold.                  |
| `price_per_unit`  | FLOAT         | Price per unit.                          |
| `cogs`            | FLOAT         | Cost of goods sold.                      |
| `total_sale`      | FLOAT         | Total sale amount.                       |

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```




