create database pizza;
use pizza;
select * from order_details;
select  * from orders;
select * from pizza_types;
select * from pizzas;
select * from pizza_sales;


#--1)Total Revenue
select sum(total_price) as Total_Revenue
from pizza_sales;

#--2)Average Order Value

CREATE TABLE average_order_table AS
SELECT AVG(order_value) AS Average_Order
FROM (
    SELECT order_id, SUM(total_price) AS order_value
    FROM pizza_sales
    GROUP BY order_id
) AS order_summary;
select * from average_order_table;

#--3)Total Pizza Sold
CREATE TABLE total_pizza_sold AS
SELECT SUM(quantity) AS pizza_sold
FROM pizza_sales;
select * from total_pizza_sold;

#--4)Total Orders
create table Total_Orders as 
select count(distinct order_id) as Total_orders
from order_details;
select * from total_orders;

#--5)Average Pizzas Per Order

create table Average_Pizzas_Per_Order as 
SELECT AVG(pizzas_per_order) AS average_pizzas_per_order
FROM (
    SELECT order_id, SUM(quantity) AS pizzas_per_order
    FROM pizza_sales
    GROUP BY order_id
) AS order_summary;
select * from average_pizzas_per_order;



#--6)Daily Trend for Total Order
create table Daily_trend_for_total_order as
select order_date, sum(quantity) as Total_pizza_sales
from pizza_sales
group by order_date
order by order_date;
select * from daily_trend_for_total_order;

#7)Monthly Trend for Total order 

create table Monthly_Trend_for_Total_order as 
SELECT DATE_FORMAT(order_date, '%y-%m') AS month, 
       COUNT(DISTINCT order_id) AS Total_monthly_sales
FROM pizza_sales
WHERE order_date IS NOT NULL  -- Ensuring no NULL values affect the results
GROUP BY month;

#--8)% of Sales by Pizza Category
create table percent_of_Sales_by_Pizza_Category as select pizza_category,sum(total_price) as Category_sales, (sum(total_price)*100.0)/sum(sum(total_price))OVER () AS percentage_of_total_sales
from pizza_sales
group by pizza_category;
select * from percent_of_Sales_by_Pizza_Category;


#--9)% of Sales by Pizza Size
create table percent_of_sales_by_pizza_size as 
select pizza_size,sum(total_price) as Category_sales, (sum(total_price)*100.0)/sum(sum(total_price))OVER () AS percentage_of_total_sales
from pizza_sales
group by pizza_size;
select * from  percent_of_sales_by_pizza_size;

#--10)Top 5 Best Sellers by Revenue
create table top5_best_sellers_by_revenue as
select pizza_name,
    SUM(total_price) AS total_revenue
from pizza_sales
group by pizza_name
order by  total_revenue desc
limit 5 ;
select * from top5_best_sellers_by_revenue;

#--11)Bottom 5 Sellers by Revenue
create table Bottom5_sellers_by_revenue as
select pizza_name,
    SUM(total_price) AS total_revenue
from pizza_sales
group by pizza_name
order by  total_revenue asc
limit 5 ;
select * from bottom5_sellers_by_revenue;

#--12)Top 5 Best Sellers by Quantity
create table Top5_Best_Sellers_by_Quantity as
select pizza_name,sum(Quantity) as Total_quantity,
    SUM(total_price) AS total_revenue
from pizza_sales
group by pizza_name
order by  total_quantity desc
limit 5 ;
select * from Top5_Best_Sellers_by_Quantity;

#--13)Bottom 5 Sellers by Revenue
select pizza_name,
    SUM(total_price) AS total_revenue
from pizza_sales
group by pizza_name
order by  total_revenue asc
limit 5 ;
#--14)Top 5 Best Sellers by Total Orders
create table Top5_Best_Sellers_by_Total_Orders as
select pizza_name, count(distinct order_id) as Total_orders, 
sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by Total_orders  desc
limit 5;
select * from Top5_Best_Sellers_by_Total_Orders;

#--15)Bottom 5 Sellers by Total Orders
create table Bottom5_Sellers_by_Total_Orders as
select pizza_name, count(distinct order_id) as Total_orders, 
sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by Total_orders  asc
limit 5;
select * from Bottom5_Sellers_by_Total_Orders;
#--16)Number of Customers each day &  Busiest hours
create table Number_of_Customers_each_day as
select order_date as Date, count(distinct order_id) as Total_customer
from pizza_sales
group by order_date
order by order_date ;
select * from Number_of_Customers_each_day;

create table NO_of_Customers_busiest_hours;
select extract(hour from order_time)  as hour,  count(distinct order_id) as Total_order
from pizza_sales
group by hour
order by total_order desc;
 
select * from No_of_Customers_busiest_hours ;

