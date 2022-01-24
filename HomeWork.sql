Create Database KomptelBaku

use KomptelBaku

Create Table Brands(
	Id int primary key identity,
	Name nvarchar(25) Not Null Check(Len(Name) > 5)
)

Create Table Notebooks(
	Id int primary key identity,
	Name nvarchar(25) Not Null Check(Len(Name) > 5),
	Price smallmoney,
	BrandId int references Brands(Id)
)

Create Table Phones(
	Id int primary key identity,
	Name nvarchar(25) Not Null Check(Len(Name) > 5),
	Price smallmoney,
	BrandId int references Brands(Id)
)

Select * from Notebooks n Join Brands b on b.Id = n.BrandId
Union 
Select * from Phones p Join Brands B ON B.Id = P.Bra

--11) Phone ve Notebook da Id, Name, Price, ve BrandId Olan Butun Datalari Cixardan Query.

Select * From Notebooks 
Union
select * from Phones

--12) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalari Cixardan Query.

Select p.Id, p.Name,p.Price, b.Name 'BrandName' from Phones p
join Brands b
on p.BrandId=b.Id
union all
Select n.Id, n.Name,n.Price, b.Name 'BrandName' from Notebooks n
join Brands b
on n.BrandId=b.Id

--13) Phone ve Notebook da Id, Name, Price, ve Brandin Adini BrandName kimi Olan Butun Datalarin Icinden Price 1000-den Boyuk Olan Datalari Cixardan Query.

select * from (
				Select p.Id, p.Name,p.Price, b.Name 'BrandName' from Phones p
				join Brands b
				on p.BrandId=b.Id
				union all
				Select n.Id, n.Name,n.Price, b.Name 'BrandName' from Notebooks n
				join Brands b
				on n.BrandId=b.Id
				) as tb
where tb.Price>1000

Create Procedure usp_SearchBookByNameOrAuthorFullName
@search nvarchar(25)
as
Begin
Select b.Id, b.Name, (a.Name+' '+a.SurName) 'AuthorFullName' From Books b
Join Authors a
On b.AuthorId = a.Id
Where b.name = @search Or AuthorFullName = @search
End