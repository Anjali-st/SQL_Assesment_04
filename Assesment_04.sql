
---Assesment - 04----------------------------------------
create database Assesment04Db

use Assesment04Db

create table Products
(PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float,
PTax as PPrice*0.10 persisted,
PCompany nvarchar(50),
PQty int check(PQty>=1) default 10
) 

insert into Products (PName,PPrice,PCompany,PQty) values('Smartphone',45000.99,'SamSung',15)
insert into Products (PName,PPrice,PCompany) values('Tablet',89000.99,'Apple')
insert into Products (PName,PPrice,PCompany,PQty) values('Smartphone',15000.99,'Redmi',25)
insert into Products (PName,PPrice,PCompany,PQty) values('Smartphone',35000.99,'HTC',12)
insert into Products (PName,PPrice,PCompany) values('Earbuds',1400.99,'RealMe')
insert into Products (PName,PPrice,PCompany,PQty) values('Earbuds',1500.99,'Xiaomi',20)
insert into Products (PName,PPrice,PCompany) values('Smartwatch',3999.99,'SamSung')
insert into Products (PName,PPrice,PCompany,PQty) values('Earphone',3000.99,'SamSung',55)
insert into Products (PName,PPrice,PCompany,PQty) values('Smartwatch',67000.99,'Apple',8)
insert into Products (PName,PPrice,PCompany,PQty) values('Earbuds',5000.99,'Xiaomi',20)

select * from Products

--Q1

 create procedure usp_ProductDisplay
 with encryption
 as
 begin
 select  PId, PName, PPrice + PTax as PPricewithTax, PCompany, PQty * (PPrice + PTax) as TotalPrice
 from Products
 end

 exec usp_ProductDisplay

 exec sp_helptext usp_ProductDisplay

 --Q2

 create proc usp_TaxofPCompany
    @companyName nvarchar(50),
    @totalTax float output
	with encryption
as
    select @totalTax = SUM(PTax)
    from Products
    where PCompany = @companyName

	declare @totalTax float
	execute usp_TaxofPCompany 'SamSung', @totalTax output
	print @totalTax  

	 exec sp_helptext usp_TaxofPCompany
