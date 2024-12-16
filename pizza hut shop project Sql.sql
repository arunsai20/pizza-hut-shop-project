 create database pizzahut;
create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null ,
primary key(order_details_id));


 ---- toatal nubers of orders placed .
 
 select count(order_id)as total_orders from orders;
 
 -- calculate the total revenue generated from pizza sales.

select 
round(sum(order_details.quantity* pizzas.price),2)as total_sales 
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- identify the highest priced pizza--

select pizza_types.name,pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
  order by pizzas.price desc limit 1;
  
  
  -- list the top 5 most ordered pizza types along with their quantaties.

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;


-- join the necessary tables to find the -- total quantity of each pizza catagory ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- determine the distribution of orders by hour of the day.

select hour(time) as hour, count(order_id) as order_count from orders
group by hour (time);

-- join relevent tables to find the category wise distribution of pizzas 

select category , count(name) from pizza_types
group by category;

-- identify the most common pizza size ordered .

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;

-- group the orders by date and calculate the average number of pizzas ordered per  day .


select round(avg( quantity),0) as  avg_pizza_ordered_per_day from
(select orders.date,sum(order_details.quantity)as quantity 
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.date)as order_quantity ;


-- determine the top three most ordered pizza types  based on the revenue .

select pizza_types.name, 
sum(order_details.quantity * pizzas.price )as revenue 
from pizza_types join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id 
group by pizza_types.name order by revenue desc limit 3 ;



----------     --------     --------    ------------ 







  
  