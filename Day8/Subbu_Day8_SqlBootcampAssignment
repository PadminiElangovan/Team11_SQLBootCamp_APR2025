/*Q1.     Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

create view vw_updatable_products as
select 
product_id,product_name, unit_price, units_in_stock, discontinued
from products
where discontinued =0 
with check option;

update vw_updatable_products
set unit_price=unit_price*1.1
where units_in_stock <10;

select * from vw_updatable_products where units_in_stock <10;
select * from products where discontinued = 0 and units_in_stock <10;

/*Q2.     Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/
select * from products where category_id=1;
begin;
update products
set unit_price =unit_price*1.1
where category_id =1;
select * from products where category_id=1;

rollback;
commit;
select * from products where category_id=1;

/*Q3.     Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description
*/

create view Employee_details as
select e.employee_id,
e.first_name ||' '|| e.last_name as employee_full_name,
e.title, t.territory_id,
t.territory_description,
r.region_description
from employees e 
join employee_territories et on e.employee_id= et.employee_id
join territories t on et.territory_id =t.territory_id
join region r on r.region_id =t.region_id

select * from Employee_details

/*Q4.     Create a recursive CTE based on Employee Hierarchy*/
with recursive cte_employee_hierarchy as(
select employee_id, first_name, last_name,reports_to,0 as level from employees e where reports_to is null
union all
select e.employee_id, e.first_name, e.last_name,e.reports_to,eh.level+1 from employees e 
join cte_employee_hierarchy eh on e.reports_to = eh.employee_id)
select level, employee_id, reports_to from cte_employee_hierarchy
