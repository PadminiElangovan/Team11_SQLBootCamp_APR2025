--1--Display order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

select extract(year from "order_date") AS order_year, 
       extract(quarter from "order_date") AS quarter, count("order_id"), avg("freight") 
	   from "orders"
	   where "freight" > 100
	   GROUP BY extract(year from ("order_date")),
		        extract(quarter from "order_date")
       ORDER BY
	   order_year, quarter;
	   
--2--Display ship region, no of orders in each region, min and max freight cost
 --Filter regions where no of orders >= 5

 select ship_region, count(order_id), min(freight), max(freight)
 from orders
 Group By ship_region
 Having count(order_id) >= 5;

--3--Get all title designations across employees and customers 

select title AS DESIGNATION
From employees
UNION
select contact_title AS DESIGNATION
From customers;

--Use Union All----

select title AS DESIGNATION
From employees
UNION ALL
select contact_title AS DESIGNATION
From customers;

--4--Find categories that have both discontinued and in-stock products

SELECT category_id
FROM products
WHERE units_in_stock > 0
INTERSECT
SELECT category_id
FROM products
WHERE discontinued = 1
ORDER BY category_id

--5--Find orders that have no discounted items (Display the  order_id, EXCEPT)	 

select "order_id"
From "order_details"
EXCEPT
select "order_id"
From "order_details"
Where discount != 0
Order By order_id;


 
 

 
	   
	   

	   

