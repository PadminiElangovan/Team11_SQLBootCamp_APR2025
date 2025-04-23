-- create customers table with customerID as primary key
CREATE TABLE customers(
customerID VARCHAR(15) PRIMARY KEY,
companyName VARCHAR(50) NOT NULL, 
contactName VARCHAR(50) NOT NULL, 
contactTitle VARCHAR(50) NOT NULL, 
city VARCHAR(50),
country VARCHAR(50)
);

-- create categories table with categoryID as primary key
CREATE TABLE categories(
categoryID INT PRIMARY KEY,
categoryName VARCHAR(50) NOT NULL,
description TEXT
);

-- create employees table with employeeID as primary key
CREATE TABLE employees(
employeeID INT PRIMARY KEY,
employeeName VARCHAR(50) NOT NULL,
title VARCHAR(50) NOT NULL, 
city VARCHAR(50),
country VARCHAR(50),
reportsTo INT
);

-- create shippers table with shipperID as primary key
CREATE TABLE shippers(
shipperID INT PRIMARY KEY,
companyName VARCHAR(50) NOT NULL
);

-- create orders table with orderID as primary key,customerID, shipperID and employeeID as foreign key
CREATE TABLE orders(
orderID INT PRIMARY KEY,
customerID VARCHAR(15),
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

-- create products table with productID as primary key,categoryID as foreign key
CREATE TABLE products(
productID INT PRIMARY KEY,
productName VARCHAR(50) NOT NULL,
quantityPerUnit VARCHAR(50) NOT NULL,
unitPrice NUMERIC(8, 2) NOT NULL,
discontinued BOOLEAN NOT NULL,
categoryID INT, 
FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
);

-- create order_details table orderID and productID as foreign key
CREATE TABLE order_details(
orderID INT,
FOREIGN KEY (orderID) REFERENCES orders(orderID),
productID INT,
FOREIGN KEY (productID) REFERENCES products(productID),
unitPrice NUMERIC(8, 2) NOT NULL,
quantity INT NOT NULL,
discount NUMERIC(8, 2) NOT NULL
);

-- After importong csv files checking the total records
SELECT COUNT(*) FROM customers; 
SELECT COUNT(*) FROM categories; 
SELECT COUNT(*) FROM employees; 
SELECT COUNT(*) FROM orders; 
SELECT COUNT(*) FROM order_details; 
SELECT COUNT(*) FROM products; 
