 /*q1. Update the categoryName From “Beverages” to "Drinks" in the categories table.*/
update categories set category_name ='Drinks' where category_name = 'Beverages';

select * from categories;
-----------------------------------------------
/* q2. Insert into shipper new record (give any values) Delete that new record from shippers table.*/
select * from shippers;
insert into shippers (shipper_id, company_name, phone) values(7, 'USPS', 1234567890);

delete from shippers where shipper_id=7;
-----------------------------------------------
/*q3.Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)*/

 alter table products drop constraint if exists fk_products_categoryid_fkey;

ALTER TABLE products
DROP CONSTRAINT fk_products_categories;

 alter table products 
 add constraint products_category_id_fk
 foreign key (category_id)
 references categories(category_id)
 on update cascade
 on delete cascade;

 update categories
set category_id=1001
where category_id=1;

select * from categories;
-------------------------------
/*q4.  Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL

)*/
alter table orders
drop constraint if exists orders_customerid_fkey;
ALTER TABLE orders
DROP CONSTRAINT fk_orders_customers;

alter table orders
add constraint orders_customerid_fkey
foreign key (customer_id)
references customers(customer_id)
on delete set null

delete from customers
where customer_id='VINET'

select * from customers where customer_id='VINET';
select * from orders where customer_id='VINET';
------------------------------------


/*Q5.     Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)*/
insert into products (product_id, product_name, quantity_per_unit,unit_price,discontinued,category_id)
values (100,'Wheat bread',1,13,0,5),
(101,'White bread',5,13,0,5)

on conflict (product_id)
do update 
set product_name = EXCLUDED.product_name,
quantity_per_unit=EXCLUDED.quantity_per_unit,
unit_price= excluded.unit_price,
discontinued= excluded.discontinued,
category_id = excluded.category_id;

insert into products  (product_id, product_name, quantity_per_unit,unit_price, discontinued, category_id)
values (100,'White bread',10,13, 0,5)
on conflict (product_id)
do update 
set product_name = excluded. product_name,
quantity_per_unit =excluded. quantity_per_unit,
unit_price = excluded.unit_price,
discontinued = excluded.discontinued,
category_id = excluded.category_id;
select * from products where product_id =100 or product_id= 101 ;
----------------------------------
/* Q6.
CREATE TEMP TABLE updated_products (
    productID INT PRIMARY KEY,
    productName VARCHAR(50),
    quantityPerUnit VARCHAR(50),
    unitPrice NUMERIC(8,2),
    discontinued int,
    categoryID INT
);

INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
  (100, 'Wheat bread', '10', 20, 1, 5),
  (101, 'White bread', '5 boxes', 19.99, 0, 5),
  (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1001),
  (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);

MERGE INTO products AS actual
USING updated_products AS temp
ON actual.product_id = temp.productID
WHEN MATCHED AND temp.discontinued = 0 THEN
    UPDATE SET 
        unit_price = temp.unitPrice,
        discontinued = temp.discontinued
WHEN MATCHED AND temp.discontinued = 1 THEN
    DELETE WHEN NOT MATCHED AND temp.discontinued = 0 THEN
    INSERT (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
    VALUES (temp.productID, temp.productName, temp.quantityPerUnit, temp.unitPrice, temp.discontinued, temp.categoryID);

