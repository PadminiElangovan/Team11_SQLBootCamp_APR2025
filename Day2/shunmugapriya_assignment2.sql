1.ALTER TABLE :-

select * from employees;
/*Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.*/

ALTER TABLE employees 
ADD COLUMN linkedin_profile varchar(30);

/*Change the linkedin_profile column data type from VARCHAR to TEXT*/

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE text;

/* Add unique, not null constraint to linkedin_profile*/

SELECT * FROM employees;
ALTER TABLE employees
ADD CONSTRAINT linkedin_profile UNIQUE(linkedin_profile);

/*Drop column linkedin_profile*/

ALTER TABLE employees
DROP COLUMN linkedin_profile;
--------------------------------------------------------------------------------------------------------
2.Querying (select):-
/*Retrieve the employee name and title of all employees*/
SELECT
   split_part(employeeName, ' ', 1) AS first_name,
   split_part(employeeName, ' ', 2) AS last_name,
   employeeName, title FROM employees;
  
/*Find all unique unit prices of products*/
 
select distinct 
unitPrice 
from products;

/*List all customers sorted by company name in ascending order*/

select * from customers order by companyName asc;

/*Display product name and unit price, but rename the unit_price column as price_in_usd*/

ALTER TABLE products rename column unitPrice to price_in_usd;
select * from products;
select  productname, price_in_usd from products;
-------------------------------------------------------------------------------------------------------
3. Filtering
select * from customers;
/*Get all customers from Germany*/

select * from customers where country='Germany';

/*Find all customers from France or Spain*/

select * from customers where country='France' OR country= 'Spain';
select * from orders;
/*Retrieve all orders placed in 2014(based on order_date), and either have freight 
greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))*/

SELECT * FROM orders
 WHERE EXTRACT(YEAR FROM orderdate) = 2014
   AND (freight > 50 OR shippeddate IS NOT NULL);


-----------------------------------------------------------------------------------------------------
4.FILTERING

select * from products;
 /*Retrieve the product_id, product_name, and unit_price of products 
 where the unit_price is greater than 15.*/
 
SELECT productID,productName,price_in_usd from products where price_in_usd>15;
select * from employees;

/*List all employees who are located in the USA and have the title "Sales Representative".*/

select * from employees where country='USA' AND title='Sales Representative';
select * from products;

/*Retrieve all products that are not discontinued and priced greater than 30.*/

select * from products where discontinued='1' AND price_in_usd>30;

-----------------------------------------------------------------------------------------------------
5.LIMIT/FETCH
select * from orders;
/* Retrieve the first 10 orders from the orders table*/

 SELECT * FROM orders LIMIT 10;
 
/* Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).*/

select * from orders OFFSET 9 limit 10;
select * from orders OFFSET 9 FETCH NEXT 10 ROWS ONLY;
--------------------------------------------------------------------
6.FILTERING(IN,BETWEEN)
select * from customers;
/*List all customers who are either Sales Representative, Owner*/

select * from customers where contacttitle IN('Sales Representative','Owner');

/*Retrieve orders placed between January 1, 2013, and December 31, 20*/

select * from orders where orderdate between '01-01-2013'AND '12-31-2013';
select * from orders;
-------------------------------------------------------------------------
7.FILTERING
select * from products;
/*List all products whose category_id is not 1, 2, or 3.*/

select * from products where categoryid not in('1','2','3');
select * from customers;
---------------------------------------------------------------------------------------------------------------
8. INSERT INTO ORDER TABLE
SELECT * FROM orders;
/*: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50
*/
INSERT INTO orders values('11080','ALFKI','5','2025-04-23','2025-04-30','2025-04-25','2','45.50');
INSERT INTO orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
 VALUES ('11079', 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);

/*  Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10)*/

select * from customers where companyname LIKE 'A%';
------------------------------------------------------------------------------------------------------------------
9./* 9. Increase(Update) */
 -- the unit price of all products in category_id =2 by 10%.
 select * from products;
 UPDATE products SET price_in_usd = price_in_usd* 1.10
 WHERE categoryid = 2;
 -------------------------------------------------------------------------------------------------------------
 10.Sample Northwind Database:Download completed