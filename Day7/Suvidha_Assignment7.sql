/* 1. Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/

select employee_id, Total_sales,
rank() over(order by Total_sales desc)as sales_rank
from (
select employee_id,count(order_id)Total_sales
from customers c
inner join orders o
on o.customer_id=c.customer_id
group by employee_id
)


/**2. Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight) **/

select customer_id,order_id,order_date,freight,
lag(order_date) over(partition by customer_id order by order_date) as previous_days_order,
lead(order_date) over(partition by customer_id order by order_date) as next_days_order
from orders


/** 3.Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
*/

with cte_products_cat as
(
select product_name,count(product_id) product_count,avg(unit_price) avg_price,
case 
when unit_price < 20 then 'Low Price'
when unit_price < 50 then 'Medium Price'
else 'High Price'
end as price_category
from products
group by product_name,unit_price
)

select product_name,product_count,round(avg_price :: numeric,2)avg_price,price_category
from cte_products_cat
