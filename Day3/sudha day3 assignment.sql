1) Update the categoryName From “Beverages” to "Drinks" in the categories table.



update categories set category_name='Drinks' where category_id=1;

2) Insert into shipper new record (give any values) Delete that new record from shippers table.



insert into shippers(shipper_id,company_name,phone) values('7','usps','85652485');

   delete from shippers where shipper_id=7;


3.3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 (HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid) )





alter table products
  drop constraint if exists products_categoryid_fkey;

   ALTER TABLE products
    DROP CONSTRAINT fk_products_categories;

alter table products
add constraint products_category_id_fkey
foreign key (category_id)
references categories(category_id)
on update cascade
on delete cascade;


update categories set category_id=1001 where category_id=1;

select *from products where category_id=1001;
select* from Categories where category_id=1001;





4.4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)



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
