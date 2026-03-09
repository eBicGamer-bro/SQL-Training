Create Database LibraryManagementSystem;

Create Table Members (
	MemberID int PRIMARY KEY Identity(1,1),
	Name varchar(255) NOT NULL Check (len(Trim(Name))>0),
	Email varchar(255) NOT NULL Unique Check (len(Trim(Email))>0),
	PhoneNumber Bigint Unique NOT NULL Check (PhoneNumber >= 2010000000000 and PhoneNumber <= 2015999999999)
);

Create Table MemberProfile(--I did not add ID as it had to be unique and at the same time optional which is not possible as if I do not add NOT NULL only one row can be NULL.
	MemberID int PRIMARY KEY,
	Bio varchar(500),
	Photo varbinary(max),
	Age int Check (Age >= 18 and Age <= 100),
	FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

Create Table Authors (--1:N relationship with Books table
	AuthorID int PRIMARY KEY Identity(1,1),
	Name nvarchar(255) NOT NULL Check (len(Trim(Name))>0),
	Age int NOT NULL Check (Age >= 18 and Age <= 100),
	Country varchar(100) NOT NULL Check (len(Trim(Country))>0)
);

Create Table Books (
	BookID int PRIMARY KEY Identity(1,1),
	Title nvarchar(255) NOT NULL Check (len(Trim(Title))>0),
	AuthorID int NOT NULL,
	PublishedDate datetime NOT NULL Default GetDate(),
	Genre varchar(100) NOT NULL Check (len(Trim(Genre))>0),
	Price decimal(10,2) NOT NULL Check (Price >= 0),
	Foreign Key (AuthorID) References Authors(AuthorID)
);


Create Table Borrowing (--M:N relationship between Books and Members tables
	BorrowingID int PRIMARY KEY Identity(1,1),
	BookID int NOT NULL,
	MemberID int NOT NULL,
	BorrowedDate datetime NOT NULL Default GetDate(),
	DueDate AS DateAdd(day, 14, BorrowedDate),
	IsReturned bit NOT NULL Default 0,
	Foreign Key (BookID) References Books(BookID),
	Foreign Key (MemberID) References Members(MemberID)
);

Create Table Categories (
	CategoryID int PRIMARY KEY Identity(1,1),
	CategoryName varchar(100) NOT NULL Check (len(Trim(CategoryName))>0)
);

Create Table BookCategories (--M:N relationship between Books and Categories tables
	BookID int NOT NULL,
	CategoryID int NOT NULL,
	Primary Key (BookID, CategoryID),
	Foreign Key (BookID) References Books(BookID),
	Foreign Key (CategoryID) References Categories(CategoryID)
	);