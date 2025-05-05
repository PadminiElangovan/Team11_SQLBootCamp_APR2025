
/*1.      Create AFTER UPDATE trigger to track product price changes
 
·       Create product_price_audit table with below columns:
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
 
·       Create a trigger function with the below logic:
 
  INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
·       Create a row level trigger for below event:
          	AFTER UPDATE OF unit_price ON products
 
·        Test the trigger by updating the product price by 10% to any one product_id.*/

    Create table product_price_audit (
	audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER);

 create function Price_change_track ()
 returns trigger as $$
 begin
 insert into product_price_audit(product_id,product_name,old_price,new_price)
 values(old.product_id,old.product_name,old.unit_price,new.unit_price);
 return new;
 end;
 $$ language plpgsql;

select * from product_price_audit;
 create trigger after_price_change
 after update of unit_price on products
 for each row
 execute function price_change_track();
 
select * from products where product_id =3;

 update products
 set Unit_price= unit_price*1.10
 where product_id = 3


/* Q2.      Create stored procedure  using IN and INOUT parameters to assign tasks to employees
 
·       Parameters:
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
 INOUT p_task_count INT DEFAULT 0
 
·       Inside Logic: Create table employee_tasks:
 CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
 
·       Insert employee_id, task_name  into employee_tasks
·       Count total tasks for employee and put the total count into p_task_count .
·       Raise NOTICE message:
 RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
 
 
After creating stored procedure test by calling  it:
 CALL assign_task(1, 'Review Reports');
 
You should see the entry in employee_tasks table.*/

create procedure track_task(
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
 INOUT p_task_count INT DEFAULT 0
)
language plpgsql
as $$
begin
 CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE
    );
	--select * from employees
INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);

	--select * from employee_tasks where employee_id =1
	select count(*) into p_task_count
	from employee_tasks where employee_id = p_employee_id ;

	RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$

call track_task(1,'sample')
