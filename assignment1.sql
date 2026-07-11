


CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);
INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

	CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );
	INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);
	CREATE TABLE Orders 
	(OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)
	INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500);

--1. Insert a new record in your Orders table.
insert into Orders values
(5005, 2010, 111, '2024-10-02', 5000);

select * from salesman
select * from customer
select * from orders

--2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
--constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
--column in Customer table. Add not null constraint in Customer_name column for the
--Customer table.

Alter table salesman
alter column salesmanid int not null;
alter table salesman
add constraint pk_salsmanid_salesman primary key(salesmanid); 
alter table salesman
add constraint df_city_salesman default 'banglore' for city;

alter table customer
add constraint fk_salesmanid_customer foreign key (salesman_id) references salesman(salesmanid);  


alter table customer
alter column customername  varchar (255) not null;

--3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
--amount value greater than 500.
select * from Customer where CustomerName like '%N'or PurchaseAmount > 500;

--4. Using SET operators, retrieve the first result with unique SalesmanId values from two
--tables, and the other result containing SalesmanId with duplicates from two tables.
select SalesmanId from Salesman except select salesman_id from customer
select salesmanid from Salesman union select salesman_id from customer
select SalesmanId from Salesman intersect select salesman_id from customer

--5. Display the below columns which has the matching data Orderdate, Salesman Name, Customer Name, Commission, and City which has the
--range of Purchase Amount between 500 to 1500
select Salesman.name, Customer.CustomerName, Salesman.SalesmanId,
salesman.commission,
Salesman.city from salesman 
inner join customer on Salesman.SalesmanId=Customer.salesman_id
inner join Orders on Salesman.SalesmanId = Orders.salesmanid 
where PurchaseAmount between 500 and 1500;


--6. Using right join fetch all the results from Salesman and Orders table
select * from Salesman right join Orders on Salesman.SalesmanId=Orders.SalesmanId;

