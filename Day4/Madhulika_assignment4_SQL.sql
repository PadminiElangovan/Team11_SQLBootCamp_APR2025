--1-- List all customers and the products they ordered with the order date. 

select 
c."contactName" AS customerName,
o."orderID",
od."quantity",
o."orderDate",
p."productName"
from 
"customers" c Inner Join "orders" o
ON c."customerID" = o."customerID"
Inner Join "order_details" od
ON o."orderID" = od."orderID"
Inner Join "products" p
ON od."productID" = p."productID";

--2--Show each order with customer, employee, shipper, and product info — even if some parts are missing.

select
o."orderID",
c."customerID",
e."employeeID",
s."shipperID",
p."productName"
From "orders" o
Left Join "customers" c
ON o."customerID" = c. "customerID"
Join "employees" e
ON o."employeeID" = e."employeeID"
Join "shippers" s
ON o."shipperID" = s."shipperID"
Join "order_details" od
ON o."orderID" = od."orderID"
Join "products" p
ON od."productID" = p."productID";

--3--Show all order details and products (include all products even if they were never ordered).
select
 od."orderID",
 od."productID",
 od."quantity",
 p."productName"
From "order_details" od
Right Join "products" p
ON od."productID" = p."productID";

--4--List all product categories and their products

select
 ct."categoryID",
 p."productID"
 From "Categories" ct 
 Full Outer Join "products" p
 ON ct."categoryID" = p."categoryID";

--5--Show all possible product and category combinations.

select * From "products" p 
Cross Join "Categories" ct;

--6--Show all employees and their manager

select
 e."employeeID",
 e."employeeName",
 r."reportsTo"
 From Employee e
 Self Join Employee r
 ON e.employeeID = r.

--7--Show all employees and their manager

select e."employeeID", e."employeeName", e."reportsTo", r."employeeName" as "Maneger" 
from Employees e Left join Employees r on e."reportsTo" = r."employeeID";

--List all customers who have not selected a shipping method.

select 
 c."customerID",
 o."shipperID"
 From "customers" c Left Join "orders" o
 ON c."customerID" = o."customerID"
 where o."shipperID" IS NULL;


 






