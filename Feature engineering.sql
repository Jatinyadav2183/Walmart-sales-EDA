-- Feature engineering
-- 1. time_of_day
select time, 
( case
when `time` between "00:00:00" and "12:00:00" then "morning"
when `time` between "12:01:00" and "16:00:00" then "afternoon"
else "evening"
end) as time_of_day
from walmart_database;

alter table walmart_database add column time_of_day varchar(30);

update walmart_database
set time_of_day =
(case
when `time` between "00:00:00" and "12:00:00" then "morning"
when `time` between "12:01:00" and "16:00:00" then "afternoon"
else "evening"
end);

-- 2. Day_name

select date,
dayname(date) as day_name
from walmart_database;

alter table walmart_database add column day_name varchar(30);

update walmart_database
set day_name = dayname(date);

-- 3. Month_name

select date, 
monthname(date) as month_name
from walmart_database;

alter table walmart_database add column month_name varchar(30);

update walmart_database
set month_name = monthname(date);

