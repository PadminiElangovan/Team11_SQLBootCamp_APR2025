1.alter table employees add column linkedin_profile varchar(50) not null;

  alter table employees drop column linkedin_profile;

   alter table employees add column linkedin_profile varchar(50) not null;

   alter table employees alter column linkedin_profile type text;



2.select employeename,title from employees;
  
  select productname,unitprice from products;
  
  select contactname,companynamefrom customers order by companyname ASC;

   select productname,unitprice AS price_in_usd from products;


3.select contactname,country from customers where country='Germany';
 
   select contactname,country from customers where country='France' OR country='Spain';
   
   select orderid,orderdate,freight>50 from orders;

4.select productid,productname,unitprice from products where unitprice>50;

 select employeename,country,title from employees where country='USA' AND title='Sales Representative';



5. select orderid,customerid from orders limit 10;
   
   select orderid,customerid from orders offset 11 limit 10;

6.select contactname,contacttitle from customers where contacttitle in ('Sales Representative','Owner');

  select orderid,customerid,orderdate from orders where orderdate between '2013-01-01' and '2013-12-31';


7.select * from products where categoryid not in(1,2,3);

  select contactname,companyname from customers where companyname LIKE 'A%';



8,insert into orders(orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight)
values (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

9.update products set unitprice=unitprice*1.10 where categoryid=2;








