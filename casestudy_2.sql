create table location
( location_id int  primary key,
city varchar (25)
)
insert into location values
(122,'New York'),
(123,'Dallas'),
(124,'Chicago'),
(167,'Boston');
select * from location

create table department
( department_id int primary key,
name varchar(25),
location_id int foreign key references Location(location_id)
)
 insert into department values
 (10,'Accounting',122),
(20,'Sales',124),
(30,'Research',123),
(40,'Operations',167);
select * from department

create table job
( job_id int primary key,
designation varchar (25)
);
 insert into job values
 ( 667,'Clerk'),
(668,'Staff'),
(669,'Analyst'),
(670,'Sales Person'),
(671,'Manager'),
(672,'President');
select * from job
delete from job where designation = 'manager';

create table employee 
( Employee_Id int,
Last_Name varchar(25),
First_Name varchar (25),
Middle_Name varchar (10),
Job_Id int foreign key references job(job_id),
Hire_Date date,
Salary numeric(6,2),
Comm int,
Department_Id int foreign key references department(department_id)
);
insert into employee values
(7369,'Smith','John','Q',667,'17-Dec-84',800,Null,20),
(7499,'Allen','Kevin','J',670,'20-Feb-85',1600,300,30),
(755,'Doyle','Jean','K',671,'04-Apr-85',2850,Null,30),
(756,'Dennis','Lynn','S',671,'15-May-85',2750,Null,30),
(757,'Baker','Leslie','D',671,'10-Jun-85',2200,Null,40),
(7521,'Wark','Cynthia','D',670,'22-Feb-85',1250,50,30)
select * from employee
--1. List all the employee details.
select * from employee
--2. List all the department details.
select * from department
--3. List all job details.
select * from job
--4. List all the locations.
select * from location
--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select FIRST_name , last_name salary,comm from employee;
--6. List out the Employee ID, Last Name, Department ID for all employees and alias
--Employee ID as "ID of the Employee", Last Name as "Name of the Employee", Department ID as "Dep_id".
select employee_id as [id of the employee], 
last_name [Name of the Employee], department_id dep_id from employee 
--7. List out the annual salary of the employees with their names only.
select first_name,last_name, (12*salary)  as annualsalary from employee
--1. List the details about "Smith".
select * from employee where First_Name ='smith';
--2. List out the employees who are working in department 20.
select employee_id, first_name, last_name, department_id 
from employee where department_id =20 
--3. List out the employees who are earning salary between 2000 and 3000.
select * from employee where Salary between 2000 and 3000;
--4. List out the employees who are working in department 10 or 20.
select * from employee where department_id between 10 and 20; 
--5. Find out the employees who are not working in department 10 or 30.
select * from employee where Department_Id not in (10,30);
--6. List out the employees whose name starts with 'L'.
select * from employee where First_Name like 'L%';
--7. List out the employees whose name starts with 'L' and ends with 'E'.
select * from employee where First_Name like 'L%%E';

--8. List out the employees whose name length is 4 and start with 'J'.
select * from employee where len(first_name) =4 and First_Name like 'J%';
--9. List out the employees who are working in department 30 and draw the salaries more 
--than 2500.
select * from employee where Department_Id =30 and Salary >=2500;
--10. List out the employees who are not receiving commission.
select * from employee where Comm is null;



--1. List out the Employee ID and Last-Name in ascending order based
--on the Employee ID.
select employee_id, last_name from employee
group by Employee_Id, last_name
order by Last_Name asc;

--2. List out the Employee ID and Name --in descending order based on salary.
select employee_ID,FIRST_name, salary from employee
order by salary desc;
--3. List out the employee details according to their Last Name in ascending-order.
select * from employee 
order by Last_Name asc;
--4. List out the employee details according to their 
--Last Name in ascending order and then Department ID in descending order.
select * from employee 
order by Last_Name asc,department_id desc;

--1.list out the department wise maximum salary, 
--minimum salary and average salary of the employees.
select department_id, MAX(salary) as maxsalary, MIN(salary) 
as minsal, AVG(salary)as avgsalary from employee
group by department_id;


--2.List out the job wise maximum salary, minimum salary 
--and average salary of the employees.
select job_id, MAX(salary) as maxsalary, 
min(salary) as minsalary, avg(salary) as avgsalary from employee 
group by job_id
--3.List out the number of employees who joined each month in ascending order.
select  DATEPART(month,hire_date) as month , 
COUNT(employee_id) as no_of_employee from employee
group by DATEPART(month,hire_date)
order by month asc;
--4.List out the number of employees for each month and year in
--ascending order based on the year and month.
select DATENAME(month,hire_date) as month, 
DATENAME(year, hire_date) as year, COUNT(employee_id) as no_of_employee from employee
group by DATENAME(month,Hire_Date), DATENAME(year, hire_date)
order by year asc, month asc;
--5. List out the Department ID having at least four employees.
select department_id, count(employee_id) as no_of_emp from employee
group by Department_Id
having COUNT(employee_id) >=4;
--6. How many employees joined in February month.
select DATENAME(month,hire_date) as month, COUNT(employee_id) as noofemp from employee
group by DATENAME(month,hire_date) 
having DATENAME(month,hire_date) = 'february';

--7.How many employees joined in May or June month.
select DATENAME(month,hire_date) as month, COUNT(employee_id) as noofemp from employee
group by DATENAME(month,hire_date) 
having DATENAME(month,hire_date) in ('may','june');


--8.How many employees joined in 1985?
select DATEPART(year,hire_date) as yr, COUNT(employee_id) 
as noofemployee from employee
group by DATEPART(year, hire_date)
having DATEPART(year,hire_date) = 1985;
--9. How many employees joined each month in 1985.
select DATEname(month,hire_date) as month,DATEPART(year,hire_date) as yr ,
COUNT(employee_id) as noofemployee from employee
group by DATEname(month, hire_date), datepart(year,hire_date)
having DATEPART(year,hire_date) = 1985
order by month asc;
--10. How many employees were joined in April 1985?
select DATEname(month,hire_date) as month,DATEPART(year,hire_date) as yr ,
COUNT(employee_id) as noofemployee from employee
group by DATEname(month, hire_date), datepart(year,hire_date)
having DATEname(month,hire_date) = 'April' and datepart(year,hire_date) = 1985;
--11. Which is the Department ID having greater than 
--or equal to 3 employees joining in April 1985?
select department_id , COUNT(employee_id) as noofemployee from employee
where DATEname(month,hire_date) = 'April' and DATEPART(year,hire_date)= 1985 
 group by  department_id
having count(employee_id)>=3;

--Joins:

--1. List out employees with their department names.
select first_name, last_name, name from employee inner join 
department on employee.department_id = department.department_id;

--2. Display employees with their designations.
select employee_id, designation from employee 
inner join job on employee.job_id = job.job_id;
--3. Display the employees with their department names and city.
select first_name,employee_id, name, city from employee emp inner join department d
on emp.department_id = d.department_id
inner join location on d.location_id = location.location_id;
--4. How many employees are working in different departments? 
--Display with department names.

select count(employee_id) as no_of_employee, name from employee 
inner join department on employee.department_id= department.department_id
group by name;
--5. How many employees are working in the sales department?
select count(employee_id) as noofemployee, name from employee 
inner join department on employee.department_id = department.department_id
where name = 'sales'
group by name;

--6. Which is the department having greater than or equal to 3 employees 
--and display the department names in ascending order.
select count(employee_id) as no_of_employee, name from employee 
inner join department on employee.department_id = department.department_id
group by name
having count(employee_id) >=3;

--7. How many employees are working in 'Dallas'?
select count(employee_id) as no_of_employee, city from employee
inner join department on employee.department_id=department.department_id
inner join location on department.location_id = location.location_id
group by city
having city= 'Dallas';
--8. Display all employees in sales or operation departments.
select count(employee_id) as no_of_employee,name from employee
inner join department on employee.department_id=department.department_id
group by name
having name in ('sales','operation');

--CONDITIONAL STATEMENT
--1. Display the employee details with salary grades. 
--Use conditional statement to create a grade column.
select * , 
case when salary >=2000 then 'A'
when salary between 1000 and 2000 then 'B' else 'C' end as grade
from employee;

--2. List out the number of employees grade wise. 
--Use conditional statement to create a grade column.
select count(employee_id) as no_of_employee, grade from  
(select employee_id, (case when salary >=2000 then 'A'
when salary between 1000 and 2000 then 'B' else 'C' end) as grade
from employee) as abc
group by grade;


--3. Display the employee salary grades and the 
--number of employees between 2000 to 5000 range of salary.
select count(employee_id) as no_of_employee,grade from 
(select employee_id, salary, (case when salary >=2000 then 'A'
when salary between 1000 and 2000 then 'B' else 'C' end) as grade
from employee) as temp
where salary between 2000 and 5000
group by grade;


Subqueries:
--1. Display the employees list who got the maximum salary.
select max(salary) as maximumsalary,employee_id from employee
group by employee_id;

--2. Display the employees who are working in the sales department.
select employee_id, name from employee inner join
department on employee.department_id= department.department_id
where name= 'sales';
--3. Display the employees who are working as 'Clerk'.
select employee_id, designation from employee inner join
job on employee.job_id= job.job_id
where designation= 'clerk';
--4. Display the list of employees who are living in 'Boston'.
select employee_id, city from employee e inner join 
department d on e.department_id = d.department_id
inner join location on d.location_id = location.location_id
where city = 'Boston';
--5. Find out the number of employees working in the sales department.
select count(employee_id) as no_of_employee, name from employee e
inner join department d on e.department_id=d.department_id
where name= 'Sales'
group by name;
--6. Update the salaries of employees who are working as clerks on the basis of 10%.

update employee
set employee.salary = (salary+0.01*salary) from employee
inner join job on employee.job_id=job.job_id
where designation = 'clerk' 
select * from employee;

--7. Display the second highest salary drawing employee details.
with temp 
as

(select * ,dense_rank() over(order by salary desc) 
as denserank from employee)

select * from temp where denserank = 2;
--8. List out the employees who earn more than every employee in department 30.
select * from employee where salary in (select MAX(salary) from employee) and
department_id = 30;


--9. Find out which department has no employees.
select employee_id,department.department_id from employee right join department on
employee.department_id=department.department_id;

--10. Find out the employees who earn greater than 
--the average salary for their department.
select * from employee where Salary > 
(select avg(salary) as avgsalary from employee 
);


