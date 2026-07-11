
select * from INFORMATION_SCHEMA.tables
select* from  Continent
select* from  Customers
select* from  Transactions
--1. Display the count of customers in each region who have done the
--transaction in the year 2020.
select region_id, YEAR(txn_date), COUNT(*) as count_of_customers from Customers
inner join Transactions 
on Customers.customer_id=transactions.customer_id
group by  region_id,YEAR(txn_date)
order by region_id



--2. Display the maximum and minimum transaction amount of each transaction type.
select max(txn_amount) as maximum_amount, 
MIN(txn_amount) as minimum_amount from transactions

--3. Display the customer id, region name and transaction amount where
--transaction type is deposit and transaction amount > 2000.
select customers.customer_id, region_name from Continent
inner join Customers
on continent.region_id=Customers.region_id
inner join Transactions 
on Customers.customer_id=transactions.customer_id
where txn_type='deposit' and txn_amount > 2000
group by customers.customer_id, region_name
order by customers.customer_id

--4. Find duplicate records in the Customer table.
select customer_id, COUNT(*) as countofsameid from Customers
group by customer_id
having COUNT(*)>1

--5. Display the customer id, region name, transaction type and transaction
--amount for the minimum transaction amount in deposit.
select Cus.customer_id, region_name, txn_type,txn_amount from Continent con
inner join Customers cus
on cus.region_id= con.region_id
inner join Transactions t
on cus.customer_id= t.customer_id
where txn_amount = (select MIN(txn_amount) from Transactions)

--6. Create a stored procedure to display details of customers in the
--Transaction table where the transaction date is greater than Jun 2020.
create procedure pr_01
as
begin
select * from Transactions
where txn_date > '2020-01-01'
end
exec pr_01





--7***. Create a stored procedure to insert a record in the Continent table.
create OR ALTER procedure pr_02 (@region_id int, @region_name varchar(25))
as
begin
insert into pr_02 (region_id , region_name) values 
(@region_id = 6, @region_name = 'U.S')
END
EXEC PR_02 6,'U.S'
SELECT * FROM Continent
delete from Continent where region_id =6

--8. Create a stored procedure to display the details of transactions that
--happened on a specific day.
create procedure pr_03 (@txn_date date)
as
begin
select * from Transactions
where txn_date=@txn_date
end
exec pr_03 '2020-01-01'


--9. Create a user defined function to add 10% of the transaction amount in a table.
create or alter function fn_01 (@customer_id int)
returns table
as 
return
(select *,(txn_amount+txn_amount*0.1) as new_txn_amount from Transactions
where customer_id= @customer_id)

select * from dbo.fn_01 (1)




--10. Create a user defined function to find the total transaction amount for a
--given transaction type.
create function fn_02 (@txn_type varchar(25))
returns table
as
return
(select SUM(txn_amount) as total_txn_amount from Transactions
where txn_type = @txn_type)

select * from dbo.fn_02('deposit')
select * from dbo.fn_02('withdrawal')




--11. Create a table value function which comprises the columns customer_id,
--region_id ,txn_date , txn_type , txn_amount which will retrieve data from the above table.
create function fn_03 (@customer_id int)
returns table
as
return
(select Customers.customer_id, region_id, txn_date,txn_type , txn_amount from Customers
inner join Transactions 
on Customers.customer_id=Transactions.customer_id
where Customers.customer_id=@customer_id)

select * from dbo.fn_03 (2)



--12.*** Create a TRY...CATCH block to print a region id and region name in a single column.
create or alter procedure pr_04(@region_id int)
as
begin
select * from Continent
where region_id=@region_id
              begin try
				set @region_id=@region_id
                 end try
        begin catch
		
		print('region_id does not exists')
         end catch
end

exec pr_04 10
print(@region_id+'have region name'+'@region_name')
--13. Create a TRY...CATCH block to insert a value in the Continent table.
create procedure pr_06
as 
BEGIN
         begin try

		 end try
		 begin catch
		 end catch
		 t
     




--14. Create a trigger to prevent deleting a table in a database.
create trigger tr_04 on 


--15. Create a trigger to audit the data in a table.
   create trigger tr_06

--16. Create a trigger to prevent login of the same user id in multiple pages.
create trigger tr_05 on customers for login
as
begin
print('already logged multiple times')
end
--17. Display top n customers on the basis of transaction type.
select top 35 ROW_NUMBER()
over(partition by txn_type order by txn_amount),* from Transactions

--18. Create a pivot table to display the total purchase, withdrawal and
--deposit for all the customers.
create 