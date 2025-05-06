/*  2. Create stored procedure  using IN and INOUT parameters to assign tasks to employees*/

--creating table employee task

create table if not exists employee_tasks(
task_id serial primary key,
employee_id int,
task_name varchar(50),
assigned_date date default current_date
);

--creating procedure
create or replace procedure employee_tasks(
IN p_employee_id int,
IN p_task_name varchar(50),
INOUT p_task_count int default 0)

Language plpgsql
as $$
begin

insert into employee_tasks(employee_id,task_name)
values(p_employee_id,p_task_name);

select count(task_id) 
into p_task_count
from employee_tasks;

raise notice 'Task % assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;

end;
$$;


call employee_tasks(1,'Review Reports');
call employee_tasks(2,'Project Mangement');

select * from employee_tasks;


/* 1.  Create AFTER UPDATE trigger to track product price changes */

create table product_price_audit
(audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER);

select * from product_price_audit

--creating function
create or replace function track_product_price()
returns trigger as $$
begin
insert into  product_price_audit(
product_id,
product_name,
old_price,
new_price,
change_date,user_name)
values(
old.product_id,
OLD.product_name,
 OLD.unit_price,
 NEW.unit_price,
 CURRENT_TIMESTAMP,
 CURRENT_USER
);
return new;
end;
$$ language plpgsql;

--creating trigger

create or replace trigger after_price_update
after update of unit_price on products 
for each row
execute function track_product_price();

--updating the unit price by 10%
update products
set unit_price=unit_price * 1.10
where product_id=4;


select * from products
where product_id=4;

