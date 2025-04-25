
/* Day 3 Assignment */
-- 1. Update the categoryName From “Beverages” to "Drinks" in the categories table
SELECT * FROM categories

UPDATE categories SET categoryName = 'Drinks'
WHERE categoryName = 'Beverages';

-- 2. Insert into shipper new record (give any values) Delete that new record from shippers table
SELECT * FROM shippers

INSERT INTO shippers (shipperid, companyname)
VALUES (4, 'SQL Package');

-- 3. a:Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
SELECT * FROM products
SELECT * FROM categories


ALTER TABLE products
DROP CONSTRAINT products_categoryid_fkey; --Drop key

ALTER TABLE products 
ADD CONSTRAINT products_categoryid_fkey
FOREIGN KEY (categoryid)
REFERENCES categories(categoryid)
ON UPDATE CASCADE
ON DELETE CASCADE;  --Add key with cascade

UPDATE categories
SET categoryid = 1
WHERE categoryid = 1001; --Update 1 to 1001

--  b. Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
SELECT * FROM categories
SELECT * FROM order_details


ALTER TABLE order_details
DROP CONSTRAINT order_details_productid_fkey; -- Delete key from Products

ALTER TABLE order_details
ADD CONSTRAINT order_details_productid_fkey
FOREIGN KEY (productid)
REFERENCES products(productid)
ON UPDATE CASCADE
ON DELETE CASCADE; -- Add Key with cascade

DELETE FROM categories
WHERE categoryid = 3;

-- 4. Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
SELECT * FROM orders
SELECT * FROM customers

ALTER TABLE orders
DROP CONSTRAINT orders_customerid_fkey; --Delete key from orders

ALTER TABLE orders
ADD CONSTRAINT orders_customerid_fkey
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON UPDATE CASCADE
ON DELETE SET NULL;   --Add Key with cascade

DELETE FROM customers
WHERE customerid = 'VINET';

SELECT * FROM orders
WHERE customerid IS NULL;

-- 5) Insert the following data to Products using UPSERT:
--a. product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
SELECT * FROM products

INSERT INTO products ( productid, productname, quantityperunit, unitprice, discontinued, categoryid )
VALUES (100, 'Wheat bread', 1, 13, false, 5)

ON CONFLICT (productid) DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;

--b. product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
INSERT INTO products ( productid, productname, quantityperunit, unitprice, discontinued, categoryid )
VALUES (101, 'Wheat bread', 5, 13, false, 5)

--c. product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
INSERT INTO products ( productid, productname, quantityperunit, unitprice, discontinued, categoryid )
VALUES (100, 'Wheat bread', 10, 13, false, 5)
ON CONFLICT (productid) DO UPDATE
SET quantityperunit = EXCLUDED.quantityperunit;

-- 6.  Write a MERGE query: 
-- a. Create temp table with name:  ‘updated_products’ and insert values
CREATE TEMP TABLE updated_products (
    productid INT PRIMARY KEY,
    productname TEXT,
    quantityperunit TEXT,
    unitprice NUMERIC(10, 2),
    discontinued BOOLEAN,
    categoryid INT
);

SELECT * FROM updated_products
SELECT * FROM products

INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (100, 'Wheat bread', '10', 20, true, 3),
   	   (101, 'White bread', '5 boxes', 19.99, false, 3),
       (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, false, 1),
       (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, false, 2);

--b. •	 Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
MERGE INTO products p
USING updated_products u
ON p.productid = u.productid
WHEN MATCHED AND u.discontinued = 'FALSE' THEN
UPDATE SET
        unitprice = u.unitprice,
        discontinued = u.discontinued
WHEN MATCHED AND u.discontinued = 'TRUE' THEN
DELETE
WHEN NOT MATCHED AND u.discontinued = 'FALSE' THEN
INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);

-- 7. List all orders with employee full names. (Inner join)

SELECT * FROM employees
SELECT * FROM orders

SELECT o.order_id, e.first_name || ' ' || e.last_name AS employeefullname
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;
