
/* 1.Update the categoryName From “Beverages” to "Drinks" in the categories table*/

update categories
set categoryname='Drinks'
where categoryname='Beverages'

/* 2. Insert into shipper new record (give any values) Delete that new record from shippers table. */
insert into shippers(shipperid,company_name)
values ('4','Amazon Shipping')

delete from shippers
where shipperid=4

select * from shippers

/* 3. Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products
*/

alter table products
drop constraint if exists products_categoryid_fkey

alter table products
add constraint products_categoryid_fkey
foreign key (categoryid)
references categories(categoryid)
on update cascade
on delete cascade


update categories
set categoryid=1001
where categoryid=1

select * from products
where categoryid=1001


delete from categories
where categoryid=3

select * from categories where categoryid=3
select * from products where categoryid=3

/* 4.Delete the customer = “VINET”  from customers. 
Corresponding customers in orders table should be set to null */

alter table orders
drop constraint if exists orders_customerid_fkey

alter table orders
add constraint orders_customerid_fkey
foreign key (customerid)
references customers(customerid)
on delete set null

delete from customers
where customerid='VINET'

select * from customers where customerid='VINET'
select * from orders where customerid='VINET'

/* 5. Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
*/

select * from products

create table products_new
(
productid int primary key,
productname varchar not null,
quantityperunit varchar not null,
unitprice numeric not null,
discontinued int check (discontinued in (0,1)),
categoryid int not null,
foreign key (categoryid) references categories_new(categoryid)
)

alter table products_new
drop constraints if exists products_new_categoryid_fkey

alter table products_new
add constraint products_new_categoryid_fkey
foreign key (categoryid)
references categories_new(categoryid)
on update cascade
on delete cascade


create table categories_new
(
categoryid int primary key,
categoryname varchar not null,
description text not null
)

insert into products_new
values (100,'Wheat bread','1',13,0,3),
(101,'White bread','5 boxes',13,0,3),
(100,'Wheat bread','10 boxes',13,0,3)
on conflict (productid)
do update
set categoryid=excluded.categoryid,
productname=excluded.productname,
    quantityperunit=excluded.quantityperunit,
    unitprice=excluded.unitprice,
	discontinued=excluded.discontinued
	
select * from products_new

/*6)      Write a MERGE query:and insert values as below 

-Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
-If there are matching products and updated_products .discontinued =1 then delete  
-Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.*/

merge into products_new p
using
(
values(100,'Wheat bread','10',20,1,3),
(101,'White bread','5 boxes',19.99,0,3),
(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2)
) as updated_products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
on p.productid = updated_products.productid
when matched and updated_products.discontinued=0
then
update set
unitprice=updated_products.unitprice,
discontinued=updated_products.discontinued
when matched and updated_products.discontinued=1
then
delete 
when not matched and updated_products.discontinued=0
then
insert (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
values(updated_products.productid,updated_products.productname,updated_products.quantityperunit,
updated_products.unitprice,updated_products.discontinued,updated_products.categoryid)

select * from products_new

/* 7.List all orders with employee full names. (Inner join)  */

select e.employee_id,order_id,order_date,first_name || ''||last_name as Full_name
from employees e
inner join orders o
on e.employee_id=o.employee_id
