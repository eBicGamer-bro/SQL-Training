Create Database CompanyHRSystem;


Create Table Departments (
	DepartmentID int PRIMARY KEY Identity(1,1),
	DepartmentName varchar(50) Not Null Check(len(Trim(DepartmentName))>0)
);


Create Table Employees (--1:N relationship with Departments
	EmployeeID int PRIMARY KEY Identity(1,1),
	Name varchar(50) Not Null Check(len(Trim(Name))>0),
	Address varchar(100) Not Null Check(len(Trim(Address))>0),
	Gmail varchar(50) Not Null Unique Check(len(Trim(Gmail))>0),
	Title varchar(50) Not Null Check(len(Trim(Title))>0),
	DepartmentID int Not Null,
	PhoneNumber Bigint Not Null Unique Check(PhoneNumber >= 201000000000 and PhoneNumber <= 201599999999)
	Foreign Key (DepartmentID) References Departments(DepartmentID)
);

Create Table EmployeeProfiles (--for optional and sensitive information, 1:1 relationship with Employees
	EmployeeID int PRIMARY KEY,
	Age int Not Null Check(Age >= 18 AND Age <= 65),
	Photo varbinary(max),
	Bio varchar(500),
	Salary Decimal(10,2) Not Null Check(Salary > 0),
	Fingerprint varbinary(max) NOT NULL,
	NationalID Bigint NOT NULL Unique Check(NationalID >= 20000000000000 AND NationalID <= 39999999999999),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


Create Table Projects (--1:N relationship with Departments
	ProjectID int PRIMARY KEY Identity(1,1),
	DepartmentID int Not Null,
	ProjectName varchar(100) Not Null Check(len(Trim(ProjectName))>0),
	StartDate datetime Not Null Default GetDate(),
	Foreign Key (DepartmentID) References Departments(DepartmentID)
);

Create Table Tasks (--1:N relationship with Projects and Employees
	TaskID int PRIMARY KEY Identity(1,1),
	TaskName varchar(100) Not Null Check(len(Trim(TaskName))>0),
	TaskDescription varchar(500),
	Completed bit Not Null Default 0,
	ProjectID int Not Null,
	EmployeeID int Not Null,
	FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)

);

Create Table EmployeeProjects (--M:N relationship between Employees and Projects
	EmployeeID int Not Null,
	ProjectID int Not Null,
	AssignedDate datetime Not Null Default GetDate(),
	PRIMARY KEY (EmployeeID, ProjectID),
	FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
	FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

Insert into Departments (DepartmentName) values ('Human Resources'), ('Engineering'), ('Marketing'), ('Sales');

Insert into Employees (Name, Address, Gmail, Title, DepartmentID, PhoneNumber) values 
('Alice Johnson', '123 Main St', 'alice', 'HR Manager', 1, 201111111111),
('Bob Smith', '456 Elm St', 'bob', 'Software Engineer', 2, 201234324567),
('Charlie Brown', '789 Oak St', 'charlie', 'Marketing Specialist', 3, 201555555555),
('David Wilson', '321 Pine St', 'david', 'Sales Representative', 4, 201444444444);


Insert into EmployeeProfiles (EmployeeID, Age, Salary, NationalID,Fingerprint) values 
(1, 35, 75000.00, 20000000000001,0100101),
(2, 28, 90000.00, 20000000000002,1001001),
(3, 32, 60000.00, 20000000000003,1100101),
(4, 45, 55000.00, 20000000000004,0010010);

Insert into Projects (DepartmentID, ProjectName) values 
(2, 'Project Alpha'),
(2, 'Project Beta'),
(3, 'Project Gamma'),
(4, 'Project Delta');

Insert into EmployeeProjects (EmployeeID, ProjectID) values 
(2, 1),
(2, 2),
(3, 3),
(4, 4);

Insert into Tasks (TaskName, TaskDescription, ProjectID, EmployeeID) values 
('Design Database', 'Design the database schema for the project', 1, 2),
('Develop API', 'Develop the backend API for the project', 1, 2),
('Create Marketing Plan', 'Create a marketing plan for the product launch', 3, 3),
('Contact Clients', 'Reach out to potential clients for sales', 4, 4);


Select name, title from Employees where EXISTS(
Select * from EmployeeProfiles where EmployeeProfiles.EmployeeID = Employees.EmployeeID and EmployeeProfiles.Age>30
);

Select * from Employees where DepartmentID = 2;

select min(salary) from EmployeeProfiles;

Select * from Employees where name like 'A%';

Select * from Employees where gmail like '%email%';

Select * from Employees where PhoneNumber is NULL;

Select * from Employees where DepartmentID in (1,2,3);

Select * from EmployeeProfiles Order by Age;

Select * ,
	Case
	When Age < 30 then 'Junior'
	When Age between 30 and 50 then 'Mid-Level'
	Else 'Senior'
	End as AgeGroup
	from EmployeeProfiles;




