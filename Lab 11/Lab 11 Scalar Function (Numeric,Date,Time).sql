CREATE DATABASE IF NOT EXISTS scalar_lab;
USE scalar_lab;
DROP TABLE IF EXISTS Product, Customer;
CREATE TABLE Customer (
    CustID    INT PRIMARY KEY,
    CustName VARCHAR(60) NOT NULL,
    Email     VARCHAR(80),
    City     VARCHAR(30),
    Phone     VARCHAR(20),
    JoinDate DATE,
    DOB     DATE
);
CREATE TABLE Product (
    ProdID     INT PRIMARY KEY,
    ProdName    VARCHAR(60) NOT NULL,
    Category    VARCHAR(30),
    Price     DECIMAL(10,2),
    StockQty    INT,
    LaunchDate DATE
);-- Customers (note: extra spaces, mixed case, NULLs - on purpose)
INSERT INTO Customer VALUES
(1, ' Ali Khan ',    'ali.khan@MAIL.com',
'Lahore',    '0300-1112233','2022-01-15','1995-04-12'),
(2, 'Sara Iqbal',     'sara@example.com',    'Karachi',
'0301-4445566','2022-04-22','1998-11-20'),
(3, 'HAMZA RAZA',     'hamza@example.com',
'Lahore',    '0302-7778899','2023-02-10','1997-08-05'),
(4, 'Ayesha Noor',     NULL,                 'Islamabad',
'0303-1234567','2023-05-18','1999-02-14'),
(5, 'bilal ahmed',     'bilal@MAIL.COM',     'Karachi',
'0304-2345678','2023-09-01','2000-06-30'),
(6, 'Fatima Sheikh', 'fatima@example.com',
NULL,        '0305-3456789','2024-01-12','1996-10-25'),
(7, 'Usman Tariq',     'usman@example.com', 'Lahore',    NULL,        
'2024-06-30','2001-03-18'),
(8, 'Maira Javed',     'maira@example.com', 'Islamabad',
'0307-5678901','2024-08-25','1994-12-09');
-- Products
INSERT INTO Product VALUES
    (101,'Laptop Pro 15','Electronics', 185000.00, 12, '2023-03-10'),
    (102,'Wireless Mouse','Electronics',2500.00, 50, '2022-07-22'),
    (103,'USB-C Cable','Electronics',800.00,100,'2021-11-05'),
    (104,'Office Chair', 'Furniture',18500.00, 8, '2023-01-15'),
    (105,'Standing Desk','Furniture',45000.50, 5, '2024-02-28'),
    (106,'Notebook A4','Stationery',  350.00, 200,'2020-04-01'),
    (107,'Ballpoint Pen 10pk','Stationery',  450.00, 150,'2020-04-01'),
    (108,'Coffee Beans 1kg', 'Grocery',  1899.99, 30, '2023-09-20'),
    (109,'Green Tea Box',  'Grocery',    650.00, 45, '2022-12-12'),
    (110,'Bluetooth Speaker', 'Electronics', 7500.00, 18, '2024-05-18');
-- Task B1
-- Apply 15% discount to every product
SELECT
    ProdName,
    Price,
    ROUND(Price * 0.85, 2) AS DiscountedPrice
FROM Product;


-- Task B2
-- Calculate 17% sales tax and final price
SELECT
    ProdName,
    ROUND(Price * 0.17, 2) AS Tax,
    ROUND(Price * 1.17, 2) AS PriceWithTax
FROM Product;


-- Task B3
-- Floor and ceiling of price divided by 1000
SELECT
    ProdName,
    Price,
    FLOOR(Price / 1000) AS FloorVal,
    CEILING(Price / 1000) AS CeilVal
FROM Product;


-- Task B4
-- Round price to nearest hundred
SELECT
    ProdName,
    Price,
    ROUND(Price, -2) AS RoundedPrice
FROM Product;


-- Task B5
-- Products with odd Product IDs
SELECT
    ProdID,
    ProdName
FROM Product
WHERE MOD(ProdID, 2) = 1;


-- Task B6
-- Show joining year, month name, and day of week
SELECT
    CustID,
    CustName,
    YEAR(JoinDate) AS JoinYear,
    MONTHNAME(JoinDate) AS JoinMonth,
    DAYNAME(JoinDate) AS JoinDay
FROM Customer;


-- Task B7
-- Format date of birth as DD-Month-YYYY
SELECT
    CustName,
    DATE_FORMAT(DOB, '%d-%M-%Y') AS FormattedDOB
FROM Customer;


-- Task B8
-- Calculate current age in years
SELECT
    CustName,
    DOB,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM Customer;


-- Task B9
-- Calculate how many days ago each customer joined
SELECT
    CustName,
    JoinDate,
    DATEDIFF(CURDATE(), JoinDate) AS DaysSinceJoin
FROM Customer;


-- Task B10
-- Customers who joined in 2023
SELECT
    CustID,
    CustName,
    JoinDate
FROM Customer
WHERE YEAR(JoinDate) = 2023;


-- Task B11
-- Products launched in Q4
SELECT
    ProdID,
    ProdName,
    LaunchDate
FROM Product
WHERE MONTH(LaunchDate) IN (10, 11, 12);


-- Task B12
-- Customers who joined within the last 6 months
SELECT
    CustID,
    CustName,
    JoinDate
FROM Customer
WHERE JoinDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
  AND JoinDate <= CURDATE();


-- Task B13
-- Calculate product age in days
SELECT
    ProdName,
    LaunchDate,
    DATEDIFF(CURDATE(), LaunchDate) AS AgeInDays
FROM Product;


-- Task B14
-- Date exactly 90 days after launch
SELECT
    ProdName,
    LaunchDate,
    DATE_ADD(LaunchDate, INTERVAL 90 DAY) AS NinetyDaysLater
FROM Product;


-- Task B15
-- Combined customer summary
SELECT
    CONCAT(
        'Hello ',
        UPPER(TRIM(CustName)),
        ', age ',
        TIMESTAMPDIFF(YEAR, DOB, CURDATE()),
        ', joined ',
        DATE_FORMAT(JoinDate, '%b %Y')
    ) AS Summary
FROM Customer;


--------------------------------------------------
--  Assessment Task: Scenario — Employee Database. 
--------------------------------------------------
CREATE DATABASE IF NOT EXISTS emp_lab;
USE emp_lab;
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
    EmpID     INT PRIMARY KEY,
    FullName    VARCHAR(60) NOT NULL,
    Email     VARCHAR(80),
    Phone     VARCHAR(20),
    DOB         DATE,
    HireDate    DATE,
    Salary     DECIMAL(10,2),
    City        VARCHAR(30),
    JobTitle    VARCHAR(40)
);
INSERT INTO Employee VALUES
(2001,' ahmad raza',     'ahmad@firm.com', '0300-1112233','1990-04-12','2018-09-01',
120000.50,'Lahore', 'Senior Engineer'),
(2002,'Sara Imran',     'SARA@FIRM.COM',    '0301-4445566','1992-11-20','2019-03-15',
95000.00,'Karachi', 'Software Engineer'),
(2003,'BILAL KHAN',     'bilal@firm.com', '0302-7778899','1993-08-05','2020-01-20',
85000.75,'Lahore', 'QA Engineer'),
(2004,'Fatima Ali',     NULL,             '0303-1234567','1991-02-14','2017-11-10',
110000.00,'Islamabad','Manager'),
(2005,'Hira Yousaf',     'hira@firm.com',    NULL,         '1995-06-30','2021-04-05',
70000.00,NULL,     'Accountant'),
(2006,'Zain Abbas ',     'zain@firm.com',    '0305-3456789','1994-10-25','2022-08-30',
78000.40,'Karachi', 'Designer'),
(2007,'Mehwish Anwar',    'mehwish@FIRM.com', '0306-4567890','1989-12-09','2016-07-22',
125000.00,'Lahore', 'Director'),
(2008,'Talha Hussain',    'talha@firm.com', '0307-5678901','1996-03-18','2023-01-09',
60000.00,'Islamabad','HR Officer'),
(2009,'Areeba Yasin',     'areeba@firm.com', '0308-6789012','1990-07-22','2019-09-12',
90000.99,'Lahore', 'Analyst'),
(2010,'Hassan Ahmed',     'hassan@firm.com', '0309-7890123','1997-01-30','2024-02-18',
65000.00,'Karachi', 'Junior Developer');

USE emp_lab;

-- Question Q1
-- Trim employee name and convert it to uppercase
SELECT
    EmpID,
    FullName AS OriginalName,
    UPPER(TRIM(FullName)) AS CleanedName
FROM Employee;


-- Question Q2
-- Extract username from recorded emails
SELECT
    FullName,
    SUBSTRING_INDEX(Email, '@', 1) AS Username
FROM Employee
WHERE Email IS NOT NULL;


-- Question Q3
-- Mask phone numbers
-- Skip employees without phone
SELECT
    EmpID,
    FullName,
    CONCAT(LEFT(Phone, 4), 'XXX-XXXX') AS MaskedPhone
FROM Employee
WHERE Phone IS NOT NULL;


-- Question Q4
-- Generate corporate email from employee name
SELECT
    FullName,
    CONCAT(
        LOWER(REPLACE(TRIM(FullName), ' ', '.')),
        '@company.com'
    ) AS GeneratedEmail
FROM Employee;


-- Question Q5
-- Apply 12.5% salary raise
SELECT
    FullName,
    Salary,
    ROUND(Salary * 1.125, 2) AS NewSalary
FROM Employee;


-- Question Q6
-- Round salary down to nearest thousand
SELECT
    FullName,
    Salary,
    FLOOR(Salary / 1000) * 1000 AS RoundedSalary
FROM Employee;


-- Question Q7
-- Calculate current age and years of service
SELECT
    FullName,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS AgeYears,
    TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsOfService
FROM Employee;


-- Question Q8
-- Format HireDate as DD-Mon-YYYY
SELECT
    FullName,
    DATE_FORMAT(HireDate, '%d-%b-%Y') AS FormattedHireDate
FROM Employee;


-- Question Q9
-- Employees hired in 2019 or later
SELECT
    EmpID,
    FullName,
    HireDate
FROM Employee
WHERE YEAR(HireDate) >= 2019;


-- Question Q10
-- Combined employee profile
SELECT
    CONCAT(
        UPPER(TRIM(FullName)),
        ' | ',
        City,
        ' | ',
        JobTitle,
        ' | Joined: ',
        DATE_FORMAT(HireDate, '%d-%b-%Y'),
        ' | Age: ',
        TIMESTAMPDIFF(YEAR, DOB, CURDATE())
    ) AS Profile
FROM Employee;



