-- 1.How many distinct cities are present in the dataset?

select distinct city from walmart_database;

-- 2.In which city is each branch situated?

select distinct branch, city from walmart_database;

-- Product Analysis
-- 1.How many distinct product lines are there in the dataset?

select count(distinct product_line) from walmart_database;

-- 2.What is the most common payment method?
select payment, count(payment) as total_payment
from walmart_database group by payment order by total_payment desc limit 1;

-- 3.What is the most selling product line?
select Product_line , count(Product_line) as total_product_line
from walmart_database group by Product_line order by total_product_line desc limit 1;

-- 4.What is the total revenue by month?

select month_name, sum(total) as total
from walmart_database group by month_name order by total desc;

--  5.Which month recorded the highest Cost of Goods Sold (COGS)?

select month_name, sum(cogs) as total_cogs
from walmart_database  group by month_name order by total_cogs desc;

-- 6.Which product line generated the highest revenue?

select Product_line , sum(total) as total
from walmart_database group by Product_line order by total desc limit 1;

-- 7.Which city has the highest revenue?

select City, sum(total) as total_revenue
from walmart_database group by City order by total_revenue desc limit 1;

-- 8.Which product line incurred the highest VAT?
select Product_line , sum(vat) as total_vat
from walmart_database group by Product_line order by total_vat desc limit 1;

-- 9.Retrieve each product line and add a column product_category, indicating 'Good' or 'Bad,'based on whether its sales are above the average.

alter table walmart_database add column product_category varchar(20);

update walmart_database
set product_category = 
(case 
when total >= (select avg(total) from (select * from walmart_database) as subquery) then "good"
else "bad"
end);

-- 10.Which branch sold more products than average product sold?

select Branch, sum(quantity) as quantity
from walmart_database group by Branch 
having sum(quantity) > avg(quantity) order by quantity desc limit 1;

-- 11.What is the most common product line by gender?
select Gender, Product_line, count(Gender) as Gender_of
from walmart_database group by Gender, Product_line order by Gender_of desc; 

-- 12.What is the average rating of each product line?

select Product_line , round(avg(rating),2) as rating_avg
from walmart_database group by Product_line order by rating_avg desc;

-- Sales Analysis

-- 1.Number of sales made in each time of the day per weekday? 
select day_name, time_of_day, count(Invoice_ID) as total_sales
from walmart_database 
group by day_name, time_of_day having day_name not in ('Sunday', 'Saturday') ;

-- 2.Identify the customer type that generates the highest revenue.

select Customer_type , sum(total) as total_revenue
from walmart_database group by Customer_type order by total_revenue desc limit 1;

--  3.Which city has the largest tax percent/ VAT (Value Added Tax)?

select City, round(sum(vat),2) as total_vat
from walmart_database group by City order by 
total_vat desc limit 1;

-- 4.Which customer type pays the most in VAT?

select Customer_type , round(sum(vat),2) as total_vat
from walmart_database group by Customer_type order by total_vat desc limit 1;

-- Customer Analysis

-- 1.How many unique customer types does the data have?

select count(distinct Customer_type) from walmart_database;

-- 2.How many unique payment methods does the data have?

select count(distinct Payment) from walmart_database;

-- 3.Which is the most common customer type?

select Customer_type , count(Customer_type) as common_customer
from walmart_database group by Customer_type order by common_customer desc limit 1 ;

-- 4.Which customer type buys the most?
select customer_type , sum(total) as total_sales
from walmart_database group by Customer_type order by total_sales desc limit 1;


select customer_type , count(*) as most_buyer
from walmart_database group by Customer_type order by most_buyer desc limit 1;

-- 5.What is the gender of most of the customers?

select gender, count(*) as total_gender
from walmart_database group by gender order by total_gender desc limit 1;

-- 6.What is the gender distribution per branch?
select branch, count(gender) as total_gender
from walmart_database group by Branch order by total_gender desc limit 3;

--  7.Which time of the day do customers give most ratings?
select time_of_day , round(avg(rating),2) as avg_rating 
from walmart_database group by time_of_day order by avg_rating desc limit 1;

-- 8.Which time of the day do customers give most ratings per branch?
select branch , time_of_day , round(avg(rating),2) as avg_rating
from walmart_database group by branch , time_of_day order by avg_rating desc;

select branch, time_of_day, 
avg(rating) over (partition by branch) as ratings 
from walmart_database;

-- 9.Which day of the week has the best avg ratings?

select day_name , round(avg(rating),2) as avg_rating
from walmart_database group by day_name order by avg_rating desc limit 1;

-- 10.Which day of the week has the best average ratings per branch?

select day_name , branch , round(avg(rating),2) as avg_rating
from walmart_database group by day_name, Branch order by avg_rating desc;

select day_name , branch ,avg(rating) over (partition by branch) 
as rating 
from walmart_database ;


