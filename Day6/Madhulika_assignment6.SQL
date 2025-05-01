--1--      Categorize products by stock status
--(Display product_name, a new column stock_status whose values are based on below condition
 --units_in_stock = 0  is 'Out of Stock'
       --units_in_stock < 20  is 'Low Stock')

select product_name,
       units_in_stock AS "stock status",
CASE
       when units_in_stock = 0 then 'Out of Stock'
	   when units_in_stock < 20 then 'Low Stock'
ELSE
       'Available'
END AS 	"stock status"
From products
Order By units_in_stock;

--2---Find All Products in Beverages Category
--(Subquery, Display product_name,unitprice)

select product_name, unit_price from products
       where category_id = (select category_id from categories where category_name = 'Beverages')
	   

--3--Find Orders by Employee with Most Sales 

--(Display order_id,   order_date,  freight, employee_id. 

--Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery) 

select "order_id", "order_date", "freight", "employee_id"
From orders
     where "employee_id" = (select "employee_id" From orders
	                         Group By "employee_id"
							 Order By count("order_id") DESC
							 limit 1
   
);

--4---Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators) 

SELECT "order_id", "order_date", "freight", "ship_country"
FROM "orders"
WHERE "ship_country" != 'USA' AND "freight" > ALL (
   SELECT "freight"
   FROM "orders"
   WHERE "ship_country" = 'USA');