-- Assessment Problem - Scalar Functions
-- Database: emp_lab

CREATE DATABASE IF NOT EXISTS emp_lab;
USE emp_lab;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID       INT PRIMARY KEY,
    FullName    VARCHAR(60) NOT NULL,
    Email       VARCHAR(80),
    Phone       VARCHAR(20),
    DOB         DATE,
    HireDate    DATE,
    Salary      DECIMAL(10,2),
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



-- Q1
-- Display employee names after removing spaces and converting
-- into uppercase.
SELECT 
    EmpID,
    FullName AS OriginalName,
    UPPER(TRIM(FullName)) AS CleanedName
FROM Employee;


-- Q2
-- Extract username from email.
SELECT 
    FullName,
    SUBSTRING_INDEX(Email, '@', 1) AS Username
FROM Employee
WHERE Email IS NOT NULL;


-- Q3
-- Mask phone numbers.
SELECT 
    FullName,
    CONCAT(LEFT(Phone,4), 'XXX-XXXX') AS MaskedPhone
FROM Employee
WHERE Phone IS NOT NULL;


-- Q4
-- Generate corporate emails.
SELECT 
    FullName,
    CONCAT(
        REPLACE(LOWER(TRIM(FullName)), ' ', '.'),
        '@company.com'
    ) AS GeneratedEmail
FROM Employee;


-- Q5
-- Apply 12.5% salary raise.
SELECT 
    FullName,
    Salary,
    ROUND(Salary * 1.125, 2) AS NewSalary
FROM Employee;


-- Q6
-- Round salary down to nearest thousand.
SELECT 
    FullName,
    Salary,
    FLOOR(Salary / 1000) * 1000 AS RoundedSalary
FROM Employee;

-- Q7
-- Calculate current age and years of service.
SELECT 
    FullName,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS AgeYears,
    TIMESTAMPDIFF(YEAR, HireDate, CURDATE()) AS YearsOfService
FROM Employee;

-- 08
-- Format HireDate as DD-Mon-YYYY.
SELECT 
    FullName,
    DATE_FORMAT(HireDate, '%d-%b-%Y') AS FormattedHireDate
FROM Employee;

-- Q9
-- Employees hired in 2019 or later.
SELECT 
    *
FROM Employee
WHERE YEAR(HireDate) >= 2019;


-- Q10
-- Combined Profile Column
SELECT 
    CONCAT(
        UPPER(TRIM(FullName)),
        ' | ',
        IFNULL(City, 'N/A'),
        ' | ',
        JobTitle,
        ' | Joined: ',
        DATE_FORMAT(HireDate, '%d-%b-%Y'),
        ' | Age: ',
        TIMESTAMPDIFF(YEAR, DOB, CURDATE())
    ) AS Profile
FROM Employee;