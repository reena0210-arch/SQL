--Tasks to be performed:
select * from jomato;
--1. Create a stored procedure to display the restaurant name, type and cuisine where the
--table booking is not zero.
create procedure pr_01 (@tablebooking int)
as 
begin
select restaurantname,restaurantType,CuisinesType,tablebooking from jomato
where tablebooking = @tablebooking 
end

exec pr_01 1
--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result
--and rollback it.
begin transaction
update jomato  set
CuisinesType = replace(CuisinesType,  'Cafe', 'Cafeteria') 
where  CuisinesType like '%Cafe%';

rollback transaction

 select * from jomato
--3. Generate a row number column and find the top 5 areas with the highest rating of
--restaurants.
select top 5 ROW_NUMBER() over (order by rating desc) as index_no, * from jomato;

--4. Use the while loop to display the 1 to 50.
create or alter procedure pr_02 (@x int)
as
begin
      while (@x<=50)
	  begin
         print @x 
		 set @x = @x+1
	   
	 end
End
exec pr_02 1

--5. Write a query to Create a Top rating view to store the generated top 5 highest rating of
--restaurants.
create or alter view v_01 

as 
    select top 5 ROW_NUMBER() 
       over(order by rating desc) as index_no,*
       from jomato

select * from v_01

--6.  Write a trigger that sends an email notification to the restaurant owner whenever a new
--record is inserted.

create or alter trigger tr_01 on jomato for insert
as 
begin
    print 'It is an new record'
end
select * from jomato
insert into jomato (OrderId,RestaurantName, RestaurantType,No_of_Rating,
OnlineOrder, TableBooking,CuisinesType,area,localaddress,Delivery_time) values
(8000,'cakes & bakes', 'cafeteria',1050,1,0,'chair','durgapura', 'madhav nagar', 57)
