--------- Day3 --------
-------Q1-----------
UPDATE categories SET categoryName = 'Drinks' WHERE categoryName = 'Beverages';
SELECT * FROM categories;

----------Q2-----------
Select * from shippers;
Insert  into shippers values(4,'test');
Delete from shippers where companyname like 'test';
Select * from shippers where companyname like 'test'; 

--------- Q3------------
Select * from products;
ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (categoryID)
REFERENCES categories(categoryID)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE order_details
ADD CONSTRAINT fk_orderdetails_product
FOREIGN KEY (productID)
REFERENCES products(productID)
ON DELETE CASCADE;

-- PostgreSQL: See existing constraints in product
SELECT conname
FROM pg_constraint
WHERE conrelid = 'products'::regclass;

ALTER TABLE products DROP CONSTRAINT products_categoryid_fkey;
UPDATE categories SET categoryID = 1001 WHERE categoryID = 1;
Select * from products WHERE categoryID = 1001;
Select * from categories;

-- PostgreSQL: See existing constraints in order_details
SELECT conname
FROM pg_constraint
WHERE conrelid = 'order_details'::regclass;

ALTER TABLE order_details DROP CONSTRAINT order_details_productid_fkey;
DELETE FROM categories WHERE categoryID = 3;
Select * from products WHERE categoryID = 3;
Select * from categories;

----------Q4 -----------
SELECT conname
FROM pg_constraint
WHERE conrelid = 'orders'::regclass;

ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customerID)
REFERENCES customers(customerID)
ON DELETE SET NULL;

DELETE FROM customers WHERE customerID = 'VINET';
SELECT * FROM customers WHERE customerID = 'VINET';
SELECT * FROM orders WHERE customerID IS NULL;

------- Q5 -------------
INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
  (100, 'Wheat bread', '1', 13, FALSE, 5),
  (101, 'White bread', '5 boxes', 13, FALSE, 5)  
ON CONFLICT (productID)
DO UPDATE SET
  productName = EXCLUDED.productName,
  quantityPerUnit = EXCLUDED.quantityPerUnit,
  unitPrice = EXCLUDED.unitPrice,
  discontinued = EXCLUDED.discontinued,
  categoryID = EXCLUDED.categoryID;

INSERT INTO products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
 (100, 'Wheat bread', '10 boxes', 13, FALSE, 5) 
ON CONFLICT (productID)
DO UPDATE SET
  productName = EXCLUDED.productName,
  quantityPerUnit = EXCLUDED.quantityPerUnit,
  unitPrice = EXCLUDED.unitPrice,
  discontinued = EXCLUDED.discontinued,
  categoryID = EXCLUDED.categoryID;

----Q6----------------------

CREATE TEMP TABLE updated_products (
    productID INT PRIMARY KEY,
    productName VARCHAR(50),
    quantityPerUnit VARCHAR(50),
    unitPrice NUMERIC(8,2),
    discontinued BOOLEAN,
    categoryID INT
);

drop table updated_products;
INSERT INTO updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
VALUES 
  (100, 'Wheat bread', '10', 20, TRUE, 5),
  (101, 'White bread', '5 boxes', 19.99, FALSE, 5),
  (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, FALSE, 1001),
  (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, FALSE, 2);

MERGE INTO products AS actual
USING updated_products AS temp
ON actual.productID = temp.productID
WHEN MATCHED AND temp.discontinued = FALSE THEN
    UPDATE SET 
        unitPrice = temp.unitPrice,
        discontinued = temp.discontinued
WHEN MATCHED AND temp.discontinued = TRUE THEN
    DELETE WHEN NOT MATCHED AND temp.discontinued = FALSE THEN
    INSERT (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
    VALUES (temp.productID, temp.productName, temp.quantityPerUnit, temp.unitPrice, temp.discontinued, temp.categoryID);

Select * from products WHERE categoryID = 5;
Select * from categories;

-----------Q7----------- run from northwind db

SELECT * FROM employees;
SELECT * FROM orders;
SELECT o.order_id, e.first_name || ' ' || e.last_name AS employeefullname
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;








