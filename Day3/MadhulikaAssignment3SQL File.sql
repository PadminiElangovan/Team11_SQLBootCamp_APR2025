SELECT * FROM public."Categories"
ORDER BY "categoryID" ASC 

UPDATE public."Categories"
SET "categoryName" = 'Drinks'
where "categoryName" = 'Beverages';

insert into public."shippers"("shipperID","companyName") values ('4','Enstrap');
delete from public."shippers" where "shipperID" = '4';

update public."Categories"
SET "categoryID" = '1001'
where "categoryID" = '1';
SELECT * FROM public."Categories"
ORDER BY "categoryID" ASC 

update public."Categories"
SET "categoryID" = '1'
where "categoryID" = '1001';
SELECT * FROM public."Categories"
ORDER BY "categoryID" ASC 

alter table public."products"
add constraint "products_categoryID_fkey"
foreign key ("categoryID")
references "Categories"("categoryID")
on update cascade
on delete cascade;

--update public."Categories"
--SET "categoryID" = '1001'
--where "categoryID" = '1';

Delete from public."Categories"
where "categoryID" = '3';


SELECT * FROM public."Categories"
ORDER BY "categoryID" ASC 
SELECT * FROM public."products"
ORDER BY "categoryID" ASC 

alter table public."orders"
add constraint "orders_customerID_fkey"
foreign key ("customerID")
references "customers"("customerID")
on delete set null;

delete from public."customers"
where "customerID" = 'VINET';

SELECT * FROM public.orders
ORDER BY "orderID" ASC 

insert into public."products"("productID","productName","quantityPerUnit","unitPrice","discontinued","categoryID") values
(101,'Wheat bread','5 boxes',13,0,5)
on conflict("productID")DO UPDATE
SET "quantityPerUnit" = EXCLUDED."quantityPerUnit";

SELECT * FROM public."products"
ORDER BY "categoryID" ASC 

create  temp table updated_products("productID" int PRIMARY KEY,"ProductName" text,"quantityPerUnit" text,
"unitPrice" numeric(10,2),"discontinued" int,"categoryID" int);

drop table updated_products;

select * from updated_products;

create temp table updated_products("productID" int PRIMARY KEY,"ProductName" text,"quantityPerUnit" text,
"unitPrice" numeric(10,2),"discontinued" int,"categoryID" int);


insert into updated_products("productID","ProductName","quantityPerUnit","unitPrice","discontinued","categoryID" )
values(100,'Wheat bread',10,20,1,5),
       (101,'White bread','5 boxes',19.99,0,5),
	   (102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
	   (103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2);

select o."orderID",e."title" || '' || e."employeeName" AS employeefullname
from "orders" o
inner join "employees" e
on o."employeeID" = e."employeeID"; 
	   

	   







)

,

)















