# Datasets used: employee_details.csv and Department_Details.csv
# Use subqueries to answer every question

CREATE SCHEMA IF NOT EXISTS Employee;
USE Employee;
# import csv files in Employee database.

SELECT * FROM DEPARTMENT_DETAILS;
SELECT * FROM EMPLOYEE_DETAILS;


#Q1. Retrive employee_id , first_name , last_name and salary details of those employees whose salary is greater than the average salary of all the employees.
select avg(salary) from employee_details

select employee_id,first_name,last_name,salary
from employee_details where salary>(select avg(salary) from employee_details)


#Q2. Display first_name , last_name and department_id of those employee where the location_id of their department is 1700

select first_name , last_name ,department_id 
from employee_details where department_id in(select department_id 
                                             from department_details 
                                             where location_id=1700)
                                             
#Q3. From the table employees_details, extract the employee_id, first_name, last_name, job_id and department_id who work in  any of the departments of Shipping, Executive and Finance.
select employee_id,first_name,last_name,
job_id,department_id from employee_details 
where department_id in (select department_id
                        from department_details
						where department_name in ('Shipping', 'Executive','Finance'))

#Q4. Extract employee_id, first_name, last_name,salary, phone_number and email of the CLERKS who earn more than the salary of any IT_PROGRAMMER.

SELECT employee_id,first_name,last_name,salary,phone_number,email 
FROM employee_details
 WHERE salary in (SELECT salary  
				  FROM employee_details   
				  WHERE job_id ='ST_CLERK'>ANY(SELECT salary  
                                               FROM employee_details   
                                                WHERE job_id ='IT_PROG'))         
                
-- asper my assumpsion there is no clerk who earn more than any IT_programmer

#Q5. Extract employee_id, first_name, last_name,salary, phone_number, email of the AC_ACCOUNTANTs who earn a salary more than all the AD_VPs.
select employee_id,first_name,last_name,salary, phone_number, email
FROM employee_details
 WHERE salary in (SELECT salary  
				  FROM employee_details   
				  WHERE job_id ='AC_ACCOUNTANT'>ALL(SELECT salary  
                                                    FROM employee_details   
													WHERE job_id ='AD_VP'))     

#Q6. Write a Query to display the employee_id, first_name, last_name, department_id of the employees who have been recruited in the recent half timeline since the recruiting began. 




#Q7. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees belonging to the 'Contracting' department 

select department_id 
from department_details 
where department_name like '%Contracting%'
-- first finding the sq part where I am checking the contracting departments

select  employee_id, first_name, last_name, phone_number, salary ,job_id
from employee_details where department_id in (select department_id 
                                              from department_details 
                                               where department_name like '%Contracting%')

#Q8. Extract employee_id, first_name, last_name, phone_number, salary and job_id of the employees who does not belong to 'Contracting' department

select department_id 
from department_details 
where department_name not like '%Contracting%'
-- first finding the sq part where I am checking the not contracting departments

select  employee_id, first_name, last_name, phone_number, salary ,job_id
from employee_details where department_id in (select department_id 
                                              from department_details 
                                               where department_name not like '%Contracting%')

#Q9. Display the employee_id, first_name, last_name, job_id and department_id of the employees who were recruited first in the department

select employee_id, first_name, last_name, job_id,department_id 
 
#Q10. Display the employee_id, first_name, last_name, salary and job_id of the employees who earn maximum salary for every job.
select employee_id, first_name, last_name, salary,job_id
from employee_details
where job_id in(select max(salary) from employee_details group by job_id)