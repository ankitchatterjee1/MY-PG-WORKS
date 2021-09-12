/* Prerequisites */
-- Use the Bank_Holidays and bank_inventory tables from Online_Day1_Inclass file to answer the below questions

use bank;
desc bank_holiday;

# Question 1:
# 1) Increase the length of geo_location size of 30 characters in the bank_inventory table.

alter table bank_inventory modify Geo_Location varchar(30);
desc bank_inventory;

# Question 2:
# 2) Update  estimated_sale_price of bank_inventory table with an increase of 15%  when the quantity of product is more than 4.

update bank_inventory set estimated_sale_price  = ( estimated_sale_price /100) *15 + estimated_sale_price where quantity >4;
select * from bank_inventory;

# Question 3:
# 3) Insert below record by increasing 10% of estimated_sale_price to the given estimated_sale_price 
		-- Product : DailCard
		-- Quantity: 2 
		-- price : 380.00 
		-- Puchase_cost : 8500.87
		-- estimated_sale_price: 9000.00
 insert into bank_inventory (product,quantity,price,purchase_cost,estimated_sale_price)values ('DailCard','2','380.00','8500.87','9000.00');
update bank_inventory set estimated_sale_price  = ( estimated_sale_price /100) *10 + estimated_sale_price;

# Question 4:
# 4) Delete the records from bank_inventory when the difference of estimated_sale_price and 
-- Purchase_cost is less than 5% of estimated_sale_price 

delete from bank_inventory where (estimated_sale_price-purchase_cost)<(estimated_sale_price*5/100);

# Question 5:
# 5) Update the end time of bank holiday to 2020-03-20 11:59:59 for the holiday on 2020-03-20

 update bank_holiday set end_time='2020-03-20 11:59:59' where holiday =  '2020-03-20';
 select * from bank_holiday;
 
# Use tables cricket_1 and cricket_2 from Online_Day2_InClass to answer the queries. 

# Question 6:

use crickt_data;
desc cricket_1;
desc cricket_2;
select * from cricket_1;
select * from cricket_2;

# Q6.Extract Player_Id and Player_name of those columns where charisma is null.

select player_id , player_name from cricket_2 where charisma is null;

# Question 7:

# Q7.Write MySQL query to extract Player_Id , Player_Name , charisma where charisma is greater than 25.

select player_id , player_name from cricket_2 where charisma >25;

# Question 8:

# Q8.Write MySQL query to extract Player_Id , Player_Name who scored fifty and above

select Player_Id , Player_Name from cricket_2  where runs>=50;

# Question 9:

# Q9.Write MySQL query to extract Player_Id , Player_Name who have popularity in the range of 10 to 12.

select Player_Id , Player_Name from cricket_1 where popularity between 10 and 12;

# Question 10:

# Q10.Write MySQL query to extract Player_id, Player_Name where the Runs and Charisma both are greater than 50.

select player_id , player_name from cricket_2 where runs>50 or charisma >50;
