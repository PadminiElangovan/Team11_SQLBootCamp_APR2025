1. /* List all orders with employee full names. (Inner join)*/
select * from orders;
select * from employees;

select CONCAT(last_name,'',first_name)as full_name from employees;

select e.employee_id,order_id,
CONCAT(e.last_name,'',e.first_name)as full_name
FROM employees e
inner join orders o ON e.employee_id=o.employee_id;

