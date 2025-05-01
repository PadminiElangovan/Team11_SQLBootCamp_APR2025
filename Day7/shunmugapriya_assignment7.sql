1./*     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/
select * from orders;
select 
	employee_id,
	count(*)as total_sales,
	rank()OVER
		(order by count(*)DESC) as sales_rank	
from 
	orders
	group by
	employee_id;

-------------------------------------------------------------------------------------------------
2./* Compare current order's freight with previous and next order for 
each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/
select 
	order_id,
	customer_id,
	order_date,
	freight, 
lag(freight)over (partition by customer_id order by freight)as previous_order_freight,
freight-lag(freight)over(partition by customer_id order by freight)as next_order_freight
from orders;


select 
	order_id,
	customer_id,
	order_date,
	freight, 
lead(freight)over (partition by customer_id order by freight)as previous_order_freight,
freight-lead(freight)over(partition by customer_id order by freight)as next_order_freight
from orders;


------------------------------------------------------------------------------------------------------------
3./*    Show products and their price categories, product count 
in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count 
in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/
select * from products;
with 	
price_category as(
select
	category_id,
	unit_price,
	case
	when unit_price<20 Then'Low Price'
	when unit_price<50 Then 'Medium price'
ELSE 'High Price'
end as price_category 
From products
)
select price_category,
		count(*)as product_count,
		ROUND(AVG(unit_price)::numeric, 2) as avg_price
		from price_category
		group by price_category;
	