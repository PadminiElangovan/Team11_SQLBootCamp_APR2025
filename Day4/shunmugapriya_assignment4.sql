/*1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate
 */


select 
c.company_name as customer,
o.order_id,
p.product_name,
od.quantity, 
o.order_date
from customers c
inner join orders o ON c.customer_id=o.customer_id
inner join order_details od ON o.order_id=od.order_id
inner join products p ON od.product_id=p.product_id

----------------------------------------------------------------------------
2./*2.     Show each order with customer, employee, shipper, and product
info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers,
             order_details, products*/
	select 
	c.company_name as customer,
	e.first_name||''||e.last_name as employee,
	s.company_name as shippers,
	p.product_name,
	o.order_id,
	od.quantity
	from orders o
	left join customers c ON c.customer_id=o.customer_id
	left join employees e ON e.employee_id=o.employee_id
	left join shippers s ON o.ship_via=s.shipper_id
	left join order_details od ON o.order_id=od.order_id
	left join products p ON p.product_id=od.product_id;
 
select * from products;
select * from orders;
---------------------------------------------------------------------------------------------------------------
3./*   Show all order details and products (include all products even if they were never ordered).
(Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname
*/
select 
    od.order_id,
	p.product_id,
	od.quantity,
	p.product_name
	from order_details od
	right join products p ON p.product_id=od.product_id;
------------------------------------------------------------------------
4./*List all product categories and their products — including 
categories that have no products, and products that are not 
assigned to any category.(Outer Join)
Tables used: categories, products*/
select * from products;
select * from categories;
	select 
     p.product_id,
	 p.product_name,
	 p.category_id,
	 c.category_id,
	 c.category_name
	 from products p
	 full outer join categories c ON p.category_id=c.category_id;
-------------------------------------------------------------------------
5./*Show all possible product and category combinations 
(Cross join).*/
select p.product_id,p.product_name,c.category_id,c.category_name
from products p
cross join categories c;
-------------------------------------------------------------------------
6./*Show all employees and their manager(Self join(left join))*/
select * from employees;
select 
e1.first_name||''||e1.last_name as employee_name,
e2.first_name||''||e2.last_name as manager_name
from employees e1
left join employees e2 ON e1.reports_to=e2.employee_id;
------------------------------------------------------------------------------
7./*List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)*/

select c.customer_id,c.company_name AS customer,o.order_id,o.ship_via
from customers c
left join orders o on c.customer_id=o.customer_id
where o.ship_via is null;
---------------------------------------------------------------------------------------------- 