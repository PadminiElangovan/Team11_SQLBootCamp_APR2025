/* CREATING TABLE SHIPPERS */
create table 
(
shipperid int PRIMARY KEY,
company_name varchar
)

/* CREATING TABLE EMPLYOEES */

create table employees
(
employeeID int PRIMARY KEY,
employeeName varchar NOT NULL,
title varchar NOT NULL,
city varchar NOT NULL,
country varchar NOT NULL,
reportsTo int
)

/* CREATING TABLE CATEGORIES */

create table categories
(
categoryID int PRIMARY KEY,
categoryName varchar NOT NULL,
description text 
)

/*CREATING TABLE PRODUCTS */
create table products
(
productID INT PRIMARY KEY,
productName varchar NOT NULL,
quantityPerUnit VARCHAR NOT NULL,
unitPrice numeric NOT NULL,
discontinued int CHECK(discontinued in(0,1)),
categoryID int not null,
FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
)



/* CREATING TABLE CUSTOMERS */
create table customers
(
customerID varchar(50) PRIMARY KEY,
companyName varchar(100) NOT NULL,
contactName varchar(100) NOT NULL,
contactTitle VARCHAR NOT NULL,
city varchar NOT NULL,
country varchar(50) NOT NULL
)

/* CREATING TABLE ORDER DETAILS */
create table order_details
 (
orderid int,
productID int,
unitPrice numeric NOT NULL,
quantity int NOT NULL,
discount numeric NOT NULL,
PRIMARY KEY (orderid , productID)
)




/* CREATING TABLE ORDERS */
create table orders
(
orderID int primary key,
customerID varchar(50) REFERENCES customers(customerID),
employeeID int REFERENCES employees(employeeID),
orderDate date,
requiredDate date,
shippedDate date,
shipperID int REFERENCES shippers(shipperID),
freight numeric
)
