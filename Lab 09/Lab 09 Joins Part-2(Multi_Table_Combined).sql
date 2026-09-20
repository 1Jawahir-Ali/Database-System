-- DATABASE SYSTEMS LAB
-- Topic: Joins
-- Scenario: Library Database

CREATE DATABASE IF NOT EXISTS library_lab;

USE library_lab;

DROP TABLE IF EXISTS Loan, Book, Member, Author;

-- AUTHOR TABLE
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(60) NOT NULL,
    Country VARCHAR(30)
);

-- BOOK TABLE
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(80) NOT NULL,
    Genre VARCHAR(30),
    Price DECIMAL(8,2),
    AuthorID INT,
    PublishedYear INT,

    FOREIGN KEY (AuthorID)
    REFERENCES Author(AuthorID)
);

-- MEMBER TABLE
CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    MemberName VARCHAR(60) NOT NULL,
    City VARCHAR(30),
    JoinDate DATE
);

-- LOAN TABLE
CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    LoanDate DATE,
    ReturnDate DATE,

    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID),

    FOREIGN KEY (BookID)
    REFERENCES Book(BookID)
);

-- INSERT INTO AUTHOR
INSERT INTO Author VALUES
(1,'Jane Austen','UK'),
(2,'Chinua Achebe','Nigeria'),
(3,'Haruki Murakami','Japan'),
(4,'Bapsi Sidhwa','Pakistan'),
(5,'Mohsin Hamid','Pakistan'),
(6,'Anonymous Writer',NULL);

-- INSERT INTO BOOK
INSERT INTO Book VALUES
(101,'Pride and Prejudice','Fiction',850.00,1,1813),
(102,'Emma','Fiction',900.00,1,1815),
(103,'Things Fall Apart','Fiction',1100.00,2,1958),
(104,'Norwegian Wood','Fiction',1500.00,3,1987),
(105,'Kafka on the Shore','Fiction',1700.00,3,2002),
(106,'Ice-Candy-Man','Fiction',1200.00,4,1988),
(107,'The Reluctant Fundamentalist','Fiction',1300.00,5,2007),
(108,'Exit West','Fiction',1450.00,5,2017),
(109,'Mystery Title','Mystery',950.00,NULL,2020);

-- INSERT INTO MEMBER
INSERT INTO Member VALUES
(201,'Ahmad Raza','Lahore','2023-01-15'),
(202,'Sara Imran','Karachi','2023-03-20'),
(203,'Bilal Khan','Lahore','2024-02-10'),
(204,'Fatima Ali','Islamabad','2022-09-05'),
(205,'Hira Yousaf',NULL,'2024-05-01');

-- INSERT INTO LOAN
INSERT INTO Loan VALUES
(1,201,101,'2024-03-01','2024-03-15'),
(2,201,104,'2024-04-10',NULL),
(3,202,103,'2024-02-20','2024-03-05'),
(4,202,107,'2024-05-01',NULL),
(5,203,105,'2024-04-25','2024-05-15'),
(6,204,102,'2024-01-10','2024-01-30'),
(7,204,108,'2024-06-01',NULL);

-- LAB 09 — Joins Part 02
-- Self Joins, Multi-table Joins, and Combined Challenges

-- Note:
-- The supplied library lab does not contain a separate
-- SELF JOIN question. The following questions are the
-- multi-table and combined join challenges from the original lab.

-- Q4
-- List every loan with member name,
-- book title, and author name
-- 3-table join

SELECT
    l.LoanID,
    m.MemberName,
    b.Title,
    a.AuthorName
FROM Loan l
JOIN Member m
ON l.MemberID = m.MemberID
JOIN Book b
ON l.BookID = b.BookID
JOIN Author a
ON b.AuthorID = a.AuthorID;

-- Q5
-- List currently borrowed books

SELECT
    b.Title,
    m.MemberName,
    m.City
FROM Loan l
JOIN Member m
ON l.MemberID = m.MemberID
JOIN Book b
ON l.BookID = b.BookID
WHERE l.ReturnDate IS NULL;

-- Q7
-- List every book together with names
-- of all members who borrowed it
-- Include books never borrowed

SELECT
    b.Title,
    m.MemberName
FROM Book b
LEFT JOIN Loan l
ON b.BookID = l.BookID
LEFT JOIN Member m
ON l.MemberID = m.MemberID;

-- Q8
-- Find authors whose books
-- have never been borrowed

SELECT DISTINCT
    a.AuthorName
FROM Author a
JOIN Book b
ON a.AuthorID = b.AuthorID
LEFT JOIN Loan l
ON b.BookID = l.BookID
WHERE l.LoanID IS NULL;

-- Q10
-- List members who borrowed books
-- written by Pakistani authors

SELECT
    m.MemberName,
    b.Title,
    a.AuthorName
FROM Loan l
JOIN Member m
ON l.MemberID = m.MemberID
JOIN Book b
ON l.BookID = b.BookID
JOIN Author a
ON b.AuthorID = a.AuthorID
WHERE a.Country = 'Pakistan';
