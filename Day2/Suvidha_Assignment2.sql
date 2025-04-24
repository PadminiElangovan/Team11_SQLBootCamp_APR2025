
/** 1.Alter Table **/

alter table employees
add column linkedin_profile varchar;

alter table if exists employees
alter column linkedin_profile
set data type text; 

alter table employees
add constraint linkedin_unique unique(linkedin_profile)

alter table employees
alter column linkedin_profile
set not null 

alter table employees
drop column linkedin_profile

/** 2.Querying (Select) **/

select  split_part(employeename,' ',1)as first_name,
split_part(employeename,' ',2) as last_name, title
from employees

select distinct unitprice from products

select * from customers
order by companyname asc

select productname, unitprice as price_in_USD
from products

/** 3.Filtering **/

select * from customers
where country='Germany'

select * from customers
where country='France'
or country ='Spain'

select * from orders
where extract(year from orderdate)='1997'
and freight>50
or shippeddate is not null

/** 4.Filtering **/

select productid,productname,unitprice
from products
where unitprice>15

select * from employees
where country='USA'
and title ='Sales Representative'

select * from products
where discontinued=1
and unitprice>30

/** 5.LIMIT/FETCH **/

select * from orders
fetch first 10 rows only

select * from orders
fetch first 10 rows only
offset 10

/**  6.Filtering (IN, BETWEEN) **/

select * from customers
where contacttitle like 'Sales%'
or contacttitle like 'Owner%'

select * from orders
where orderdate between '2013-01-01' and '2013-12-31'
order by orderdate asc

/** 7. Filtering */

select * from products
where categoryid not in (1,2,3)

select * from customers
where companyname like 'A%'

/**  INSERT into orders table **/

insert into orders
values ('11078','ALFKI','5','2025-04-23','2025-04-30','2025-04-25','2','45.50' )

select * from orders
where orderid=11078

/** 9. **/

update products
set unitprice= unitprice*1.10
where categoryid=2

