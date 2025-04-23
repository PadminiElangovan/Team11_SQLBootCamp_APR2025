create table Category
(
categoryID int primary key,
categoryName varchar(50) NOT NULL,
description TEXT
);

select * from Categories

insert into category values (1, 'Beverages','Soft drinks, coffees, teas, beers, and ales')


insert into category values (2,'Condiments','Sweet and savory sauces, relishes, spreads, and seasonings')
insert into category values (3,'Confections','Desserts, candies, and sweet breads')
insert into category values (4,'Dairy Products','Cheeses')
insert into category values (5,'Grains & Cereals','Breads, crackers, pasta, and cereal')
insert into category values (6,'Meat & Poultry','Prepared meats');
insert into category values (7,'Produce','Dried fruit and bean curd');
insert into category values (8,'Seafood','Seaweed and fish');


select * from Categories

create table customers(customerID varchar(5) primary key, 
companyName varchar(255) NOT NULL, 
contactName varchar(100) NOT NULL, 
contactTitle varchar(100) NOT NULL, 
city varchar(100) NOT NULL , 
country TEXT
);

select * from customers;




create table orders(orderid integer primary key NOT NULL,
customerID varchar(50) NOT NULL,
employeeID integer primary key not null,
orderDate date,
requiredDate date,
shippedDate date,
shipperID integer,
freight decimal(7,2));

select * from orders;


create table products(productID integer primary key not null,
productName text,
quantityPerUnit varchar(50),
unitPrice decimal(5,2),
discontinued boolean not null,
categoryID integer);

select * from products;

create table employees(employeeID integer primary key not null,
employeeName text,
title text,
city text,
country text,
reportsTo integer);

select * from employees;

CREATE TABLE shippers(
 shipperID INT PRIMARY KEY,
 companyName VARCHAR(50) NOT NULL
 );
 
 select * from shippers


 


drop table products;





