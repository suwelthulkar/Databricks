-- Databricks notebook source

CREATE TABLE StudentDetail
(CollegeId INT,StudentId INT,DeptId INT)
;
INSERT INTO StudentDetail
VALUES
(1,1,101),
(1,2,NULL),
(1,3,NULL),
(1,4,NULL),
(1,11,201),
(1,12,NULL),
(1,13,NULL),
(1,14,NULL)

-- COMMAND ----------

select * from StudentDetail

-- COMMAND ----------

with cte as (
select *, count(Deptid) over( order by studentid) as rn
from StudentDetail
),
cte1 as (
select *,first_value(Deptid) over (partition by rn order by studentid) as new_dept from cte
)
select * from cte1
