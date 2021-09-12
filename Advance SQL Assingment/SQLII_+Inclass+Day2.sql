use inclass;

-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------

SELECT * FROM wine;

# Q1. Rank the winery according to the quality of the wine (points).-- Should use dense rank


select winery,dense_rank() over(order by points) as rank_ from wine;

# Q2. Give a dense rank to the wine varities on the basis of the price.



select *, dense_rank() over (partition by variety order by price ) as rank_price from wine;


# Q3. Use aggregate window functions to find the average of points for each row within its partition (country). 
-- -- Also arrange the result in the descending order by country.

select distinct country,avg(points) over(partition by country )as arrange_result from wine order by country desc;

-----------------------------------------------------------------
# Dataset Used: students.csv
-- --------------------------------------------------------------
 
 select * from students ;
 
# Q4. Rank the students on the basis of their marks subjectwise.


select *,rank() over(partition by subject order by marks) as basis_of_marks_rank from students;

# Q5. Provide the new roll numbers to the students on the basis of their names alphabetically.


select *, row_number() over(order by name desc)  from students;


# Q6. Use the aggregate window functions to display the sum of marks in each row within its partition (Subject).


select *,sum(marks) over(partition by subject Range between unbounded preceding and current row) as sum_of_marcks from students;


# Q7. Display the records from the students table where partition should be done 
-- on subjects and use sum as a window function on marks, 
-- -- arrange the rows in unbounded preceding manner.

select *,sum(marks) over(partition by subject Range between unbounded preceding and current row) as sum_function_marks from students;



# Q8. Find the dense rank of the students on the basis of their marks subjectwise. Store the result in a new table 'Students_Ranked'
create table students_rank
as
select * ,dense_rank() over (partition by subject order by marks desc)from students;

select* from students_rank;
-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
# Q9. Show day, number of users and the number of users the next day (for all days when the website was used)
select * from website_stats;

select * from web;

select website_id, day, no_users as same_view, lead(no_users,1) over (partition by website_id) result_next_view
from website_stats ;



# Q10. Display the difference in ad_clicks between the current day and the next day for the website 'Olympus'


select website_id,day, ad_clicks - lead(ad_clicks) over (partition by website_id order by day) 
from website_stats web
	where web.website_id=(select id from web 
								where name='Olympus');



# Q11. Write a query that displays the statistics for website_id = 3 such that for each row, show the day, the number of users and the smallest number of users ever.


select day, no_users, min(no_users) over() 
as user_less from website_stats where website_id = 3;


# Q12. Write a query that displays name of the website and it's launch date. The query should also display the date of recently launched website in the third column.



select name,str_to_date(launch_date,'%d-%c-%Y') as launch_date,
last_value(str_to_date(launch_date,'%d-%c-%Y')) over (order by str_to_date(launch_date, '%d-%c-%Y')
range between unbounded preceding and unbounded following) as launch_date
from web;


-----------------------------------------------------------------
# Dataset Used: play_store.csv and sale.csv
-----------------------------------------------------------------

select * from play_store;
select * from sale;


# Q13. Write a query thats orders games in the play store into three buckets as per editor ratings received  


select *,ntile(3) 
over(order by editor_rating desc) as editor_rating from play_store;


# Q14. Write a query that displays the name of the game, the price, the sale date and the 4th column should display 
# the sales consecutive number i.e. ranking of game as per the sale took place, so that the latest game sold gets number 1. Order the result by editor's rating of the game


select ank.id,name,price, str_to_date(bi.date,'%d-%c-%Y') as date,editor_rating,dense_rank() over (order by str_to_date(bi.date,'%d-%c-%Y') desc) as gaming_rank
from play_store ank join sale bi on ank.id = bi.game_id order by editor_rating;


# Q15. Write a query to display games which were both recently released and recently updated. For each game, show name, 
#date of release and last update date, as well as their rank
#Hint: use ROW_NUMBER(), sort by release date and then by update date, both in the descending order


select name,str_to_date(released,'%d-%c-%Y') as rel, str_to_date(updated,'%d-%c-%Y') as up,
row_number() over (order by str_to_date(released,'%d-%c-%Y') desc, str_to_date(updated,'%d-%c-%Y')desc) as rank_
from play_store;


-----------------------------------------------------------------
# Dataset Used: movies.csv, customers.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
select* from movies;
select * from customers_1;
select * from ratings;
select * from rent;



# Q16. Write a query that displays basic movie informations as well as the previous rating provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.

select ank.id,title,release_year,genre,rating, lag(rating) over (Partition by ank.id order by bi.rating) as old_ratings
from movies ank join ratings bi on ank.id = bi.movie_id;

# Q17. For each movie, show the following information: title, genre, average user rating for that movie 
# and its rank in the respective genre based on that average rating in descending order (so that the best movies will be shown first).

select *,dense_rank() over(partition by genre order by avg_ desc) as rank_
from (select title,genre, avg(rating) over(partition by id) as avg_
from movies a join ratings b using (ID)) rating;

# Q18. For each rental date, show the rental_date, the sum of payment amounts (column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between these two values.

select str_to_date(rental_date,'%d-%c-%Y') as rental, current_day, previous_day,
(current_day - previous_day) as payment from (select rental_date,current_day,
lag(current_day) over (order by str_to_date(rental_date,'%d-%c-%Y') desc) as previous_day 
from (select rental_date, sum(payment_amount) as current_day from rent
 group by (str_to_date(rental_date,'%d-%c-%Y'))) rent) rents; 

