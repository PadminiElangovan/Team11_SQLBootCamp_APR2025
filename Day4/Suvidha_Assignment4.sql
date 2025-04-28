/** 1.List all customers and the products they ordered with the order date  **/

select company_name as customer,
o.order_id,product_name,quantity,order_date
from orders o
inner join customers c
on c.customer_id=o.customer_id
inner join order_details od
on o.order_id=od.order_id
inner join products p
on od.product_id = p.product_id


/** 2.Show each order with customer, employee, shipper, and product info — even if some parts are missing.*/

select o.order_id,c.customer_id,c.company_name,first_name || ' '||last_name as Employee_name,shipper_id,
od.product_id,product_name
from orders o
left join customers c
on c.customer_id=o.customer_id
left join employees e
on e.employee_id=o.employee_id
left join shippers s
on s.shipper_id=o.ship_via
left join order_details od
on od.order_id=o.order_id
left join products p
on p.product_id=od.product_id

/**3.Show all order details and products (include all products even if they were never ordered)**/

select order_id,p.product_id,product_name, quantity
from order_details o
 right join products p
 on o.product_id=p.product_id

 /** 4.List all product categories and their products 
 — including categories that have no products, and products that are not assigned to any category*/

select c.category_id,category_name,product_id,product_name,unit_price
from products p
full outer join categories c
on c.category_id=p.category_id

/* 5.Show all possible product and category combinations */

select c.category_id,category_name,product_id,product_name,unit_price
from products p
cross join categories c

/*6. 	Show all employees and their manager */

select e1.first_name||' '||e1.last_name as e1, 
e2.first_name||' '||e2.last_name as e2
from 
employees e1
inner join employees e2
on e1.reports_to=e2.employee_id
where e1.employee_id != e2.employee_id

/** 7. 	List all customers who have not selected a shipping method **/

select order_id,o.customer_id,company_name,contact_name,ship_name
from customers c
left join orders o
on o.customer_id=c.customer_id
order by order_id
where ship_via is null

 