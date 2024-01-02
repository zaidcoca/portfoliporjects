create database Sciencetech

use sciencetech



-- (2) Create an ER diagram for the given employee database.

-- key specification withour a key lengthحطيتاها لانها عالجت مشكلة ال 

  alter table emp_record_table
  modify first_name varchar(70)
  
    alter table emp_record_table
  modify  proj_id  varchar(70)
  
  alter table emp_record_table
  rename column proj_id to project_id;

  alter table proj_table
  modify project_id varchar(70)

alter table proj_table add constraint primary key (project_id);


alter table emp_record_table add constraint foreign_key 
foreign key (project_id) references proj_table (project_id);

-- (3) Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees
--  and details of their department.

select emp_id, first_name, last_name, gender, dept from emp_record_table
order by dept 

-- (4) Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 

-- less than two

-- greater than four 

-- between two and four

select emp_id, first_name, last_name, gender, dept, emp_rating from emp_record_table
where emp_rating <2  or emp_rating >4 or emp_rating between 2 and 4
order by emp_rating;

-- (5) Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.

 select first_name, last_name, concat(first_name, " ", last_name) as name from emp_record_table
 where dept= "Finance"

-- (6) Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters 
-- (including the President).

select emp_id, first_name, last_name, manager_id from emp_record_table
where manager_id is not null

-- (7) Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee 
-- record table


select * from
(select * from emp_record_table 
union 
select * from emp_record_table)  emp_record_table
where dept= "finance" or dept= "healthcare"


-- (8) Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept.
--  Also include the respective employee rating along with the max emp rating for the department.

select distinct dept from emp_record_table


select  emp_id, first_name, last_name, role,  dept,  emp_rating, max(emp_rating) from emp_record_table
group by dept
having  emp_rating between 4 and 5 

-- (9) Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

select min(salary), max(salary), role from emp_record_table
group by role 

-- (10) Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.


select emp_id, first_name, last_name, exp from emp_record_table
order by exp 
-----
select emp_id, first_name, last_name, rank() over(order by exp) as exp from emp_record_table

-- (11) Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from
 -- the employee record table.
alter view salary_countries
 as 
 select * from emp_record_table 
 where salary>6000
 
 select * from salary_countries
 

-- (12) Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.

 
 select * from (select * from emp_record_table where exp>10) as exp 
 order by exp

-- (13) Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data
--  from the employee record table.

delimiter // 
create procedure exp_emp()
begin
select * from emp_record_table
where exp>3 ;

end//
delimiter ;
 
 call exp_emp

-- (14) Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science
-- team matches the organization’s set standard.

-- (15) Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee 
-- table after checking the execution plan.

Create index emp_nm
on emp_record_table(first_name);

select * from emp_record_table 
where first_name= "Eric"
-- حطيتاها لانها عالجت مشكلة ال 
select * from emp_nm
  alter table emp_record_table
  modify first_name varchar(70)

-- (16) Write a query to calculate the bonus for all the employees, based on their ratings and salaries 
-- (Use the formula: 5% of salary * employee rating).
 
 select Emp_id, first_name,last_name,(salary*0.5)*emp_rating as Bonus from emp_record_table

-- (17) Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.

select country, continent, avg(salary) from emp_record_table
group by country, continent
