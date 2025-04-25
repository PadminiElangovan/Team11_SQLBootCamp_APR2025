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

delete from categories where categoryID='3';
alter table categories
add constraint categoryID primary key 
ON delete cascade;
alter table categories
----------------------------------------------------------------------------------------------------
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

select * from customers where customerid='VINET';
delete from customers where customerid='VINET';
select * from customers;
select * from orders;
select * from orders  where customerid='VINET';
-------------------------------------------------------------------------------------------------
