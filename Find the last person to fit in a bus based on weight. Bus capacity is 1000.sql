-- Databricks notebook source
create table passengers(
  person_id int,
  weight int
  )

-- COMMAND ----------

insert into passengers values (1,56),
(2,76),
(3,87),
(4,55),
(5,90)

-- COMMAND ----------

with weight_cte as (
select *,sum(weight) over(order by person_id) as running_weight from passengers
)
select * from weight_cte
where running_weight < 300
order by person_id desc
limit 1

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Find second highest weight person

-- COMMAND ----------

with wgt_cte as (
select *, dense_rank() over(order by weight desc) as running_weight from passengers
)
select * from wgt_cte
where running_weight = 2


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Find second highest weight person using QUALIFY functions

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.fs.ls('dbfs:/user/hive/warehouse/passengers')

-- COMMAND ----------

-- MAGIC %python
-- MAGIC df = spark.read.format("delta").load('dbfs:/user/hive/warehouse/passengers/')
-- MAGIC display(df)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC df.createTempView("vw_passengers")

-- COMMAND ----------

select *,
dense_rank() over (order by weight desc) as rnk 
from vw_passengers
qualify rnk = 2
