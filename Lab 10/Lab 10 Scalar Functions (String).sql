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
(101,'Laptop Pro 15',   
  'Electronics', 185000.00, 12, '2023-03-10'),
(102,'Wireless Mouse',    
(103,'USB-C Cable',   
(104,'Office Chair',   
(105,'Standing Desk',   
(106,'Notebook A4',   
'Electronics',    
  'Electronics',   
  'Furniture',    
  'Furniture',    
(107,'Ballpoint Pen 10pk','Stationery',   
(109,'Green Tea Box',   
Topic: Scalar Functions
2500.00, 50, '2022-07-22'),
  800.00, 100,'2021-11-05'),
18500.00, 8, '2023-01-15'),
45000.50, 5, '2024-02-28'),
  'Stationery',   
(108,'Coffee Beans 1kg', 'Grocery',        
  'Grocery',       
(110,'Bluetooth Speaker', 'Electronics',    
  350.00, 200,'2020-04-01'),
  450.00, 150,'2020-04-01'),
1899.99, 30, '2023-09-20'),
  650.00, 45, '2022-12-12'),
7500.00, 18, '2024-05-18');

-- Task A1
-- Remove leading and trailing spaces and show original name
SELECT
    CustID,
    CustName AS OriginalName,
    TRIM(CustName) AS CleanedName
FROM Customer;


-- Task A2
-- Show customer names in uppercase and lowercase
SELECT
    CustID,
    UPPER(CustName) AS UpperName,
    LOWER(CustName) AS LowerName
FROM Customer;


-- Task A3
-- Show trimmed name and number of characters
SELECT
    CustID,
    TRIM(CustName) AS CleanedName,
    CHAR_LENGTH(TRIM(CustName)) AS NameLength
FROM Customer;


-- Task A4
-- Create a greeting for each customer
SELECT
    CustID,
    CONCAT('Dear ', TRIM(CustName), ', welcome!') AS Greeting
FROM Customer;


-- Task A5
-- Extract username from email
SELECT
    CustName,
    SUBSTRING_INDEX(Email, '@', 1) AS Username
FROM Customer
WHERE Email IS NOT NULL;


-- Task A6
-- Extract domain from email
SELECT
    CustName,
    SUBSTRING_INDEX(Email, '@', -1) AS Domain
FROM Customer
WHERE Email IS NOT NULL;


-- Task A7
-- Show first 3 characters of each customer's name
SELECT
    CustID,
    CustName,
    LEFT(TRIM(CustName), 3) AS First3Characters
FROM Customer;


-- Task A8
-- Mask phone numbers
-- Skip customers without a phone number
SELECT
    CustID,
    CustName,
    CONCAT(LEFT(Phone, 4), 'XXX-XXXX') AS MaskedPhone
FROM Customer
WHERE Phone IS NOT NULL;


-- Task A9
-- Replace spaces in product names with hyphens
SELECT
    ProdID,
    REPLACE(ProdName, ' ', '-') AS SlugName
FROM Product;


-- Task A10
-- Pad Product IDs with leading zeros
SELECT
    ProdID,
    LPAD(ProdID, 5, '0') AS PaddedProdID
FROM Product;


-- Task A11
-- Find product names containing 'Pro'
-- and show the position of 'Pro'
SELECT
    ProdID,
    ProdName,
    LOCATE('Pro', ProdName) AS ProPosition
FROM Product
WHERE ProdName LIKE '%Pro%';


-- Task A12
-- Extract the first name from the customer's full name
SELECT
    CustID,
    TRIM(CustName) AS FullName,
    SUBSTRING(
        TRIM(CustName),
        1,
        LOCATE(' ', TRIM(CustName)) - 1
    ) AS FirstName
FROM Customer;
