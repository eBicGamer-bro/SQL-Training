Create Database LibraryManagementSystem;

Create Table Books (
	BookID INT PRIMARY KEY IDENTITY(1,1),
	Title NVARCHAR(255) NOT NULL,
	Author NVARCHAR(255) NOT NULL,
	PublishedDate DateTime NOT NULL Default GetDate(),
	Genre VARCHAR(100) NOT NULL,
	Price DECIMAL(10, 2) NOT NULL Check (Price > 0)
);

Create Table Members (
	MemberID INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL UNIQUE,
	PhoneNumber BIGINT NOT NULL Unique Check (PhoneNumber >= 201000000000 and PhoneNumber <= 201599999999)
);

Create Table Borrowing (
	BorrowingID INT PRIMARY KEY IDENTITY(1,1),
	BookID INT NOT NULL,
	MemberID INT NOT NULL,
	BorrowedDate DateTime NOT NULL Default GetDate(),
	DueDate AS DateAdd(day, 14, BorrowedDate),
	IsReturned bit NOT NULL Default 0,
	FOREIGN KEY (BookID) REFERENCES Books(BookID),
	FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

Insert Into [dbo].[Books] (Title, Author, PublishedDate, Genre, Price) Values
('The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10', 'Classic', 10.99),
('To Kill a Mockingbird', 'Harper Lee', '1960-07-11', 'Classic', 8.99),
('1984', 'George Orwell', '1949-06-08', 'Dystopian', 9.99);

Insert Into [dbo].[Members] (Name, Email, PhoneNumber) Values
('John Doe', 'j@gmail.com',201012345678),
('Jane Smith', 'g@gmail.com',201098765432),
('Alice Johnson', 'Alice@gmail.com',201055555555);

Insert Into [dbo].[Borrowing] (BookID, MemberID) Values
(1, 1),
(2, 2),
(3, 3);