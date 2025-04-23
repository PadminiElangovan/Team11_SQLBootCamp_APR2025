CREATE TABLE categories(
categoryID INT PRIMARY KEY,
categoryName VARCHAR(50) NOT NULL,
description TEXT
);

Select * from categories

CREATE TABLE shippers(
shipperID INT PRIMARY KEY,
companyName VARCHAR(50) NOT NULL
);

Select * from shippers

CREATE TABLE employees(
employeeID INT PRIMARY KEY,
employeeName VARCHAR(50) NOT NULL,
title VARCHAR(50) NOT NULL, 
city VARCHAR(50),
country VARCHAR(50),
reportsTo INT
);

Select * from employees

CREATE TABLE customers(
customerID VARCHAR(10) PRIMARY KEY,
companyName VARCHAR(50) NOT NULL, 
contactName VARCHAR(50) NOT NULL, 
contactTitle VARCHAR(50) NOT NULL, 
city VARCHAR(50),
country VARCHAR(50)
);

Select * from customers

CREATE TABLE products(
productID INT PRIMARY KEY,
productName VARCHAR(50) NOT NULL,
quantityPerUnit VARCHAR(50) NOT NULL,
unitPrice NUMERIC(8, 2) NOT NULL,
discontinued BOOLEAN NOT NULL,
categoryID INT, 
FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

Select * from products

CREATE TABLE orders(
orderID INT PRIMARY KEY,
customerID VARCHAR(10),
FOREIGN KEY (customerID) REFERENCES customers(customerID),
employeeID INT,
FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,
shippedDate DATE,
shipperID INT,
FOREIGN KEY (shipperID) REFERENCES shippers(shipperID),
freight NUMERIC(8, 2) NOT NULL
);

Select * from orders

CREATE TABLE order_details(
orderID INT,
FOREIGN KEY (orderID) REFERENCES orders(orderID),
productID INT,
FOREIGN KEY (productID) REFERENCES products(productID),
unitPrice NUMERIC(8, 2) NOT NULL,
quantity INT NOT NULL,
discount NUMERIC(8, 2) NOT NULL
);
