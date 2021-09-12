# Datasets used: employee.csv and membership.csv

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Schema EmpMemb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS EmpMemb;
USE EmpMemb;


-- 1. Create a table Employee by refering the data file given. 

-- Follow the instructions given below: 
-- -- Q1. Values in the columns Emp_id and Members_Exclusive_Offers should not be null.
-- -- Q2. Column Age should contain values greater than or equal to 18.
-- -- Q3. When inserting values in Employee table, if the value of salary column is left null, then a value 20000 should be assigned at that position. 
-- -- Q4. Assign primary key to Emp_ID
-- -- Q5. All the email ids should not be same.

create table employee 
(
emp_id varchar(10) not null primary key ,
memberes_exclusive_offers varchar(10) not null,
age int check (age>=18),
email_id varchar(20) not null unique,
salary int default 2000
);


-- 2. Create a table Membership by refering the data file given. 

-- Follow the instructions given below: 
-- -- Q6. Values in the columns Prime_Membership_Active_Status and Employee_Emp_ID should not be null.
-- -- Q7. Assign a foreign key constraint on Employee_Emp_ID.
-- -- Q8. If any row from employee table is deleted, then the corresponding row from the Membership table should also get deleted.


create table membership
(
employee_emp_id varchar(10) ,
membership_active_status varchar(12),
enrollment_date int not null ,
end_date int not null,
foreign key (employee_emp_id) references employee(emp_id)
on update  restrict  on delete cascade 
 )
 
 

