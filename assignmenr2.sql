
select * from jomato;
--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick
--Chicken Bites’.

Select STUFF ('quick bites', 1, 5, 'quick chicken') result from jomato ;

--2. Use the function to display the restaurant name and cuisine type which has the
--maximum number of rating.
select restaurantname,cuisinestype, MAX(no_of_rating) as maximumrating
from jomato  
where no_of_rating =(select MAX(no_of_rating) from jomato)
group by restaurantname,cuisinestype



--3.Create a Rating Status column to display the rating as ‘Excellent’ if
 --it has more the 4start rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is above 3
--and below 3.5 and ‘Bad’ if it is below 3 star rating and

alter table jomato
alter column rating numeric(4,2)

SELECT orderid
      ,Rating
	  ,(case  when Rating >= 4.0 then 'excellent'
			  when Rating between 3.5 and 4.0 then 'good' 
			  when Rating between 3.0 and 3.5 then 'Average' 
			  else 'bad' end) as rating_status 
from jomato;

--4. Find the Ceil, floor and absolute values of the rating column and display the currentdate and separately display the year, month_name and day.

select  ABS(rating) as absrating ,
CEILING(averagecost) as roundup, 
FLOOR(averagecost) as rounddown from jomato; 

select getdate() ,DATENAME(year,getdate()) as yr,
DATENAME(month,getdate()) as mon,
DATENAME(day,getdate()) as day;

--5. Display the restaurant type and total average cost using rollup.
select RestaurantType, SUM(averagecost) as total_averagecost from jomato
group by rollup(RestaurantTYPE)
order by RestaurantType;
