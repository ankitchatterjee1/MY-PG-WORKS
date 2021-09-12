CREATE SCHEMA IF NOT EXISTS Video_Games;
USE Video_Games;
SELECT * FROM video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.


select name,platform, sum(NA_sales) over (partition by platform)as sales_total 
from video_games_sales ;


# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.



select name,platform,genre,global_sales as sum_sales, sum(na_sales) over (partition by genre) as genre_sales,
sum(global_sales) over(partition by platform) as global_sal
from video_games_sales;


# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.



select *,row_number()  over(partition by platform order by Year_of_Release desc) as year_rel
from Video_Games_Sales;

# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). Also arrange the result in the descending order by year of release.
   
 
select *,avg(Global_Sales)  over(partition by Year_of_Release ) as sal_avg
from video_games_sales  order by Year_of_Release desc;
 
 
# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 

select name,publisher,critic_score,score_rank from 
(select name,publisher,platform,critic_score,dense_rank() over 
(partition by publisher order by critic_score desc) as score_rank from video_games_sales) as video_game where score_rank <=5;


------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date


select *,lead(str_to_date(launch_date,'%d-%c-%Y'),2)
over (order by str_to_date(launch_date,'%d-%c-%Y')) as launch_date_3rd_website from web;

-- as per my assumption i got 3 row accroding to qustion  opening date forword so that's why i use lead function . 


# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.

select website_id,str_to_date(day,'%d-%c-%Y') as day_first,income,
first_value(income) over (order by str_to_date(day,'%d-%c-%Y')) as first_day_income
from website_stats where website_id = 1;

-- 
-----------------------------------------------------------------
# Dataset Used: play_store.csv 
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.

select name,genre,released,rank() over (order by str_to_date(released,'%d-%c-%Y') ) as rank_new,
dense_rank() over (order by str_to_date(released,'%d-%c-%Y') ) as rank_dens,
row_number() over (order by str_to_date(released,'%d-%c-%Y') ) as numbers_of_new_row
from play_store;

