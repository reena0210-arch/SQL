create table role
(
id int primary key,
role_name varchar(100)
)

create table user_account
(
id int primary key,
user_name varchar(100),
email varchar(254),
password varchar(200),
password_salt varchar(50) not null,
password_hash_algorithm varchar(50)
)

create table status
( id int primary key,
status_name varchar(100),
is_user_working bit
)

create table user_has_role
(
id int primary key,
role_start_time datetime,
role_end_time datetime not null,
user_account_id int foreign key references user_account(id),
role_id int foreign key references role(id)
)

create table user_has_status
(
id int primary key,
user_start_time datetime,
user_end_time datetime not null,
user_account_id int foreign key references user_account(id),
status_id int foreign key references status(id)
)

insert into role values
(1,'CA'),
(2,'eng');

insert into status values
(101,'working',0),
(102,'selfemp',1)

insert into user_account values
(201,'smit','smit02@gmail.com','14df','sm','nk'),
(202,'john','john10@gmail.com','r56','09d','pl')

insert into user_has_role values
(401,'2026-06-03 09:17','2026-06-03 12:20',201,1),
(402,'2026-06-04 09:00','2026-06-04 14:22',202,2)

insert into user_has_status values
(1100,'2026-06-03 09:17','2026-06-03 12:20',201,101),
(1101,'2026-06-03 09:17','2026-06-03 12:20',202,102)

select * from status
select * from role
select * from user_account
select * from user_has_role
select * from user_has_status