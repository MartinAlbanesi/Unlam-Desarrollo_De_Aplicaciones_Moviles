DROP TABLE Emp
CREATE DATABASE pruebaTransacciones

   CREATE TABLE Emp(ID int,Name Varchar(50),Salary Int);
   INSERT INTO Emp(ID,Name,Salary) values( 1,'David',1000)
   INSERT INTO Emp(ID,Name,Salary) values( 2,'Steve',2000)
   INSERT INTO Emp(ID,Name,Salary) values( 3,'Chris',3000)  


--Read Uncommitted
begin tran
       update emp set Salary=999 where ID=1
       waitfor delay '00:00:15'
Rollback


--Read Committed
begin tran
       update emp set Salary=999 where ID=1
       waitfor delay '00:00:15'
Rollback


--Read Committed 
--ejemplo 2: 
--Sesión 1
begin tran
       select * from Emp
       waitfor delay '00:00:15'
Commit

--Repeatable Read ejemplo 1: 
--Sesión 1
set transaction isolation level repeatable read
begin tran
   select * from emp where ID in(1,2)
   waitfor delay '00:00:15'
   select * from Emp where ID in (1,2)
Rollback


--Repeatable Read 
--ejemplo 2:
--Sesión 1
set transaction isolation level repeatable read
begin tran
   select * from emp
   waitfor delay '00:00:15'
   select * from Emp
Rollback


--Serializable
--ejemplo 1
set transaction isolation level serializable
begin tran
   select * from emp
   waitfor delay '00:00:15'
   select * from Emp
Rollback


