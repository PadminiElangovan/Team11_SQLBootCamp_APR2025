------------- DAY 4 SQL ASSIGNMENT ---------------

-- 1. GROUP BY with WHERE - Orders by Year and Quarter
/*Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100 */
SELECT * FROM orders;

SELECT
	EXTRACT(YEAR FROM ORDER_DATE) AS ORDER_YEAR,
	EXTRACT(QUARTER FROM ORDER_DATE) AS QUARTER,
	COUNT(*) AS ORDERCOUNT,
	AVG(FREIGHT) AS FREIGHT
FROM ORDERS
WHERE FREIGHT > 100
GROUP BY EXTRACT(YEAR FROM ORDER_DATE),
		 EXTRACT(QUARTER FROM ORDER_DATE)
ORDER BY
	ORDER_YEAR, QUARTER;

-- 2. GROUP BY with HAVING - High Volume Ship Regions
/*Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5 */
SELECT * FROM orders;

SELECT
	SHIP_REGION,
	COUNT(ORDER_ID) AS ORDER_COUNT,
	MIN(FREIGHT) AS MIN_FREIGHT,
	MAX(FREIGHT) AS MAX_FREIGHT
FROM ORDERS
GROUP BY SHIP_REGION
HAVING
	COUNT(ORDER_ID) >= 5  AND SHIP_REGION IS NOT NULL
ORDER BY ORDER_COUNT DESC
LIMIT 10;


-- 3. Get all title designations across employees and customers ( Try UNION & UNION ALL)
SELECT * FROM employees;
SELECT * FROM customers;

SELECT TITLE AS DESIGNATION
FROM EMPLOYEES
UNION
SELECT CONTACT_TITLE AS DESIGNATION
FROM CUSTOMERS;

SELECT TITLE AS DESIGNATION
FROM EMPLOYEES
UNION ALL
SELECT CONTACT_TITLE AS DESIGNATION
FROM CUSTOMERS;

-- 4. Find categories that have both discontinued and in-stock products
/*(Display category_id, instock means units_in_stock > 0, Intersect) */
SELECT * FROM products;

SELECT category_id
FROM products
WHERE units_in_stock > 0
INTERSECT
SELECT category_id
FROM products
WHERE discontinued = 1
ORDER BY category_id

-- 5. Find orders that have no discounted items (Display the  order_id, EXCEPT)
SELECT * FROM orders;
SELECT * FROM order_details;

SELECT order_id
FROM order_details
EXCEPT
SELECT order_id
FROM order_details
WHERE discount != 0
ORDER BY order_id;
