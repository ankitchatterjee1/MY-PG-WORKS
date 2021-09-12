-- --------------------------------------------------------
# Datasets Used: cricket_1.csv, cricket_2.csv
-- cricket_1 is the table for cricket test match 1.
-- cricket_2 is the table for cricket test match 2.
-- --------------------------------------------------------
create database crickt_data;
use crickt_data;
desc cricket_1;
select * from cricket_1;
desc cricket_2;
select * from cricket_2;

# Q1. Find all the players who were present in the test match 1 as well as in the test match 2.

 select * from cricket_1
 union 
 select * from cricket_2;
 
# Q2. Write a query to extract the player details player_id, runs and player_name from the table “cricket_1” who
#  scored runs more than 50

select  player_id, runs ,player_name from cricket_1 where runs  >50;

# Q3. Write a query to extract all the columns from cricket_1 where player_name starts with ‘y’ and ends with ‘v’.

select * from cricket_1 where player_name like ('y%v');


# Q4. Write a query to extract all the columns from cricket_1 where player_name does not end with ‘t’.

 select * from cricket_1 where player_name like ('t%%');
 
-- --------------------------------------------------------
# Dataset Used: cric_combined.csv 
-- --------------------------------------------------------

 select * from cric_combined;
 
# Q5. Write a MySQL query to add a column PC_Ratio to the table that contains the divsion ratio 
# of popularity to charisma .(Hint :- Popularity divide by Charisma)

alter table cric_combined add column pc_Ratio float generated always as (popularity/charisma)stored;

# Q6. Write a MySQL query to find the top 5 players having the highest popularity to charisma ratio.

select*from cric_combined order by pc_ratio desc limit 5;

# Q7. Write a MySQL query to find the player_ID and the name of the player that contains the character “D” in it.

select player_id from cric_combined where player_name like ('%d%');

# Q8. Extract Player_Id  and PC_Ratio where the PC_Ratio is between 0.12 and 0.25.
select player_id,pc_ratio from cric_combined  where pc_ratio between 0.12 and 0.25;
-- --------------------------------------------------------
# Dataset Used: new_cricket.csv
-- --------------------------------------------------------
desc new_cricket;
select*from new_cricket;

# Q9. Extract the Player_Id and Player_name of the players where the charisma value is null.
 select player_id,player_name from new_cricket where charisma is null;
 
# Q10. Write a MySQL query to display all the NULL values  in the column Charisma imputed with 0.
 select ifnull(charisma,0) from new_cricket;
 
# Q11. Separate all Player_Id into single numeric ids (example PL1 to be converted as 1, PL2 as 2 , ... PL12 as 12 ).
 select player_id,SUBSTR(player_id,3) from new_cricket;
 
# Q12. Write a MySQL query to extract Player_Id , Player_Name and charisma where the charisma is greater than 25.
select player_id,player_name,charisma from new_cricket where charisma>25;
-- --------------------------------------------------------
# Dataset Used: churn1.csv 
-- --------------------------------------------------------
select * from churn1;

# Q13. Write a query to display the rounding of lowest integer value of monthlyservicecharges and rounding of higher integer value of totalamount 
# for those paymentmethod is through Electronic check mode.

select floor(monthlyservicecharges),ceiling(totalamount) from churn1 where paymenttMethod = 'electronic check';

# Q14. Rename the table churn1 to “Churn_Details”.

rename table churn1 to churn_details;
select *from churn_details;

# Q15. Write a query to create a display a column new_Amount that contains the sum of TotalAmount and MonthlyServiceCharges.
alter table churn_details add(new_amount float);
update churn_details set new_amount=(totalamount+MonthlyServiceCharges);
select*from churn_Details;
# Q16. Rename column new_Amount to Amount.

Alter table churn_details change new_amount amount float;
select*from churn_Details;

# Q17. Drop the column “Amount” from the table “Churn_Details”.

alter table churn_details drop column amount;
select*from churn_Details;

# Q18. Write a query to extract the customerID, InternetConnection and gender 
# from the table “Churn_Details ” where the value of the column “InternetConnection” has ‘i’ 
# at the second position.

select customerID,InternetConnection,gender from churn_details where InternetConnection like '_i%';

# Q19. Find the records where the tenure is 6x, where x is any number.

select * from churn_details where tenure like '6_';

# Q20. Write a query to display the player names in capital letter and arrange in alphabatical order along with the charisma, display 0 for whom the charisma value is NULL.

select upper(player_name) as 'player_name',ifnull(charisma,0) from new_cricket order by player_name and Charisma;