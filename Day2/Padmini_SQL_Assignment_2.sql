
/* 1. Alter Table */

-- Add new column linkedin_profile
SELECT * from employees

ALTER TABLE employees
ADD linkedin_profile VARCHAR(80);

--Change column data type from VARCHAR to TEXT
ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;

-- Add unique to linkedin_profile
ALTER TABLE employees
ADD CONSTRAINT linkedinUnique UNIQUE (linkedin_profile);

-- Update null value to SQLLINK & Add not null constraint to linkedin_profile
UPDATE employees
SET linkedin_profile = 'SQLLink'
WHERE linkedin_profile IS NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;


-- Drop column linkedin_profile
ALTER TABLE employees
DROP COLUMN linkedin_profile;


/* 2. Querying (Select) */
--  Retrieve FirstName, LastName and title of all employees
SELECT
  split_part(employeeName, ' ', 1) AS first_name,
  split_part(employeeName, ' ', 2) AS last_name,
  employeeName, title FROM employees;


-- Find unique unit prices of products
SELECT DISTINCT unitprice FROM products;
SELECT * from products

-- List all customers sorted by company name in ascending order
SELECT * FROM customers
ORDER BY companyname ASC;

-- Display product name and unit price 
-- Rename the unit_price column as price_in_usd
SELECT productname, unitprice AS price_in_usd
FROM products;

/* 3. Filtering */
-- Get all customers from Germany
SELECT * FROM customers
WHERE country = 'Germany';

-- Find all customers from France or Spain
SELECT * FROM customers
WHERE country IN ('France', 'Spain');

-- Retrieve all orders placed in 1997
-- Freight greater than 50 or the shipped date is not null
SELECT * FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 2014
  AND (freight > 50 OR shippeddate IS NOT NULL);

/* 4. Filtering  */
-- Retrieve the productid, productname, and unitprice of products where the unitprice is greater than 15
SELECT productid, productname, unitprice FROM products
WHERE unitprice > 15;


-- List all USA employees and have the title "Sales Representative
SELECT * FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative'

-- Retrieve all products that are not discontinued and priced greater than 30
SELECT * FROM products
WHERE discontinued = FALSE
AND unitprice > 30;

/* 5. LIMIT or FETCH */
-- Retrieve the first 10 orders from the orders table
SELECT * FROM orders LIMIT 10;

-- Retrieve orders starting from the 11th order, fetching 10 rows
SELECT * FROM orders LIMIT 10 OFFSET 10;

/* 6. Filtering (IN, BETWEEN) */
-- List all customers who are either Sales Representative, Owner
SELECT * FROM customers 
WHERE contacttitle IN ('Sales Representative', 'Owner');

-- Retrieve orders placed between January 1, 2013, and December 31, 2013
SELECT * FROM orders
WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

/* 7. Filtering */
--List all products whose category_id is not 1, 2, or 3
SELECT * FROM products
WHERE categoryid NOT IN (1, 2, 3)

--Find customers whose company name starts with "A"
SELECT * FROM customers
WHERE companyname LIKE 'A%'

/* 8. INSERT into orders table */
-- Add a new order to the orders table with the following details
INSERT INTO orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);

/* 9. Increase(Update) */
-- the unit price of all products in category_id =2 by 10%.
UPDATE products SET unitprice = unitprice * 1.10
WHERE categoryid = 2;

/* 10. Sample Northwind database: Download */
-- Completed
