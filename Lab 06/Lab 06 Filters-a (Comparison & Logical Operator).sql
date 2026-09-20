-- DATABASE SYSTEMS LAB
-- Online Bookstore - SQL Filters

CREATE DATABASE IF NOT EXISTS bookstore_lab;
USE bookstore_lab;

DROP TABLE IF EXISTS Book;

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(80) NOT NULL,
    Author VARCHAR(60),
    Genre VARCHAR(30),
    Price DECIMAL(8,2),
    StockQty INT,
    PublishedYear INT,
    Publisher VARCHAR(40),
    Language VARCHAR(20)
);

INSERT INTO Book VALUES
(1,'Pride and Prejudice','Jane Austen','Fiction',850,12,1813,'Penguin','English'),
(2,'Emma','Jane Austen','Fiction',900,8,1815,'Penguin','English'),
(3,'Things Fall Apart','Chinua Achebe','Fiction',1100,5,1958,'Heinemann','English'),
(4,'Norwegian Wood','Haruki Murakami','Fiction',1500,3,1987,'Vintage','English'),
(5,'Kafka on the Shore','Haruki Murakami','Fiction',1700,0,2002,'Vintage','English'),
(6,'Ice-Candy-Man','Bapsi Sidhwa','Fiction',1200,15,1988,'Penguin','English'),
(7,'The Reluctant Fundamentalist','Mohsin Hamid','Fiction',1300,9,2007,'Penguin','English'),
(8,'Exit West','Mohsin Hamid','Fiction',1450,6,2017,'Riverhead','English'),
(9,'Atomic Habits','James Clear','Self-help',1800,20,2018,'Avery','English'),
(10,'The Power of Habit','Charles Duhigg','Self-help',1600,11,2012,'Random House','English'),
(11,'Sapiens','Yuval Harari','History',2200,7,2011,'Harper','English'),
(12,'Rich Dad Poor Dad','Robert Kiyosaki','Finance',1100,25,1997,'Plata','English'),
(13,'Aab-e-Hayat','Ibn-e-Safi','Mystery',650,18,1955,'Asrar','Urdu'),
(14,'Raja Gidh','Bano Qudsia','Fiction',900,14,1981,'Sang-e-Meel','Urdu'),
(15,'Mystery Title',NULL,'Mystery',950,4,2020,NULL,'English');

-- LAB 06 — Filters Part 01: Comparison & Logical Operators

-- Q1
-- List all books with a price greater than 1500.
-- Show Title and Price.

SELECT Title, Price FROM Book
WHERE Price > 1500;

-- Q8
-- Show the 3 most expensive books in stock.
-- Uses a comparison condition (StockQty > 0).

SELECT *FROM Book
WHERE StockQty > 0
ORDER BY Price DESC
LIMIT 3;

-- Q9
-- Display all books written in Urdu,
-- sorted by published year ascending.

SELECT *FROM Book
WHERE Language = 'Urdu'
ORDER BY PublishedYear ASC;

-- Q10
-- List books published before the year 2000
-- with a price under 1200,
-- sorted by genre and then by title.

SELECT *FROM Book
WHERE PublishedYear < 2000
AND Price < 1200
ORDER BY Genre ASC, Title ASC;
