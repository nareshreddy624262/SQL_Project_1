CREATE DATABASE projects

-- 2. Data Exploration & Cleaning

-- Record Count: Determine the total number of records in the dataset.

SELECT COUNT(*) AS total_records 
FROM `sql - retail sales analysis_utf`

-- Customer Count: Find out how many unique customers are in the dataset.

SELECT COUNT(DISTINCT ï»¿transactions_id) AS unique_customers
FROM `sql - retail sales analysis_utf`


-- Category Count: Identify all unique product categories in the dataset.

SELECT DISTINCT category
FROM `sql - retail sales analysis_utf`

-- Null Value Check: Check for any null values in the dataset and delete records with missing data.

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
total_sale IS NULL 


-- 3. Data Analysis & Findings-- -- 

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM `sql - retail sales analysis_utf`
WHERE sale_date ='2022-11-05'

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT *
FROM `sql - retail sales analysis_utf`
WHERE category = 'Clothing'
 AND quantiy >=4
AND sale_date BETWEEN'2022-11-01' AND '2022-11-30'

-- Write a SQL query to calculate the total sales (total_sale) for each category.:


SELECT category , sum(total_sale) AS total_sales_for_category
FROM `sql - retail sales analysis_utf`
GROUP BY category

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT AVG(age) as avarage_age
FROM`sql - retail sales analysis_utf`
WHERE category = 'Beauty' 

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT *
FROM `sql - retail sales analysis_utf`
WHERE total_sale >= 1000

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT category , gender , COUNT(ï»¿transactions_id) AS total_number_sales

FROM `sql - retail sales analysis_utf`
GROUP BY category , gender
ORDER BY category

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT year_sales , month_sales , avg_sales , rank_for_sale
FROM(
	SELECT YEAR(sale_date) AS year_sales,
	MONTH(sale_date) AS month_sales,
    AVG(total_sale) AS avg_sales,
	RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank_for_sale
	FROM `sql - retail sales analysis_utf`
	GROUP BY 1 , 2
	ORDER BY 1 , 2
	) AS best_sales
WHERE rank_for_sale = 1

-- *Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT ï»¿transactions_id , SUM(total_sale) AS top_sales
FROM`sql - retail sales analysis_utf`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT category , COUNT(DISTINCT ï»¿transactions_id) AS unique_cutomers
FROM `sql - retail sales analysis_utf`
GROUP BY category



-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH CTE AS
(
SELECT *,
	CASE
		WHEN HOUR(sale_time) >= 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift_time
FROM `sql - retail sales analysis_utf`
)
SELECT shift_time , COUNT(*) AS total_sales
FROM CTE
GROUP BY 1

