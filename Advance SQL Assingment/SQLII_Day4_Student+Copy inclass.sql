DROP TABLE IF EXISTS `account_details`;
use apr_21;
CREATE TABLE IF NOT EXISTS `account_details` (
  `acc_id` int(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `ssn` char(10) NOT NULL,
  `acc_holder_id` int(10) NOT NULL,
  `balance` decimal(20,4) DEFAULT '0.0000',
  PRIMARY KEY (`acc_id`));
  
INSERT INTO `account_details` (`acc_id`, `acc_holder_id`, `balance`, `first_name`, `last_name`, `ssn`) VALUES
	(1, 100, 132.1020, 'Joseph', 'Cane', '098765432'),
	(2, 300, 4435.2030, 'Kim', 'Karry', '087654321'),
	(3, 120, 2345223.6600, 'Jim', 'Anderson', '123456780'),
	(4, 90, 98763.2300, 'Jessie', 'Thomson', '765432109'),
	(5, 110, 34221.1000, 'Palak', 'Patel', '654321890'),
	(6, 80, 7634.8000, 'Max', 'Jerrard', '456789012'),
	(7, 10, 876964.7000, 'Peter', 'Koshnov', '512345670'),
	(8, 110, 299876.6000, 'Monica', 'Irodov', '120088551'),
	(9, 100, 7659809.5300, 'Petro', 'Jenkins Jr', '123456789'),
	(10, 200, 111.1200, 'Jeff', 'Joshua', '765432189' );
    
select * from account_details;
# Q.1 Write a tansactional query that transfers 1000 dollars from Monica's account to Joseph's account


start transaction ;
update account_details set balance = balance - 1000 
where first_name = 'monica';
update account_details set balance = balance +  1000 
where first_name = 'joshep';
commit;

# Q.2 Suppose while writing the above query you update i.e. transfer 1000 dollars to Peter's account instead of Joseph's account.
# Write a query to discard all the changes and end the transaction


set autocommit = false;
start transaction ;
update account_details set balance = balance - 1000 
where first_name = 'monica';
update account_details set balance = balance +  1000 
where first_name = 'peter';
rollback ;
commit;



#############################################################################################################################################
# Create table to answer the follwoing question
Create table id_passwords( user_id varchar(20), 
							passwords varchar(20));
insert into id_passwords values
		('deborah_a', 'pass123'),
		('pique_xav', '123789pix'),
        ('jenny_fawx', '##**000'),
        ('alpha_m','infinity');
select * from id_passwords;

# Q.3 Write a query to make sure that no other mysql session should be able to insert any user ids or passwords


start transaction ;
select * from  id_passwords  for update ;

 #as long the above transaction is holding the lock for the table , 
 -- no other trnasaction will be able to insert any data
 
############################################################################################################################################# 
-- ----------------------------------------------------
# Datasets Used: employee_details.csv and department_details.csv
-- ----------------------------------------------------
unlock tables;
# Q.4 Create a view "details" that contains the columns employee_id, first_name, last_name and the salary from the table "employee_details".
 
select  * from employee_details;
create view details  as  select first_name, last_name ,salary 
from employee_details;
SELECT * FROM details;
 
# Q.5 Update the view "details" such that it contains the records from the columns employee_id, first_name, last_name, salary, hire_date and job_id 
-- --  where job_id is ‘IT_PROG’.

 
 alter view `details` as select `employee_details`.`employee_id` as `employee_id`,
`employee_details`.`first_name` as `first_name`,`employee_details`.`last_name` as `last_name`,
`employee_details`.`salary` as `salary`,`employee_details`.`hire_date` as `hire_date`,
`employee_details`.`job_id` as `job_id`from`employee_details`
where job_id = 'it_prog';
select * from details;
# acoording to  above qustion ,i have use altered function because the view using  by dialogue box
 
 
 
# Q.6 Create a view "check_salary" that contains the records from the columns employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary should be greater than 50000.
 
 
 
 create view check_salary as select  employee_id, first_name , job_id , salary 
 from employee_details where  salary > 50000;
 
 select * from employee_details;
# Q.7 Create a view "location_details" that contains the records from the columns department_name, manager_id and the location_id from the table "department_details" 
-- --  where the department_name is ‘Shipping’.
 
 
 select * from department_details;
 
 create view  location_details as select department_name, manager_id , location_id from department_details 
 where  department_name = 'shipping';
select * from location_details;


# Q.8 Create a view "salary_range" such that it contains the records from the columns employee_id, first_name, last_name, job_id and salary from the table "employee_details" 
-- --  where the salary is in the range (30000 to 50000).
 
 
 create view salary_range  as select employee_id ,first_name ,last_name , job_id ,salary from employee_details
 where salary between 30000 and  500000;
  select * from salary_range;
 
# Q.9 Create a view "pattern_matching" such that it contains the records from the columns employee_id, first_name, job_id and salary from the table name "employee_details" 
-- --  where first_name ends with "l".

create view pattern_matching  as select employee_id, first_name, job_id,salary from employee_details
where first_name like '%l';
select * from pattern_matching;

# Q.10 Drop multiple existing views "pattern_matching", "salary" and "location_details".
 
 
 drop view pattern_matching,salary_range,location_details;
 
 
 
# Q.11 Create a view "employee_department" that contains the common records from the tables "employee_details" and "department_table".


create view employee_department as select 
emp.employee_id,first_name,last_name,job_id,emp.department_id,dept.department_name,location_id
from employee_details emp
join department_details dept
using (department_id);
select * from employee_department;


-- ----------------------------------------------------
# Datset Used: admission_predict.csv
-- ----------------------------------------------------
# Q.12 A university focuses only on SOP and LOR score and considers these scores of the students who have a research paper. Create a view for that university.

select * from admission_predict ;



create view slr_focus as  select sop ,lor,research 

from admission_predict  where Research = 1 ;
 
select * from slr_focus;

# Q.13 Create and append a new column "SOP_LOR_AVG" to the view "SLR_Focus".


create or  replace  view slr_focus as
select sop,lor,research, ((sop+lor)/2) as sop_lop_avg
from admission_predict
where research = 1;

select * from slr_focus ;

#############################################################################################################################################
#Create Table:
CREATE TABLE BANK_CUSTOMER ( customer_id INT , 
			     customer_name VARCHAR(20), 
			     Address     VARCHAR(20),
			     state_code  VARCHAR(3) ,         
			     Telephone   VARCHAR(10)    );
		    
#Insert records:
INSERT INTO BANK_CUSTOMER VALUES (123001,"Oliver", "225-5, Emeryville", "CA" , "1897614500");
INSERT INTO BANK_CUSTOMER VALUES (123002,"George", "194-6,New brighton","MN" , "1897617000");
INSERT INTO BANK_CUSTOMER VALUES (123003,"Harry", "2909-5,walnut creek","CA" , "1897617866");
INSERT INTO BANK_CUSTOMER VALUES (123004,"Jack", "229-5, Concord",      "CA" , "1897627999");
INSERT INTO BANK_CUSTOMER VALUES (123005,"Jacob", "325-7, Mission Dist","SFO", "1897637000");
INSERT INTO BANK_CUSTOMER VALUES (123006,"Noah", "275-9, saint-paul" ,  "MN" , "1897613200");
INSERT INTO BANK_CUSTOMER VALUES (123007,"Charlie","125-1,Richfield",   "MN" , "1897617666");
INSERT INTO BANK_CUSTOMER VALUES (123008,"Robin","3005-1,Heathrow",     "NY" , "1897614000");

# Q.14 Suppose there is no customer_id: 123009 in the bank_customer table,
#One of the first user is trying to update the customer_id details with condition customer_id > 123008 and updating telephone as NULL.
#At the same time, if some other user is trying to insert a record with customer_id : 123009 with values ( 123009, 'Ropert' , '99-Bechkingam', 'CA' , 1867888950).
#During the above two transactions occuring at a same time, After first user checks the database , he recieves an additional record entry of 123009 which he doesn't expect.
#How will you restrict the second user entry?

#login1
select * from bank_customer;
set autocommit = false;
start transaction;
select * from bank_customer where customer_id >123008;
select * from bank_customer for update;


#login2
set autocommit = false;
start transaction;
insert into bank_customer values ( 123009, 'ropert' , '99-bechkingam', 'ca' , 1867888950);

#comment as the login 1 has a exclusive lock on the table ,
#any insert operation can't be allow this transaction  in login 2 


# Q.15 Write a query such that users can perform concurrent DML operations on the same customer_id = 123002 in bank_customer. 
# One user performs an updates House Address for that customer_id with "2999 New brighton" 
# Other user performs an update Telephone number with 189891899

#any concarent dml operation can't perform at the simulteniusly way 


#login1
set autocimmit = false;
start transaction;
update bank_customer set address = '2999 new brighton' 
where customer_id = 123002;
commit;


#  in login1  user has to execute in operation by commeting the statement  and give the access other user to performe their operation 

#login2
set autocimmit = false;
start transaction;
update bank_customer set telephone = '189891899'
 where customer_id = 123002;
commit;

# when user 1 commit the set of operation in login 1 then only in login 2 user2 can performe .
#this opertion canot be done .



# Q.16 Write a transaction on customer Id = 123001 in table: bank_customer to acquire shared lock . So others can also acquire the 
# shared lock but cannot modify any rows in the bank_customer table
# login 2
set autocimmit = false;
start transaction;
select * from bank_customer where customer_id = 123001 lock in share mode;
# shared lock applied,due to this read access can be given to any of the user and the same lock share dcan be applicable in any other instance


login 2
set autocimmit = false;
start transaction;
select * from bank_customer where customer_id = 123001  lock in share mode;


#even though shared lock applied in instance 1, user can be able to apply shared loack in any instance,
# write access cannot be applicable once shared lock applied on table.

#############################################################################################################################################
CREATE TABLE BANK_ACCOUNT ( Customer_id INT, 		   			  
							Account_Number VARCHAR(19),
							Account_type VARCHAR(25),
							Balance_amount INT ,
                            Account_status VARCHAR(10), 
                            Relationship_type varchar(1) ) ;
INSERT INTO BANK_ACCOUNT  VALUES (123001, "4000-1956-3456",  "SAVINGS"            , 200000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO BANK_ACCOUNT  VALUES (123002, "4000-1956-2001",  "SAVINGS"            , 400000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123003, "4000-1956-2900",  "SAVINGS"            ,750000,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "4000-1956-3401",  "SAVINGS"            , 655000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123005, "4000-1956-5102",  "SAVINGS"            , 300000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123006, "4000-1956-5698",  "SAVINGS"            , 455000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "5000-1700-9800",  "SAVINGS"            , 355000 ,"ACTIVE" ,"P"); INSERT INTO BANK_ACCOUNT  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "9000-1700-7777-4321",  "CREDITCARD"    ,0      ,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123008, "5000-1700-7755",  "SAVINGS"            ,NULL   ,"INACTIVE","P"); 


# Q.17 Write a transactional query such that a 3% interest is added in the balance_amount of all account_numbers 
# of a customer Id = 123001 in bank_account table. Make sure that no other users is able to make any update to the table
#login 1
set autocommit = false;
start transaction;
select * from bank_customer for update;
update bank_customer set balance_amount = (1.03*balance_amount) where customer_id = 123001;

#login2
set autocommit = false;
start transaction;
select * from bank_customer;
update bank_customer set balance_amount = (1.23*balance_amount) where customer_id = 123001;

#  The update statement at instance 2 will not execute untill the user at instance 1 performs his opeartion and end by committing.



# Q.18 Three users are performing DML operations;
# Out of three users, one user increases  balance_amount by 0.03% of customer_id = 123001; in bank_account table.
# Write transactional query such that after the above update users can insert two different balance_amount concurrently for an account : '4000-1956-3401' parallely without any deadlock

#login1
set autocommit = false;
start transaction;
select * from bank_customer for update;
update bank_customer set balance_amount = (1.0003*balance_amount) where customer_id = 123001;
commit;

# USER 1 at instance 1 succefully updated his set of ooerations and commit the transcation, so that others can perform 

#INSTANCE 2 # no DML opeartions can be performed concurrently at same time, instead of that we can do indivdual update and commiting transactions
# and then allow user 3 at instance 3 to perform further operations

# we cannot perform concurrent DML opeartions, which will lead to deadlock or data crash, hence no two DML opeartions performs 
# simultaneously.


