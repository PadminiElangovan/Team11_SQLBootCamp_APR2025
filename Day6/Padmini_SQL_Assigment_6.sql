---------------------------- DAY 6 ------------------------------------

-- 1. Categorize products by stock status 

SELECT product_name,
CASE
	WHEN units_in_stock = 0 THEN 'Out of Stock'
	WHEN units_in_stock < 20 THEN 'Low Stock'
ELSE 'Available'
END AS stock_status
FROM products
ORDER BY stock_status;
 
-- 2. Find All Products in Beverages Category (Subquery, Display product_name,unitprice)

SELECT product_name, unit_price
FROM products
WHERE category_id = (
	SELECT category_id 
	FROM categories
	WHERE category_name = 'Beverages');
 
-- 3. Find Orders by Employee with Most Sales

SELECT order_id, order_date, freight, employee_id
FROM orders
WHERE employee_id = (
	SELECT employee_id
	FROM orders
	GROUP BY employee_id
	ORDER BY COUNT (*) DESC
	LIMIT 1);
 
-- 4. Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)

SELECT order_id, order_date, freight, ship_country
FROM orders
WHERE ship_country != 'USA' AND freight > ALL (
   SELECT freight
   FROM orders
   WHERE ship_country = 'USA');

SELECT order_id, order_date, freight, ship_country
FROM orders
WHERE ship_country != 'USA' AND freight > ANY (
   SELECT freight
   FROM orders
   WHERE ship_country = 'USA');
