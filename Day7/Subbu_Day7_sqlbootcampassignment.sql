/*Q1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/
select e.employee_id, count(o.order_id),
rank()over(order by count(o.order_id) desc ) as Rank_employee
from employees e 
join orders o 
on e.employee_id = o.employee_id
group by e.employee_id
order by Rank_employee;
------------------------
/*Q2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/
select order_id, customer_id,order_date,freight,
lag(freight,1,freight) over (partition by customer_id order by order_date) as lag_value,
lead(freight,1,freight) over (partition by customer_id order by order_date) as lead_value,
case when freight > lag(freight) over (partition by customer_id order by order_date) then 'more than previous'
when freight < lag(freight) over (partition by customer_id order by order_date) then 'less than previous'
else 'no change'
end as lag_comparision,
lead(freight) over (partition by customer_id order by order_date) - freight as lead_difference,
case when (lead(freight,1,freight) over (partition by customer_id order by order_date) - freight)>0 then 'more Lead'
when (lead(freight,1,freight) over (partition by customer_id order by order_date) - freight)< 0 then 'less lead'
else 'no change' end as Lead_comparision
from orders
----------------------
/* Q3.     Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/
WITH categorized_products AS (
    SELECT category_id,product_id, product_name, unit_price,
        CASE 
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_category
    FROM products
	
)
SELECT category_id, price_category, COUNT(*) AS product_count,
ROUND(AVG(unit_price)::numeric, 2) AS avg_price
FROM categorized_products
GROUP BY category_id ,price_category
ORDER BY category_id;
