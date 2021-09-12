# Datasets used: AirlineDetails.csv, passengers.csv and senior_citizen.csv
-- -----------------------------------------------------
-- Schema Airlines
-- -----------------------------------------------------

create database airlines;
use airlines
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should be accepted
-- -- Q4. Assign primary key to Flight_ID



create table ariline_details
(
flight_id int not null primary key,
name_of_airlines varchar(50) unique,
country varchar(50) check (country in ('united kingdom','usa','Inida','canada','singapore'))
);


-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Only passengers having age greater than 18 are allowed.
-- -- Q3. Assign primary key to Traveller_ID

-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique and should not be null.
-- -- Q4. Flight Id should not be null.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------


create table passengers 
(
traveller_id varchar(10) not null  primary key ,
pnr varchar(20) not null unique,
passenger_age int check(passenger_age >18),
flight_id int not null
);




-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Column Traveller_ID should not contain any null value.
-- -- Q2. Assign primary key to Traveller_ID
-- -- Q3. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- --  Also deletion of any row from passenger table should not be allowed.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------



create table  senior_citizen_details 
(
traveller_id varchar(10) not null  primary key ,
senior_citizen varchar(50),
discounted_price int,
foreign key (traveller_id) references passengers(traveller_id)
on update cascade on delete restrict 
);






-- -----------------------------------------------------
-- Table Senior_Citizen_Details
-- -- Q6. Create a new column Age in Passengers table that takes values greater than 18. 
 
 -- in age passengers table i have alredy created so that's resons don't create
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Qa. The cost should not be less than or equal to 0.
-- -- Qb. The cost column should not be null.
-- -- Qc. Assign a primary key to the column books_no.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------


create table books
(
book_no int primary key,
description varchar(30),
author_name varchar(20),
cost float not null check(cost>0));



# Q8. Update the table 'books' such that the values in the columns 'description' and author' must be unique.


alter table books 
modify description varchar(50) unique,
modify author_name varchar(50) unique;



-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.
-- --------------------------------------------------------------------------

create table bike_sales 
(
id int primary key  not null auto_increment,
product varchar(50) not null ,
quantity int not null check (quantity >0),
release_year int not null check( release_year between 2000 and 2010),
release_month int not null check (release_month between 1 and 12)
);




-- ------------------------------------------------------------------------------
-- Use the following comands to insert the values in the table bike_sales
/*('1','Pulsar','1','2001','7');
('2','yamaha','3','2002','3');
('3','Splender','2','2004','5');
('4','KTM','2','2003','1');
('5','Hero','1','2005','9');
('6','Royal Enfield','2','2001','3');
('7','Bullet','1','2005','7');
('8','Revolt RV400','2','2010','7');
('9','Jawa 42','1','2011','5');*/
-- --------------------------------------------------------------------------

insert into bike_sales values('1','pulsar','1','2001','7');
insert into bike_sales (product, quantity, release_year, release_month) values('yamaha','3','2002','3');
insert into bike_sales  (product, quantity, release_year, release_month) values('splender','2','2004','5');
insert into bike_sales (product, quantity, release_year, release_month) values('ktm','2','2003','1');
insert into bike_sales  (product, quantity, release_year, release_month)values('hero','1','2005','9');
insert into bike_sales (product, quantity, release_year, release_month) values('royal enfield','2','2001','3');
insert into bike_sales (product, quantity, release_year, release_month)values('bullet','1','2005','7');
insert into bike_sales (product, quantity, release_year, release_month)values('revolt rv400','2','2010','7');
insert into bike_sales (product, quantity, release_year, release_month) values('jawa 42','1','2011','5');


