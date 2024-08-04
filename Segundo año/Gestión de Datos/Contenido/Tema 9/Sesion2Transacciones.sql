--Read Uncommitted
set transaction isolation level read uncommitted
select Salary from Emp where ID=1


--Read Committed
set transaction isolation level read committed
select Salary from Emp where ID=1



--Read Committed 
--ejemplo 2: 
--Sesión 1
set transaction isolation level read committed
select * from Emp


--Repeatable Read 
--ejemplo 1: 
--Sesión 1
update emp set Salary=999 where ID=1

--Repeatable Read 
--ejemplo 2:
--Sesión 1
insert into Emp(ID,Name,Salary) values( 11,'Stewart',11000)

--Serializable
--ejemplo 1
insert into Emp(ID,Name,Salary) values( 11,'Stewart',11000)


