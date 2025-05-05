--1-- Create AFTER UPDATE trigger to track product price changes
--Create product_price_audit table 

CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);
 -- Create a trigger function with the below logic:
 
CREATE OR REPLACE FUNCTION product_price_audit_function() 
RETURNS trigger AS $$
BEGIN
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

    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

-- Create a row level trigger for below event:

CREATE TRIGGER product_price_audit_trigger
AFTER UPDATE OF unit_price ON products
FOR EACH ROW 
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION product_price_audit_function();

-- Test the trigger by updating the product price by 10% to any one product_id.

UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 1;

select * from products WHERE product_id = 1 ;
select * from product_price_audit;

--2--Create stored procedure  using IN and INOUT parameters to assign tasks to employees
-- Create table employee_tasks

CREATE TABLE IF NOT EXISTS employee_tasks (
        task_id SERIAL PRIMARY KEY,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE DEFAULT CURRENT_DATE);

-- Create a Stored Procedure 

CREATE OR REPLACE PROCEDURE assign_task ( 
IN p_employee_id INT,
IN p_task_name VARCHAR(50),
INOUT p_task_count INT DEFAULT 0
) 
LANGUAGE plpgsql 
AS $$ 
BEGIN 
/* Insert employee_id, task_name  into employee_tasks */
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
	
/* Count total tasks for employee and put the total count into p_task_count */
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;
	
/* Raise NOTICE message: */
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %', 
        p_task_name, p_employee_id, p_task_count;
END;
$$;

--Call the Stored Procedure 

CALL assign_task(1, 'Review Reports');

-- You should see the entry in employee_tasks table. 

SELECT * FROM employee_tasks;




