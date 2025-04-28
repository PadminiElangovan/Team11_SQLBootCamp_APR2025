/* Day 4 - Assignment */
-- 1.List all customers and the products they ordered with the order date --
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM products;

SELECT c.company_name AS customer,
o.order_id,
p.product_name,
od.quantity,
o.order_date
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON od.product_id = p.product_id;
I
-- 2. Show each order with customer, employee, shipper, and product info — even if some parts are missing LEFT JOIN
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM shippers;
SELECT * FROM products;
SELECT * FROM employees;
SELECT * FROM order_details;

SELECT o.order_id,
c.company_name AS customer,
e.first_name ||''|| e.last_name As employee_name,
s.company_name As shipper,
p.product_name, 
od.unit_price
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id;


-- 3. Show all order details and products (include all products even if they were never ordered) RIGHT JOIN

SELECT * FROM products;
SELECT * FROM order_details;

SELECT od.order_id,
od.product_id, 
od.quantity,
p.product_name
FROM order_details od
RIGHT JOIN products p ON od.product_id = p.product_id;

-- 4. List all product categories and their products — including categories that have no products, and products that are not assigned to any category
SELECT * FROM products;
SELECT * FROM categories;

SELECT c.category_name,
c.description,
p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id;

-- 5.  Show all possible product and category combinations (Cross join).
SELECT * FROM products;
SELECT * FROM categories;

SELECT p.product_name,
c.category_name
FROM products p
CROSS JOIN categories c;

-- 6.  Show all employees and their manager(Self join(left join))
SELECT * FROM employees;

SELECT e.first_name || ' ' || e.last_name AS employee_name,
 e1.first_name || ' ' || e1.last_name AS manager_name
FROM employees e
LEFT JOIN employees e1 ON e.reports_to = e1.employee_id;

-- 7. List all customers who have not selected a shipping method.
/*Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL) */

SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.customer_id,
c.company_name AS customer,
c.city,
o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;
