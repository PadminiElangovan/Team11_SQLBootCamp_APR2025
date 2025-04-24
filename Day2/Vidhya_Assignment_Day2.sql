--Q1-----
ALTER TABLE employees ADD linkedin_profile VARCHAR(200);
ALTER TABLE employees ALTER COLUMN linkedin_profile TYPE TEXT;
ALTER TABLE employees ADD CONSTRAINT linkedinUnique UNIQUE (linkedin_profile);
Select * from employees;
UPDATE employees 
SET linkedin_profile = 'https://www.linkedin.com/in/v' || employeeID::text 
WHERE linkedin_profile IS NULL;
ALTER TABLE employees ALTER COLUMN linkedin_profile SET NOT NULL;
ALTER TABLE employees DROP COLUMN linkedin_profile;

-----Q2-----------
SELECT employeeName, title FROM employees;
SELECT DISTINCT unitprice FROM products;
SELECT companyName FROM customers ORDER BY companyName ASC;
SELECT productName, unitprice AS price_in_usd FROM products;

----Q3------
SELECT * FROM customers WHERE country = 'Germany';
SELECT *  FROM customers WHERE country IN ('France', 'Spain');
SELECT * FROM orders WHERE EXTRACT(YEAR FROM orderdate) = 2014
AND (freight > 50 OR shippedDate IS NOT NULL);

----Q4-----------
SELECT productid, productname, unitprice FROM products WHERE unitprice > 15;
SELECT employeeName, title FROM employees WHERE country = 'USA' AND title = 'Sales Representative';
SELECT * FROM products WHERE discontinued = FALSE AND unitprice > 30;

---------Q5---------
SELECT * FROM orders ORDER BY orderid LIMIT 10;
SELECT * FROM orders ORDER BY orderid OFFSET 10 LIMIT 10;

--------Q6----------
SELECT * FROM customers WHERE contactTitle IN ('Sales Representative', 'Owner');
SELECT * FROM orders WHERE orderdate BETWEEN '2013-01-01' AND '2013-12-31';

--------Q7 ---------
SELECT * FROM products WHERE categoryid NOT IN (1, 2, 3);
SELECT * FROM customers WHERE companyName LIKE 'A%';

-----Q8------------
INSERT INTO orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);

-----------Q9-------
UPDATE products SET unitprice = unitprice * 1.10 WHERE categoryid = 2;





















