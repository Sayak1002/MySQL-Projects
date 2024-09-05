# Pizza Sales Data Analysis

## Project Overview
This project involves analyzing pizza sales data to uncover key insights using SQL queries. The dataset consists of four tables: `pizzas`, `pizza_type`, `orders`, and `order_details`. Various questions were addressed through SQL queries to understand revenue generation, pizza preferences, and ordering patterns.

## Database Schema
The database `pizza_db` contains the following tables:

### 1. **pizzas**
- `pizza_id`: Unique identifier for each pizza
- `pizza_type_id`: Foreign key linking to the pizza type
- `size`: Size of the pizza (small, medium, large)
- `price`: Price of the pizza based on size

### 2. **pizza_type**
- `pizza_type_id`: Unique identifier for the pizza type
- `name`: Name of the pizza
- `category`: Category (e.g., vegetarian, non-vegetarian)
- `ingredients`: List of ingredients for each pizza type

### 3. **orders**
- `order_id`: Unique identifier for each order
- `order_date`: Date the order was placed
- `order_time`: Time the order was placed

### 4. **order_details**
- `order_details_id`: Unique identifier for each order detail
- `order_id`: Foreign key linking to the `orders` table
- `pizza_id`: Foreign key linking to the `pizzas` table
- `quantity`: Number of pizzas ordered


### Entity Relationship Diagram (ERD)

![Pizza Sales ERD](/Pizza-Sales-ERD-png.png)


## Questions Addressed
The following SQL queries were executed to analyze the pizza sales data:

1. **Total Revenue Calculation**: 
   Calculate the total revenue generated from pizza sales.

2. **Total Orders**: 
   Retrieve the total number of orders placed.

3. **Highest-Priced Pizza**: 
   Identify the highest-priced pizza.

4. **Most Common Pizza Size**: 
   Identify the most common pizza size ordered.

5. **Top 5 Most Ordered Pizza Types**: 
   List the top 5 most ordered pizza types along with their quantities.

6. **Category-Wise Distribution of Pizzas**: 
   Join relevant tables to find the category-wise distribution of pizzas.

7. **Total Quantity by Pizza Category**: 
   Join the necessary tables to find the total quantity of each pizza category ordered.

8. **Order Distribution by Hour**: 
   Determine the distribution of orders by hour of the day.

9. **Average Pizzas Ordered Per Day**: 
   Group the orders by date and calculate the average number of pizzas ordered per day.

10. **Top 3 Pizza Types by Revenue**: 
    Determine the top 3 most ordered pizza types based on revenue.

11. **Pizza Type Revenue Contribution**: 
    Calculate the percentage contribution of each pizza type to total revenue.

12. **Cumulative Revenue Analysis**: 
    Analyze the cumulative revenue generated over time.

13. **Top 3 Pizza Types by Revenue in Each Category**: 
    Determine the top 3 most ordered pizza types based on revenue for each pizza category.

## Data Import Method
All tables were imported into MySQL Workbench via the Table Data Import Wizard, enabling efficient analysis and query execution.

