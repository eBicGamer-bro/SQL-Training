Create Database OnlineCoursePlatform;

Create Table Students (
	
	StudentID INT PRIMARY KEY IDENTITY(1,1),
	Name Varchar(250) NOT NULL,
	Email Varchar(250) NOT NULL UNIQUE,
	Age INT NOT NULL Check (Age>=16),
	Country Varchar(100) NOT NULL Default 'Egypt'
);


Create Table Courses (
	
	CourseID INT PRIMARY KEY IDENTITY(1,1),
	CourseName Varchar(250) NOT NULL,
	Category Varchar(250) NOT NULL,
	Price DECIMAL(10,2) NOT NULL Check (Price>0)
);

Create Table Enrollments (
	
	EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
	StudentID INT NOT NULL,
	CourseID INT NOT NULL,
	EnrollDate DATETIME NOT NULL DEFAULT GETDATE()
);

Insert Into [dbo].[Students] (Name, Email, Age, Country) 
Values ('Alice Johnson', 'Alice@gmail.com',22, 'USA'),
	   ('Bob Smith', 'Bob@gmail.com', 25, 'USA'),
	   ('Charlie Brown', 'Charlie@gmail.com', 30, 'UK'),
	   ('Eve Davis', 'Eve@gmail.com',34, 'Canada'),
	   ('Ahmed Mohamed', 'Ahmed@gmail.com', 27, 'USA');


Insert Into [dbo].[Students] (Name, Email, Age) 
Values ('David Lee', 'David@Gmail.com', 28);

Insert Into [dbo].[Courses] (CourseName, Category, Price)
Values ('Introduction to Python', 'Programming', 49.99),
	   ('Data Science Fundamentals', 'Data Science', 79.99),
	   ('Web Development Bootcamp', 'Web Development', 59.99),
	   ('Machine Learning A-Z', 'Machine Learning', 89.99),
	   ('Digital Marketing Masterclass', 'Marketing', 99.99);

Insert Into [dbo].[Enrollments] (StudentID, CourseID)
Values (1, 1),
	   (1, 2),
	   (2, 1),
	   (3, 3),
	   (4, 4),
	   (5, 5),
	   (6, 2);

Select * From [dbo].[Students] WHERE Country = 'USA' Order BY age;


Select * From [dbo].[Students] WHERE Age Between 20 and 30;

Alter Table [dbo].[Students] Add CreatedDate DATETIME NOT NULL DEFAULT GETDATE();

Alter Table [dbo].[Courses] DROP Constraint CK__Courses__Price__619B8048;
EXEC sp_rename '[dbo].[Courses].Price', 'Courses_Price', 'COLUMN'; --this does not work as there is a check constraint on the price column. Which is why I removed the constraint then readded it after renaming.
Alter Table [dbo].[Courses] ADD Constraint Courses_Price Check (Courses_Price>0);


SELECT TOP 3 * FROM [dbo].[Enrollments];