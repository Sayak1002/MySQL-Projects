CREATE DATABASE PIZZA_DB;
USE PIZZA_DB;

-- Necessary table data have been cleaned in Excel and then imported using the table data import wizard
-- Adding the primary and Foreign key relationships

ALTER TABLE pizzas
MODIFY COLUMN pizza_id VARCHAR(50);  -- Change length and datatype as needed
ALTER TABLE pizzas
ADD CONSTRAINT pk_pizzaid PRIMARY KEY (pizza_id); -- adding primary key

ALTER TABLE order_details ADD CONSTRAINT fk_orderid
FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE; -- adding foreign key 

ALTER TABLE order_details
MODIFY COLUMN pizza_id VARCHAR(50); -- Change length and datatype as needed
ALTER TABLE order_details ADD CONSTRAINT fk_pizzaid
FOREIGN KEY(pizza_id) REFERENCES pizzas(pizza_id) ON DELETE CASCADE; -- adding foreign key


ALTER TABLE pizza_types
MODIFY COLUMN pizza_type_id VARCHAR(50); -- Change length and datatype as needed
ALTER TABLE pizza_types
ADD CONSTRAINT pk_pizzatypeid PRIMARY KEY (pizza_type_id); -- adding primary key

ALTER TABLE pizzas ADD CONSTRAINT fk_pizzatypeid
FOREIGN KEY(pizza_type_id) REFERENCES pizza_types(pizza_type_id) ON DELETE CASCADE; -- adding foreign key 


-------------------------------------------------------------------------------------------------------------
-- EXPLORATORY ANALYSIS
-- LEVEL:- Basic:
-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS 'Total Orders' from orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
ROUND(SUM(p.price*o.quantity),2) AS "Total Revenue"
FROM pizzas p
JOIN order_details o
ON p.pizza_id = o.pizza_id;


-- Identify the highest-priced pizza.
SELECT
name,price
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id=pt.pizza_type_id 
ORDER BY  2 DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
 SELECT 
 size,
 count(*) AS 'Number Of Times Ordered'
 FROM pizzas p
 JOIN order_details o
 ON p.pizza_id = o.pizza_id
 GROUP BY  size
 ORDER BY 2 DESC
 LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
name,
SUM(quantity)  AS "Quantity ordered"
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
ON od.pizza_id = p.pizza_id
GROUP BY name
ORDER BY 2 DESC
LIMIT 5;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT Category, COUNT(NAME) AS 'Number of items'
FROM pizza_types
GROUP BY category;


-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
category,
SUM(quantity) AS"Total Quantity "
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od
ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY 2 DESC;


-- Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time) AS "Hour",
COUNT(order_id) AS "Order count" FROM orders
GROUP BY HOUR(order_time);


-------------------------------------------------------------------------------------------------------------
-- LEVEL:- Intermediate:

-- calculate the average number of pizzas ordered per day.
WITH CTE AS(
SELECT o.order_date,
SUM(od.quantity) AS "Quantity"
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
GROUP BY o.order_date)
SELECT ROUND(AVG(Quantity),0) AS"Average quantity per day" FROM CTE;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
a.name,
SUM((c.quantity* b.price)) AS 'Revenue'
FROM pizza_types a
JOIN pizzas b ON
a.pizza_type_id = b.pizza_type_id
JOIN order_details c
ON c.pizza_id = b.pizza_id
GROUP BY a.name
ORDER BY 2 DESC
LIMIT 3;

-------------------------------------------------------------------------------------------------------------
-- Level:- Advanced
-- Calculate the percentage contribution of each pizza type to total revenue

SELECT a.category,
round(SUM(c.quantity*b.price)/
(select round(sum(c.quantity*b.price),2) from order_details c join pizzas b on c.pizza_id = b.pizza_id)*100,2) AS 'Percentage Contribution'
FROM
pizza_types a 
JOIN pizzas b
ON a.pizza_type_id = b.pizza_type_id
JOIN order_details c
ON c.pizza_id = b.pizza_id
GROUP BY a.category;

-- Analyze the cumulative revenue generated over time

WITH CTE AS(
SELECT 
c.order_date AS 'Order_date',
ROUND(SUM(a.quantity*b.price),2) AS 'Revenue'
FROM  order_details a
JOIN pizzas b
ON a.pizza_id = b.pizza_id
JOIN orders c
ON c.order_id = a.order_id
GROUP BY c.order_date)
SELECT Order_date,
SUM(Revenue) OVER(order by  Order_date) as 'Cumulative Revenue'
FROM CTE;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category

WITH CTE AS(
SELECT 
a.category AS 'Category',
a.name AS 'Name',
SUM(b.price*c.quantity) AS 'Revenue'
FROM 
pizza_types a
JOIN pizzas b
ON a.pizza_type_id = b.pizza_type_id
JOIN order_details c
ON c.pizza_id = b.pizza_id
GROUP BY a.category,a.name),
CTE2 AS(
SELECT Category,
Name,
Revenue,
DENSE_RANK()OVER(PARTITION BY Category ORDER BY Revenue DESC) AS 'Ranking'
FROM CTE)
SELECT*FROM CTE2
WHERE Ranking<=3;







