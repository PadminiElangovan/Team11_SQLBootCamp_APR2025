/* 1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

create or replace view vw_updatable_products
as 
select product_id,product_name,unit_price,
units_in_stock,discontinued
from products
where discontinued=0
with check option

update vw_updatable_products
set unit_price=unit_price * 1.1
where units_in_stock<10;

select * from vw_updatable_products


/* 2.Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/

begin;
update products
set unit_price=unit_price * 1.1
where category_id=1;

commit;

rollback;

select * from products
where category_id=1;

/* 3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description */

create or replace view vw_emp_details as 
select e.employee_id, concat(first_name,' ',last_name) as employee_name,
title,et.territory_id,territory_description,region_description
from employees e
inner join employee_territories et using(employee_id)
inner join territories t using(territory_id)
inner join region r using(region_id)

select * from vw_emp_details

/*4.     Create a recursive CTE based on Employee Hierarchy */

with recursive cte_employeeHierarchy as
(
select employee_id,first_name,last_name,reports_to,
0 as level
from employees e
where 
reports_to is null
union all
select e.employee_id,e.first_name,e.last_name,e.reports_to,
eh.level+1
from employees e
join cte_employeeHierarchy eh
on eh.employee_id=e.reports_to
)
select level,
employee_id,concat(first_name,' ',last_name)employee_name
from cte_employeeHierarchy