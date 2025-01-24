-- Databricks notebook source

CREATE TABLE product(
 product varchar(15) ,
 amount int ,
 country varchar(10) 
) 
;
INSERT into product VALUES ('banana', 1000, 'usa');
INSERT into product VALUES ('carrots', 1500, 'usa');
INSERT into product VALUES ('beans', 1600, 'usa');
INSERT into product VALUES ('orange', 2000, 'usa');
INSERT into product VALUES ('banana', 400, 'china');
INSERT into product VALUES ('carrots', 1200, 'china');
INSERT into product VALUES ('beans', 1500, 'china');
INSERT into product VALUES ('orange', 4000, 'china');
INSERT into product VALUES ('banana', 2000, 'canada');
INSERT into product VALUES ('carrots', 2000, 'canada');
INSERT into product VALUES ('beans', 2000, 'mexico');

-- COMMAND ----------

select * from product;

-- COMMAND ----------

select country,
max(case when product = 'banana' then amount end) as banana,
max(case when product = 'carrots' then amount end) as carrots,
max(case when product = 'orange' then amount end) as orange,
max(case when product = 'beans' then amount end) as beans
from product
group by country

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Using pivot() function

-- COMMAND ----------

select product, from product
pivot(
max(amount)
from product

)
