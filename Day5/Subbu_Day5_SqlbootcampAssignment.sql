/*Q1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100 */

select extract(year from order_date) as order_year,
extract(quarter from order_date) as quarter,
count(*) as order_count,
avg(freight) as freight_cost
from orders
where freight>100 
group by extract(year from order_date),extract(quarter from order_date)
order by order_year,quarter
----------------

/*Q2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/

select ship_region, count(*), max (freight), min(freight)
from orders
group by ship_region
having count(*)>=5 and ship_region is not null
order by count(*) desc
-----------------------------

/*Q3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)*/
select title as employee_Designation
from employees
union
select contact_title as customer_Designation
from customers

select title as employee_Designation
from employees
union all
select contact_title as customer_Designation
from customers
---------------------------
/*Q4. Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

select category_id
from products
where units_in_stock >0
intersect
select category_id
from products
where discontinued =1
-----------------

/*Q5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)*/

select order_id from order_details
except
select order_id from order_details where discount !=0


