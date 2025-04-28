----- Day 4-----

---- Q1---------------
SELECT c.company_name AS customer,
o.order_id,
p.product_name,
d.quantity,
o.order_date
FROM orders o
INNER JOIN order_details d ON o.order_id = d.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN products p ON d.product_id = p.product_id;

----Q2------------------

SELECT o.order_id,
c.company_name AS customer,
e.first_name ||''|| e.last_name As employee_name,
s.company_name As shipper,
p.product_name, 
d.unit_price
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details d ON o.order_id = d.order_id
LEFT JOIN products p ON d.product_id = p.product_id;


----Q3------------------------
SELECT d.order_id,
d.product_id, 
d.quantity,
p.product_name
FROM order_details d
RIGHT JOIN products p ON d.product_id = p.product_id;

----Q4------------------------
SELECT c.category_name,
c.description,
p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id;

----Q5------------------------
SELECT p.product_name,
c.category_name
FROM products p
CROSS JOIN categories c;

----Q6------------------------
SELECT em.first_name || ' ' || em.last_name AS employee_name,
 e1.first_name || ' ' || e1.last_name AS manager_name
FROM employees em
LEFT JOIN employees e1 ON em.reports_to = e1.employee_id;

----Q7------------------------
SELECT c.customer_id,
c.company_name AS customer,
c.city,
os.order_id
FROM customers c
LEFT JOIN orders os ON c.customer_id = os.customer_id
WHERE os.ship_via IS NULL;
