
---

# Retail Sales Analysis

This repository contains SQL queries designed to explore, clean, and analyze a retail sales dataset. The dataset includes various sales transactions, customer information, and product details. The queries focus on gaining insights, performing data exploration, and deriving business-related findings from the dataset.

## Table of Contents

1. [Database Setup](#database-setup)
2. [Data Exploration & Cleaning](#data-exploration--cleaning)
3. [Data Analysis & Findings](#data-analysis--findings)
4. [Queries List](#queries-list)
5. [Usage](#usage)
6. [License](#license)

---

## Database Setup

To use this repository, create a database called `projects` and import the retail sales dataset into a table named `sql - retail sales analysis_utf`.

```sql
CREATE DATABASE projects;
```

## Data Exploration & Cleaning

These queries explore the dataset for insights and handle data cleaning by checking for null values and basic record counts.

### 1. Record Count

```sql
SELECT COUNT(*) AS total_records 
FROM `sql - retail sales analysis_utf`;
```

### 2. Customer Count

```sql
SELECT COUNT(DISTINCT ï»¿transactions_id) AS unique_customers
FROM `sql - retail sales analysis_utf`;
```

### 3. Category Count

```sql
SELECT DISTINCT category
FROM `sql - retail sales analysis_utf`;
```

### 4. Null Value Check & Cleaning

Check and remove any records with null values.

```sql
SELECT *
FROM `sql - retail sales analysis_utf`
WHERE ï»¿transactions_id IS NULL OR
sale_date IS NULL OR
sale_time IS NULL OR
customer_id IS NULL OR
gender IS NULL OR
category IS NULL OR
quantiy IS NULL OR
price_per_unit IS NULL OR
total_sale IS NULL;
```

---

## Data Analysis & Findings

These queries are designed to analyze the sales data, focusing on customer behavior, product categories, and transaction patterns.

### 1. Sales on Specific Date

Retrieve all columns for sales made on '2022-11-05'.

```sql
SELECT *
FROM `sql - retail sales analysis_utf`
WHERE sale_date = '2022-11-05';
```

### 2. Transactions with Specific Conditions

Find all transactions where the category is 'Clothing' and the quantity sold is more than 4 in November 2022.

```sql
SELECT *
FROM `sql - retail sales analysis_utf`
WHERE category = 'Clothing'
AND quantiy >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

### 3. Total Sales by Category

Calculate the total sales for each product category.

```sql
SELECT category, SUM(total_sale) AS total_sales_for_category
FROM `sql - retail sales analysis_utf`
GROUP BY category;
```

### 4. Average Age of Customers in 'Beauty' Category

Find the average age of customers who purchased items from the 'Beauty' category.

```sql
SELECT AVG(age) AS average_age
FROM `sql - retail sales analysis_utf`
WHERE category = 'Beauty';
```

### 5. Transactions with Sales Greater Than 1000

Find all transactions where the total sale is greater than 1000.

```sql
SELECT *
FROM `sql - retail sales analysis_utf`
WHERE total_sale >= 1000;
```

### 6. Sales by Gender and Category

Find the total number of transactions by each gender in each product category.

```sql
SELECT category, gender, COUNT(ï»¿transactions_id) AS total_number_sales
FROM `sql - retail sales analysis_utf`
GROUP BY category, gender
ORDER BY category;
```

### 7. Best Selling Month

Calculate the average sale for each month and determine the best-selling month for each year.

```sql
SELECT year_sales, month_sales, avg_sales, rank_for_sale
FROM (
    SELECT YEAR(sale_date) AS year_sales,
           MONTH(sale_date) AS month_sales,
           AVG(total_sale) AS avg_sales,
           RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_for_sale
    FROM `sql - retail sales analysis_utf`
    GROUP BY 1, 2
    ORDER BY 1, 2
) AS best_sales
WHERE rank_for_sale = 1;
```

### 8. Top 5 Customers Based on Total Sales

Find the top 5 customers based on the highest total sales.

```sql
SELECT ï»¿transactions_id, SUM(total_sale) AS top_sales
FROM `sql - retail sales analysis_utf`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

### 9. Unique Customers by Category

Find the number of unique customers who purchased items from each category.

```sql
SELECT category, COUNT(DISTINCT ï»¿transactions_id) AS unique_customers
FROM `sql - retail sales analysis_utf`
GROUP BY category;
```

### 10. Sales by Shift Time

Create shifts based on sale time and calculate the number of orders per shift.

```sql
WITH CTE AS (
    SELECT *,
           CASE
               WHEN HOUR(sale_time) < 12 THEN 'Morning'
               WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift_time
    FROM `sql - retail sales analysis_utf`
)
SELECT shift_time, COUNT(*) AS total_sales
FROM CTE
GROUP BY 1;
```

---

## Usage

1. Set up the database by following the instructions in the "Database Setup" section.
2. Run the SQL queries to perform data exploration, cleaning, and analysis.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
