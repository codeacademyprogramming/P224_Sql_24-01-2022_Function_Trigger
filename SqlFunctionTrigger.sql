Create Database P224FunctionTrigger

Use P224FunctionTrigger

Create Table Students
(
	Id int primary key identity,
	Name nvarchar(25),
	SurName nvarchar(25)
)

Create Table StudentsArchive
(
	Id int,
	Name nvarchar(25),
	SurName nvarchar(25)
)

Alter Table Students
Add Age int

Insert Into Students(Name, SurName,Age)
Values('Metin','Agayev',18)


Create Function usf_StudenttsTotalAgeByName 
(@SearchName nvarchar(25))
returns int
As
Begin
	declare @result int
	Select @result = SUM(Age) From Students Where Name Like '%'+@SearchName+'%'
	return @result
End

Select dbo.usf_StudenttsTotalAgeByName('Amil') 'Total Age By Name'

Select * From Students Where Age > (Select dbo.usf_StudenttsTotalAgeByName('Amil'))


Create procedure usp_GetStudents
@Age int
As
Begin
	Select * From Students Where Age > @Age
End


Create Trigger BackUpStudentAfterInsert
On Students
after insert
As
Begin

	declare @Id int
	declare @Name nvarchar(25)
	declare @SurName nvarchar(25)

	Select @Id =s.Id  From inserted s
	Select @Name =s.Name  From inserted s
	Select @SurName =s.SurName  From inserted s

	Insert Into StudentsArchive(Id,Name,SurName)
			Values(@Id, @Name, @SurName)

End


Create Trigger BackUpStudentAfterInsertAndUpdateAndDelete
On Students
after insert,update,delete
As
Begin

	declare @Id int
	declare @Name nvarchar(25)
	declare @SurName nvarchar(25)

	Select @Id =s.Id  From inserted s
	Select @Name =s.Name  From inserted s
	Select @SurName =s.SurName  From inserted s

	Select @Id =s.Id  From deleted s
	Select @Name =s.Name  From deleted s
	Select @SurName =s.SurName  From deleted s

	Insert Into StudentsArchive(Id,Name,SurName)
			Values(@Id, @Name, @SurName)

End