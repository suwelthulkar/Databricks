-- Databricks notebook source
--Create table syntax
CREATE TABLE Flights (cust_id INT, flight_id VARCHAR(10), origin VARCHAR(50), destination VARCHAR(50));

-- Insert data into the table
INSERT INTO Flights (cust_id, flight_id, origin, destination)
VALUES (1, 'SG1234', 'Delhi', 'Hyderabad'), (1, 'SG3476', 'Kochi', 'Mangalore'), (1, '69876', 'Hyderabad', 'Kochi'), (2, '68749', 'Mumbai', 'Varanasi'), (2, 'SG5723', 'Varanasi', 'Delhi');

-- COMMAND ----------

select * from flights

-- COMMAND ----------

with origin as (
select cust_id,origin from flights
minus
select cust_id,destination from flights
),
dest as (
select cust_id,destination from flights
minus
select cust_id,origin from flights

)
select * from origin inner join dest using (cust_id)
order by cust_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC If the origin and destination data is already sorted then we can follow the below approach

-- COMMAND ----------

select cust_id,first_value(origin),last_value(destination) from flights
group by cust_id
