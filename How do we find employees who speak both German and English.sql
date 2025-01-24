-- Databricks notebook source
-- MAGIC %md
-- MAGIC Show me the company with atleast 2 user who speaks German and English

-- COMMAND ----------

CREATE TABLE Company_user (
 Company_Id VARCHAR(512),
 User_Id INT,
 Language VARCHAR(512)
);
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '1', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '1', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '2', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '3', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '3', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '4', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '5', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '5', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '6', 'Spanish');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '6', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '7', 'English');

-- COMMAND ----------

select * from company_user
order by company_id

-- COMMAND ----------

with cte as (
select user_id, count(*) from company_user
where Language != 'Spanish'
group by User_Id
having count(*) >= 2
)
select c.* from company_user c inner join cte c1
on c.User_Id = c1.User_Id
order by c.Company_Id, c.User_Id



-- COMMAND ----------

-- MAGIC %md
-- MAGIC Without CTE

-- COMMAND ----------

select A.user_id, count(*) as no_of_users,b.Language from company_user A 
inner join company_user B
on A.user_id = B.user_id
and A.Language != 'Spanish'
group by A.user_id,b.Language
having count(*) = 2
order by A.user_id
