create database TriggersDb
use TriggersDb
---syntax to create DML trigger
--CREATE TRIGGER [schema_name.] trigger_name
--ON [schema_name.] table_name [WITH ENCRYPTION]
--{after INSERT} AS
--[IF UPDATE (column_name)...]
--[{AND | OR} UPDATE (column_name)...]
--<sql_statements>

create table Emps
(Id int primary key,
Fname nvarchar(50),
Lname nvarchar(50),
Designation nvarchar(50),
Salary float,
Doj date)


create table Emp_LogInfo
(LogId int primary key identity,
Id int ,
Fname nvarchar(50),
Lname nvarchar(50),
Designation nvarchar(50),
Salary float,
Doj date,
Log_Action nvarchar(100),
Action_Time date)
select * from Emps
select * from Emp_LogInfo


create trigger afterITrg
on Emps
after insert
as 
begin
declare @id int
declare @fn nvarchar(50)
declare @ln nvarchar(50)
declare @sal nvarchar(50)
declare @desg nvarchar(50)
declare @doj date
declare @action nvarchar(100)
select @id=	Id,@fn=Fname,@ln=Lname,@sal=Salary,@desg=Designation,@doj=DOJ from inserted
select @action='AfterInsert: Record Inserted'

insert into Emp_LogInfo(Id,Fname,Lname,Salary,Designation,Doj,Log_Action,Action_Time)
values 
(@id,@fn,@ln,@sal,@desg,@doj,@action,GETDATE())

if(@@ROWCOUNT>=1)
begin
print 'After Trigger Saya: Record Inserted & Your action has captured in Log_InfoTable'
end 
end

insert into Emps(Id,Fname,Lname,Designation,Salary,Doj) values (1,'Raj', 'Kumar','Manager',98000.5,'12/12/2012')
select * from Emps
select * from Emp_LogInfo


