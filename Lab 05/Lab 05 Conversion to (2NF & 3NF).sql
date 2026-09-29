/*
DATABASE SYSTEMS - LAB 05
Topic: Second Normal Form (2NF) and Third Normal Form (3NF)

Note:
Run Lab 04 first because this lab uses the 1NF tables created there.
*/

/* =========================================================
   PART A - BOOKSTORE
   ========================================================= */

USE bookstore_db;


/* TASK 3 - Convert Bookstore from 1NF to 2NF */

/*
1NF table:
OrderBook_1NF
Primary Key = (OrderID, BookID)

Partial dependencies:

OrderID -> OrderDate, CustID, CustName, CustEmail

BookID -> BookTitle, Publisher, UnitPrice

(OrderID, BookID) -> Qty

OrderDate, CustID, CustName and CustEmail depend only on OrderID.
BookTitle, Publisher and UnitPrice depend only on BookID.
Qty depends on the complete composite key.

To remove partial dependencies, we create:
Orders_2NF
Book_2NF
OrderItem_2NF
*/

DROP TABLE IF EXISTS OrderItem_2NF;
DROP TABLE IF EXISTS Orders_2NF;
DROP TABLE IF EXISTS Book_2NF;

CREATE TABLE Orders_2NF (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustID VARCHAR(10) NOT NULL,
    CustName VARCHAR(50) NOT NULL,
    CustEmail VARCHAR(80) NOT NULL
);

CREATE TABLE Book_2NF (
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(80) NOT NULL,
    Publisher VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE OrderItem_2NF (
    OrderID VARCHAR(10) NOT NULL,
    BookID VARCHAR(10) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book_2NF(BookID)
);


/* Insert data into 2NF tables */

INSERT INTO Orders_2NF
(OrderID, OrderDate, CustID, CustName, CustEmail)
SELECT DISTINCT
    OrderID, OrderDate, CustID, CustName, CustEmail
FROM OrderBook_1NF;

INSERT INTO Book_2NF
(BookID, BookTitle, Publisher, UnitPrice)
SELECT DISTINCT
    BookID, BookTitle, Publisher, UnitPrice
FROM OrderBook_1NF;

INSERT INTO OrderItem_2NF
(OrderID, BookID, Qty)
SELECT OrderID, BookID, Qty
FROM OrderBook_1NF;


/* Check 2NF */

SELECT * FROM Orders_2NF;
SELECT * FROM Book_2NF;
SELECT * FROM OrderItem_2NF;


/* TASK 4 - Convert Bookstore from 2NF to 3NF */

/*
In Orders_2NF, the following transitive dependency exists:

OrderID -> CustID
CustID -> CustName, CustEmail

Therefore:

OrderID -> CustName, CustEmail

Customer information should be stored separately.

Final 3NF tables:

Customer
Orders
Book
OrderItem
*/

DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Book;


/* Customer table */

CREATE TABLE Customer (
    CustID VARCHAR(10) PRIMARY KEY,
    CustName VARCHAR(50) NOT NULL,
    CustEmail VARCHAR(80) NOT NULL
);


/* Orders table */

CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustID VARCHAR(10) NOT NULL,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);


/* Book table */

CREATE TABLE Book (
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(80) NOT NULL,
    Publisher VARCHAR(50) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);


/* OrderItem table */

CREATE TABLE OrderItem (
    OrderID VARCHAR(10) NOT NULL,
    BookID VARCHAR(10) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);


/* Insert data into 3NF tables */

INSERT INTO Customer
(CustID, CustName, CustEmail)
SELECT DISTINCT
    CustID, CustName, CustEmail
FROM Orders_2NF;

INSERT INTO Orders
(OrderID, OrderDate, CustID)
SELECT
    OrderID, OrderDate, CustID
FROM Orders_2NF;

INSERT INTO Book
(BookID, BookTitle, Publisher, UnitPrice)
SELECT
    BookID, BookTitle, Publisher, UnitPrice
FROM Book_2NF;

INSERT INTO OrderItem
(OrderID, BookID, Qty)
SELECT
    OrderID, BookID, Qty
FROM OrderItem_2NF;


/* Check final Bookstore 3NF tables */

SELECT * FROM Customer;
SELECT * FROM Orders;
SELECT * FROM Book;
SELECT * FROM OrderItem;


/* Verify original bookstore report */

SELECT
    o.OrderID,
    o.OrderDate,
    c.CustID,
    c.CustName,
    c.CustEmail,
    b.BookID,
    b.BookTitle,
    b.Publisher,
    b.UnitPrice,
    oi.Qty
FROM OrderItem oi
JOIN Orders o ON oi.OrderID = o.OrderID
JOIN Customer c ON o.CustID = c.CustID
JOIN Book b ON oi.BookID = b.BookID
ORDER BY o.OrderID, b.BookID;


/* =========================================================
   PART B - HOSPITAL
   ========================================================= */

USE hospital_lab;


/* TASK 3 - Convert Hospital from 1NF to 2NF */

/*
Visit_1NF has a single-column primary key:

VisitID

Since the primary key contains only one attribute, there can
be no partial dependency.

Therefore the Hospital 1NF table is already in 2NF.

No decomposition is required for 2NF.
*/


SELECT * FROM Visit_1NF;


/* TASK 4 - Convert Hospital from 2NF to 3NF */

/*
The following transitive dependencies exist:

PatientID -> PatientName, PatientPhone

DoctorID -> DoctorName, Specialty, DeptName

DeptName -> DeptHead

Therefore the information is separated into:

Patient
Doctor
Department
Visit

Visit keeps information that belongs directly to a visit.
*/


DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Patient;


/* Patient table */

CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(50) NOT NULL,
    PatientPhone VARCHAR(20) NOT NULL
);


/* Department table */

CREATE TABLE Department (
    DeptName VARCHAR(60) PRIMARY KEY,
    DeptHead VARCHAR(50) NOT NULL
);


/* Doctor table */

CREATE TABLE Doctor (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(50) NOT NULL,
    DeptName VARCHAR(60) NOT NULL,
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
);


/* Visit table */

CREATE TABLE Visit (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE NOT NULL,
    PatientID VARCHAR(10) NOT NULL,
    DoctorID VARCHAR(10) NOT NULL,
    Diagnosis VARCHAR(80) NOT NULL,
    Fee INT NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);


/* Insert data into 3NF tables */

INSERT INTO Patient
(PatientID, PatientName, PatientPhone)
SELECT DISTINCT
    PatientID, PatientName, PatientPhone
FROM Visit_1NF;

INSERT INTO Department
(DeptName, DeptHead)
SELECT DISTINCT
    DeptName, DeptHead
FROM Visit_1NF;

INSERT INTO Doctor
(DoctorID, DoctorName, Specialty, DeptName)
SELECT DISTINCT
    DoctorID, DoctorName, Specialty, DeptName
FROM Visit_1NF;

INSERT INTO Visit
(VisitID, VisitDate, PatientID, DoctorID, Diagnosis, Fee)
SELECT
    VisitID,
    VisitDate,
    PatientID,
    DoctorID,
    Diagnosis,
    Fee
FROM Visit_1NF;


/* Check final Hospital 3NF tables */

SELECT * FROM Patient;
SELECT * FROM Department;
SELECT * FROM Doctor;
SELECT * FROM Visit;


/* Verify original hospital report */

SELECT
    v.VisitID,
    v.VisitDate,
    p.PatientID,
    p.PatientName,
    p.PatientPhone,
    d.DoctorID,
    d.DoctorName,
    d.Specialty,
    dp.DeptName,
    dp.DeptHead,
    v.Diagnosis,
    v.Fee
FROM Visit v
JOIN Patient p
    ON v.PatientID = p.PatientID
JOIN Doctor d
    ON v.DoctorID = d.DoctorID
JOIN Department dp
    ON d.DeptName = dp.DeptName
ORDER BY v.VisitID;


/* =========================================================
   SUMMARY
   ========================================================= */

/*
Bookstore:
1NF -> 2NF removes partial dependencies.
2NF -> 3NF removes the Customer transitive dependency.

Final Bookstore tables:
Customer
Orders
Book
OrderItem


Hospital:
1NF -> 2NF requires no decomposition because VisitID
is a single-column key.

2NF -> 3NF removes transitive dependencies by creating:
Patient
Doctor
Department
Visit

The final 3NF design reduces repeated data and helps prevent
insertion, update and deletion anomalies.
*/
