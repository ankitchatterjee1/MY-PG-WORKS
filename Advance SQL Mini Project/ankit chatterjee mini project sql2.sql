
-- Composite data of a business organisation, 
-- confined to ‘sales and delivery’ domain is given for the period of last decade. 
-- From the given data retrieve solutions for the given scenario.
#######################################################################################################
-- data base create 
create database sales_delivery_mini_ii;
use sales_delivery_mini_ii;
-- show tables 
select * from market_fact;
select * from cust_dimen;
select * from orders_dimen;
select * from prod_dimen;
select * from shipping_dimen;
-- ----------------------------------------------------------------------
# 1.	Join all the tables and create a new table called combined_table.
# (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)
-- ----------------------------------------------------------------------

create table combined_table as
select cust.cust_id,customer_name,province,region,customer_segment,od .order_id, order_date,order_priority,
pdi .prod_id,product_category,product_sub_category,sip .ship_id,ship_date,ship_mode,
sales,discount,order_quantity,profit,shipping_cost,product_base_margin
from market_fact market  join cust_dimen cust
on market .cust_id=cust .cust_id
join orders_dimen od on market .ord_id = od .ord_id
join prod_dimen pdi on market .prod_id = pdi .prod_id
join shipping_dimen sip on market .ship_id = sip .ship_id;
    
   
select * from combined_table ;

-- -------------------------------------------------------------------------
# 2.	Find the top 3 customers who have the maximum number of orders
-- --------------------------------------------------------------------------

select customer_name, order_quantity from cust_dimen cust
join market_fact market on cust.cust_id = market.cust_id 
group by order_quantity order by order_quantity desc limit 3;

-- ------------------------------------------------------------------------------------------------------------
# 3.	Create a new column DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
-- -------------------------------------------------------------------------------------------------------------

alter table combined_table add column daystakenfordelivery int;
update combined_table set DaysTakenForDelivery =datediff(str_to_date(Ship_Date,'%d-%m-%Y'),str_to_date(Order_Date,'%d-%m-%Y'));
select Order_ID, Order_Date, Ship_Date, DaysTakenForDelivery from combined_table;



-- ------------------------------------------------------------------------
#4.	Find the customer whose order took the maximum time to get delivered.
-- -------------------------------------------------------------------------

select cust_id,customer_name,  order_Date, ship_Date, daystakenfordelivery from combined_table 
where daystakenfordelivery in (select max(daystakenfordelivery) from combined_table);



-- --------------------------------------------------------------------------------
#5.	Retrieve total sales made by each product from the data (use Windows function)
-- -----------------------------------------------------------------------------------

select Prod_id, sum(Sales) over (partition by Prod_id) as total_sales from market_fact;
-- ---------------------------------------------------------------------------------------
#6.	Retrieve total profit made from each product from the data (use windows function)
-- ---------------------------------------------------------------------------------------

select Prod_id, sum(Profit) over (partition by Prod_id) as total_profit from market_fact;
-- -------------------------------------------------------------------------------------------------------------------------------
#7.	Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
-- ------------------------------------------------------------------------------------------------- -----------------------------


select distinct month(str_to_date(order_date,'%d-%m-%y')) as months, count(cust_id) over
(partition by month(str_to_date(order_date,'%d-%m-%y')) order by month(str_to_date(order_date,'%d-%m-%y'))) as
total_unique_customers
from combined_table
where year(str_to_date(order_date,'%d-%m-%y'))=2011 and cust_id
in (select distinct cust_id from combined_table
where month(str_to_date(order_date,'%d-%m-%y'))= 01
and year(str_to_date(order_date,'%d-%m-%y'))=2011);	
	
-- -------------------------------------------------------------------------------------------------
#8.	Retrieve month-by-month customer retention rate since the start of the business.(using views)

# Tips: 
# 1: Create a view where each user’s visits are logged by month, 
		#allowing for the possibility that these will have occurred over multiple 
		# years since whenever business started operations
# 2: Identify the time lapse between each visit. So, for each person and for each month, we see when the next visit is.
# 3: Calculate the time gaps between visits
# 4: categorise the customer with time gap 1 as retained, >1 as irregular and NULL as churned
# 5: calculate the retention month wise

-- --------------------------------------------------------------------------------------------------
# tips1
create view user_visit as select  cust_id, month((str_to_date(order_date,'%d-%m-%Y'))) as month, 
count(*) as count_in_month from combined_table group by 1,2;

select * from user_visit;


#tips2

create view time_lapse as 
select  *, lead(month) over (partition by cust_id order by month) as next_month_visit
from user_visit; 

select * from time_lapse;

#tips3

create view  time_gap as select *, next_month_visit - month as time_gap from time_lapse;
select * from time_gap;

#tips4

create view customer_value as 
select distinct cust_id, avg(time_gap)over(partition by cust_id) as average_time_gap,
case 
	when (avg(time_gap)over(partition by cust_id))<=1 then 'retained'
    when (avg(time_gap)over(partition by cust_id))>1 then 'irregular'
    when (avg(time_gap)over(partition by cust_id)) is null then 'churned'
    else 'unknown data'
end  as  'customer_Value'
from time_gap;

select * from customer_value;

#tips5
create view retention as 
select distinct next_month_visit as retention_month,
sum(time_gap) over (partition by next_month_visit) as retention_sum_monthly
from time_gap where time_gap=1;

select * from retention;
