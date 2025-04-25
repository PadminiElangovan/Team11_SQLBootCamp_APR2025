1./* Update the categoryName From “Beverages” to "Drinks" in the categories table.*/

Select * from categories;

UPDATE categories 
SET categoryName='Drinks'
WHERE categoryName='Beverages';
-----------------------------------------------------------------------------------------------
2./* Insert into shipper new record (give any values) Delete that new record from shippers table.*/
select * from shippers;
insert into shippers values('4','ups');
delete from shippers where shipperid='4';
-----------------------------------------------------------------------------------------------

3./*Update categoryID=1 to categoryID=1001. Make sure related products update 
their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records
 are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)*/
select *from categories;

alter table products
drop constraint if exists products_categoryid_fkey;

alter table products
add constraint products_categoryid_fkey
foreign key(categoryID)
REFERENCES categories(categoryID)
on update cascade
on delete cascade

update categories set categoryID='1001' where categoryID='1';
select * from categories;
select * from products;

ALTER TABLE order_details
DROP CONSTRAINT order_details_productid_fkey;

alter table order_details
add constraint order_details_productid_fkey
foreign key(productID)
REFERENCES products(productID)
ON UPDATE CASCADE
ON DELETE CASCADE

select * from order_details;

DELETE FROM categories WHERE categoryID='3';

------------------------------------------------------------------------------
4./*  Delete the customer = “VINET”  from customers. Corresponding customers 
in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) 
to use ON DELETE SET NULL)
*/
alter table orders
drop constraint if exists orders_customerid_fkey;

alter table orders
add constraint orders_customerid_fkey
foreign key(customerID)
REFERENCES customers(customerID)
on update cascade
on delete set null
select * from orders where customerID is NULL;
select * from customers where customerid='VINET';
delete from customers where customerid='VINET';
select * from customers;
select * from orders;
select * from orders  where customerid='VINET';
-------------------------------------------------------------------------------------------------
5./*Insert the following data to Products using UPSERT:*/

select * from products;
select * from products where productid=100;
1./*product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, 
discontinued = 0, categoryID=5
*/
insert into products values('100','wheatbread','1','13','0','5')
ON CONFLICT (productid)
DO UPDATE
SET productName=EXCLUDED.productName,
    quantityPerUnit=EXCLUDED.quantityPerUnit,
	price_in_usd=EXCLUDED.price_in_usd,
	discontinued=EXCLUDED.discontinued,
	categoryID=EXCLUDED.categoryID;
2./*product_id = 101, product_name = White bread, quantityperunit=5 boxes
,unitprice = 13, discontinued = 0, categoryID=5*/

insert into products values('101','whitebread','5','13','0','5')
ON CONFLICT (productid)
DO UPDATE
SET productName=EXCLUDED.productName,
    quantityPerUnit=EXCLUDED.quantityPerUnit,
	price_in_usd=EXCLUDED.price_in_usd,
	discontinued=EXCLUDED.discontinued,
	categoryID=EXCLUDED.categoryID;

3./*product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,
unitprice = 13, discontinued = 0, categoryID=5*/
insert into products values('100','wheatbread','10','13','0','5')
ON CONFLICT (productid)
DO UPDATE
SET productName=EXCLUDED.productName,
    quantityPerUnit=EXCLUDED.quantityPerUnit,
	price_in_usd=EXCLUDED.price_in_usd,
	discontinued=EXCLUDED.discontinued,
	categoryID=EXCLUDED.categoryID;
select * from products;
------------------------------------------------------------------------------------------------
6./*  Write a MERGE query:*/
create table updated_products
(
productID INT PRIMARY KEY,
productName VARCHAR(50) NOT NULL,
quantityPerUnit VARCHAR(50) NOT NULL,
unitPrice NUMERIC(8, 2) NOT NULL,
discontinued BOOLEAN NOT NULL,
categoryID INT
);
alter table updated_products rename column unitPrice to price_in_usd;
select * from updated_products;
INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '10', 20, true, 3),
   	   (101, 'White bread', '5 boxes', 19.99, false, 3),
       (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, false, 1),
       (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, false, 2);

/* Update the price and discontinued status for from below table ‘updated_products’ 
only if there are matching products and updated_products .discontinued =0 */
select * from products;
MERGE INTO products p

USING updated_products u

ON p.productid = u.productid

WHEN MATCHED AND u.discontinued = 'FALSE' THEN

UPDATE SET

price_in_usd = u.price_in_usd,

discontinued = u.discontinued

WHEN MATCHED AND u.discontinued = 'TRUE' THEN

DELETE

WHEN NOT MATCHED AND u.discontinued = 'FALSE' THEN

INSERT (productID, productName, quantityPerUnit, price_in_usd, discontinued, categoryID)

VALUES (u.productID, u.productName, u.quantityPerUnit, u.price_in_usd, u.discontinued, u.categoryID);
	   