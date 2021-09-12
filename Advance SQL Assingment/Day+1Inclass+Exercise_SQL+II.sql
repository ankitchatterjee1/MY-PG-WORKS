# Dataset used: titanic_ds.csv
# Use subqueries for every question
use inclass;
#Q1. Display the first_name, last_name, passenger_no , fare of the passenger who paid less than the  maximum fare. (20 Row)

select first_name,last_name,passenger_no,fare
from titanic_ds
where fare<(select max(fare) from titanic_ds);


#Q2. Retrieve the first_name, last_name and fare details of those passengers who paid fare greater than average fare. (11 Rows)



select first_name,last_name,fare
from titanic_ds
where fare>(select avg(fare) from titanic_ds);


#Q3. Display the first_name ,sex, age, fare and deck_number of the passenger equals to passenger number 7 but exclude passenger number 7.(3 Rows)
 
 
select first_name,sex,age,deck_number,fare from titanic_ds where deck_number
 in (select deck_number from titanic_ds where passenger_no= 7) and  passenger_no <> 7; 
 
 
#Q4. Display first_name,embark_town where deck is equals to the deck of embark town ends with word 'town' (7 Rows)


select first_name,embark_town from titanic_ds 
where deck in (select deck from titanic_ds 
            where embark_town like '%town');


# Dataset used: youtube_11.csv

#Q5. Display the video Id and the number of likes of the video that has got less likes than maximum likes(10 Rows)

select video_id,likes
from youtube_11
where likes<(select max(likes) from youtube_11);


#Q6. Write a query to print video_id and channel_title where trending_date is equals to the trending_date of  category_id 1(5 Rows)


select video_Id,channel_title 
from youtube_11
where trending_date=(select trending_date 
					from youtube_11 
                    where category_id = 1);


#Q7. Write a query to display the publish date, trending date ,views and description where views are more than views of Channel 'vox'.(7 Rows))



select publish_date, trending_date ,views,description
from youtube_11
where views>(select views from youtube_11 where channel_title like '%vox%');


#Q8. Write a query to display the channel_title, publish_date and the trending_date having category id in between 9 to Maximum category id .
# Do not use Max function(3 Rows)


SELECT channel_title,publish_date,trending_date 
from youtube_11
where category_id between 9 and (select category_id 
                                 from youtube_11 
                                 order by category_id desc limit 1);


#Q9. Write a query to display channel_title, video_id and number of view of the video that has received more than  mininum views. (10 Rows)



select channel_title, video_id
       from youtube_11 
       where views >(select min(views)from youtube_11);


# Database used: db1 (db1.sql file provided)

#Q10. Get those order details whose amount is greater than 100,000 and got cancelled(1 Row))


select*from orders
       where  customernumber in(select customernumber 
                                from payments 
                               where amount>100000)
		 and status='Cancelled';



#Q11. Get employee details who shipped an order within a time span of two days from order date (15 Rows)


select * from employees 
where employeenumber in (select salesRepEmployeeNumber 
                         from customers 
                         where customernumber in (select customernumber 
                                                 from orders 
                                                 where datediff(orderDate,shippedDate)<=2));

#Q12. Get product name , product line , product vendor of products that got cancelled(53 Rows)
 
 
 select productname,productline,productvendor
from products 
where productcode in(select productcode 
                     from orderdetails 
                     where ordernumber in(select ordernumber 
										 from orders 
                                          where status='Cancelled'));
 
 
#Q13. Get customer full name along with phone number ,address , state, country, who's order was resolved(4 Rows)
 
 
 select customername,phone,addressLine1,addressLine2,state,country 
from customers where customernumber in (select customernumber 
                                         from orders
                                        where status='resolved');
 
#Q14. Display those customers who ordered product of price greater than average price of all products(98 Rows)


select * from customers
where customernumber in(select customernumber
                        from orders
                         where ordernumber in(select ordernumber 
                                              from orderdetails 
                                               where productcode in (select productcode 
                                                                     from products 
											                          where buyprice>(select avg(priceeach)
											                                           from orderdetails))));

 -- as per my assumption i get 80 rows.

#Q15. Get office deatils of employees who work in the same city where their customers reside(5 Rows)


select * 
from offices
where officecode in (select officecode 
                       from offices 
                       where city in (select city from customers));

