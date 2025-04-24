--1)  --    Alter Table:
 --Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
--Change the linkedin_profile column data type from VARCHAR to TEXT.
 --Add unique, not null constraint to linkedin_profile
--Drop column linkedin_profile

alter table employees add linkedin_profile varchar;

alter table employees alter column linkedin_profile type text; 

alter table employees add constraints linkedinUnique UNIQUE (linkedin_profile)

alter table employees alter column linkedin_profile SET NOT NULL; 

UPDATE employees
SET linkedin_profile = 'SQLLink'
WHERE linkedin_profile IS NULL;

alter table employees alter column linkedin_profile SET NOT NULL; 

alter table employees drop column linkedin_profile;

--2--Retrieve the employee name and title of all employees
select employeeName, title from public.employees;

 --Find all unique unit prices of products
 select DISTINCT products.unitPricefrom public.products;
 
 --List all customers sorted by company name in ascending order
SELECT contactName FROM public.customers order by companyName ASC;

--Display product name and unit price, but rename the unit_price column as price_in_usd
 select productname, unitprice as price_in_usd from public.products;

--3--Filtering
--Get all customers from Germany.
select customerID from public.customers where country = 'Germany';

--Find all customers from France or Spain
select customerID from public.customers where country IN ('France' , 'Spain');

--Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
SELECT * FROM public.orders
WHERE EXTRACT(YEAR FROM orderdate) = 2014
  AND (freight > 50 OR shippeddate IS NOT NULL);

--4--Filtering
 --Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
 SELECT productid, productname, unitprice FROM public.products
WHERE unitprice > 15;

--List all employees who are located in the USA and have the title "Sales Representative".
SELECT * FROM public.employees
WHERE country = 'USA'
  AND title = 'Sales Representative'

--Retrieve all products that are not discontinued and priced greater than 30.
select productname from public.products where discontinued = false and unitprice >30;

--5--LIMIT/FETCH
 --Retrieve the first 10 orders from the orders table.
 select * from public.orders limit 10;
 
-- Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
 select * from public.orders offset 10 limit 10;
 
 --6Filtering (IN, BETWEEN) 
--List all customers who are either Sales Representative, Owner
select * from public.customers where contactTitle in('Sales Representative' , 'Owner');

--Retrieve orders placed between January 1, 2013, and December 31, 2013.
Select * from public.orders where orderdate between '1/1/2013' and '12/31/2013';

--7--Filtering
--List all products whose category_id is not 1, 2, or 3.
select * from public.products where categoryid not in (1,2,3);

--Find customers whose company name starts with "A".
select * from public.customers where companyname like 'A%';
 
 --8-- INSERT into orders table:
 --Task: Add a new order to the orders table with the following details:
--Order ID: 11078
--Customer ID: ALFKI
--Employee ID: 5
--Order Date: 2025-04-23
--Required Date: 2025-04-30
--Shipped Date: 2025-04-25
--shipperID:2
--Freight: 45.50

INSERT INTO public.orders (orderID, customerID, employeeID, orderDate, requiredDate, shippedDate, shipperID, freight)
VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);


 --9--Increase(Update)  the unit price of all products in category_id =2 by 10%.
--(HINT: unit_price =unit_price * 1.10)
UPDATE public.products SET unitprice = unitprice * 1.10
WHERE categoryid = 2;

--10-- Sample Northwind database:
--Download
 --Download northwind.sql from below link into your local. Sign in to Git first https://github.com/pthom/northwind_psql
 --Manually Create the database using pgAdmin:
 --Right-click on "Databases" → Create → Database
--Give name as ‘northwind’ (all small letters)
--Click ‘Save’

completed







 




  
  
  






