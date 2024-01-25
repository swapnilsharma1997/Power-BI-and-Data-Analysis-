-- select * from dbo.pizza_sales;

-- KPI Metrices

-- 1.	Total Revenue: 
select ROUND(SUM(total_price),2) as total_revenue from pizza_sales;
-- 2.	Average Order Value: 
select ROUND(SUM(total_price) /  COUNT(DISTINCT(order_id)),2) as avg_rev_per_order from pizza_sales;
-- 3.	Total Pizza Sold: 
select CAST(SUM(quantity) as DECIMAL(10,2)) as total_pizza_sold from pizza_sales;
-- 4.	Total Orders: 
select CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2))  as total_orders from pizza_sales;
-- 5.	Average Pizza Per Order: 
select CAST( CAST(SUM(quantity) as DECIMAL(10,2))/CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) avg_pizza_per_order  from pizza_sales;


-- CHART REPRESENTATIONS:

-- 1.	Daily Trend for Total Orders: 
SELECT DATENAME(WEEKDAY, order_date) as day, COUNT(DISTINCT order_id) as orders from pizza_sales 
GROUP BY DATENAME(WEEKDAY, order_date) ;


-- 2.	Monthly Trend for Total Orders: 
SELECT DATENAME(MONTH, order_date) as month, COUNT(DISTINCT order_id) as orders from pizza_sales
GROUP BY DATENAME(MONTH, order_date);

-- 3.	Percentage of Sales by Pizza Category:
SELECT pizza_category as pizza_category, CAST(SUM(total_price) as decimal(10,2)) as Total_Sales,
CAST(SUM(total_price) as decimal(10,2)) *100 /( SELECT CAST(SUM(total_price) as decimal(10,2)) from pizza_sales) as Percent_Total_Sales
from pizza_sales Group by pizza_category ;

-- 4.	Percentage of Sales by Pizza Size:

SELECT pizza_size, CAST(SUM(total_price) as DECIMAL(10,2)) as total_sales, 
CAST(SUM(total_price) *100/(select sum(total_price)   from pizza_sales) as DECIMAL(10,2)) as percent_total_sales
from pizza_sales group by pizza_size;

-- 5.	Total Pizza Sold by Pizza Category: 
SELECT pizza_category, sum(quantity) as Pizza_sold from pizza_sales group by pizza_category;

-- 6.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders:
-- by revenue
SELECT TOP 5 pizza_name, CAST(SUM(total_price) as DECIMAL(10,2)) as Total_Revenue from pizza_sales group by pizza_name order by Total_Revenue DESC;
-- by quntity
SELECT TOP 5 pizza_name,SUM(quantity) as Total_quantity from pizza_sales group by pizza_name order by Total_quantity DESC;
-- by orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_orders from pizza_sales group by pizza_name order by Total_orders DESC;

-- 7.	Bottom 5 Least Sellers by Revenue, Total Quantity and Total Orders
-- by Revenue
SELECT TOP 5 pizza_name, CAST(SUM(total_price) as DECIMAL(10,2)) as Total_Revenue from pizza_sales group by pizza_name order by Total_Revenue;
-- by quntity
SELECT TOP 5 pizza_name, SUM(quantity)  as Total_quantity from pizza_sales group by pizza_name order by Total_quantity;
-- by orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) as Total_orders from pizza_sales group by pizza_name order by Total_orders ;