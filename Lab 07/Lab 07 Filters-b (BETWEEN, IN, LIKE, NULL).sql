CREATE DATABASE IF NOT EXISTS filters_lab;
USE filters_lab;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    JobTitle VARCHAR(40),
    DeptName VARCHAR(40)
);

INSERT INTO Employee
VALUES
(101, 'Ali Khan', 'M', 120000, '2018-03-15', 'Lahore', 'Senior Engineer', 'Engineering'),
(102, 'Sara Iqbal', 'F', 95000, '2019-06-01', 'Lahore', 'Software Engineer', 'Engineering'),
(103, 'Hamza Raza', 'M', 85000, '2020-01-20', 'Karachi', 'Software Engineer', 'Engineering'),
(104, 'Ayesha Noor', 'F', 110000, '2017-11-10', 'Karachi', 'Marketing Lead', 'Marketing'),
(105, 'Bilal Ahmed', 'M', 70000, '2021-04-05', 'Karachi', 'Marketing Exec', 'Marketing'),
(106, 'Fatima Sheikh', 'F', 90000, '2019-09-12', 'Islamabad', 'Accountant', 'Finance'),
(107, 'Usman Tariq', 'M', 78000, '2022-02-18', 'Islamabad', 'Accountant', 'Finance'),
(108, 'Maira Javed', 'F', 115000, '2016-07-22', 'Lahore', 'Research Lead', 'Research'),
(109, 'Zain Abbas', 'M', 60000, '2023-01-09', 'Lahore', 'Research Analyst', 'Research'),
(110, 'Nida Yousaf', 'F', 72000, '2022-08-30', NULL, 'Analyst', 'Research'),
(111, 'Adeel Akhtar', 'M', 88000, '2020-05-14', 'Lahore', 'QA Engineer', 'Engineering'),
(112, 'Sana Malik', 'F', 102000, '2018-12-01', 'Karachi', 'Sales Manager', 'Sales'),
(113, 'Talha Hussain', 'M', 65000, '2023-07-18', 'Islamabad', 'Sales Exec', 'Sales'),
(114, 'Mehwish Anwar', 'F', 80000, '2021-10-25', 'Lahore', 'HR Officer', 'HR'),
(115, 'Imran Shafi', 'M', 125000, '2015-04-30', NULL, 'Director', 'Engineering');


-- B1. Salary between 75,000 and 100,000, lowest salary first
SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Salary BETWEEN 75000 AND 100000
ORDER BY Salary ASC;


-- B2. Employees hired from January 2020 to December 2022
SELECT EmpID, EmpName, HireDate
FROM Employee
WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31'
ORDER BY HireDate ASC;


-- B3. Salary not between 80,000 and 100,000
SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Salary NOT BETWEEN 80000 AND 100000
ORDER BY Salary ASC;


-- B4. Employees from Lahore or Islamabad
-- Sorted by city, then salary from highest to lowest
SELECT EmpID, EmpName, City, Salary
FROM Employee
WHERE City IN ('Lahore', 'Islamabad')
ORDER BY City ASC, Salary DESC;


-- B5. Employees not in Engineering, Sales, or HR
SELECT EmpID, EmpName, DeptName
FROM Employee
WHERE DeptName NOT IN ('Engineering', 'Sales', 'HR');


-- B6. Names starting with 'M'
SELECT EmpName
FROM Employee
WHERE EmpName LIKE 'M%';


-- B7. Names containing the letter 'a'
-- MySQL is normally case-insensitive for this comparison
SELECT EmpID, EmpName
FROM Employee
WHERE EmpName LIKE '%a%';


-- B8. Names ending with 'an'
SELECT EmpID, EmpName
FROM Employee
WHERE EmpName LIKE '%an';


-- B9. Job title contains 'Engineer'
-- but department is not Engineering
SELECT EmpID, EmpName, JobTitle, DeptName
FROM Employee
WHERE JobTitle LIKE '%Engineer%'
  AND DeptName <> 'Engineering';


-- B10. Employees without a recorded city
SELECT EmpID, EmpName
FROM Employee
WHERE City IS NULL;


-- B11. Employees with a recorded city
-- Sorted alphabetically by city
SELECT EmpID, EmpName, City
FROM Employee
WHERE City IS NOT NULL
ORDER BY City ASC;


-- B12. 3 highest paid employees
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 3;


-- B13. 5 most recently hired employees
SELECT EmpID, EmpName, HireDate
FROM Employee
ORDER BY HireDate DESC
LIMIT 5;


-- B14. Bottom 3 salaries
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary ASC
LIMIT 3;


-- B15. Sort by department ascending,
-- then hire date ascending within each department
SELECT EmpID, EmpName, DeptName, HireDate
FROM Employee
ORDER BY DeptName ASC, HireDate ASC;
