CREATE DATABASE IF NOT EXISTS joins_lab;
USE joins_lab;
DROP TABLE IF EXISTS Assignment, Project, Employee, Department;
CREATE TABLE Department (
    DeptID    INT PRIMARY KEY,
    DeptName VARCHAR(40) NOT NULL,
    Location VARCHAR(30),
    Budget    DECIMAL(12,2)
);
CREATE TABLE Employee (
    EmpID     INT PRIMARY KEY,
    EmpName    VARCHAR(50) NOT NULL,
    Gender     CHAR(1),
    Salary     DECIMAL(10,2),
    HireDate DATE,
    City     VARCHAR(30),
    ManagerID INT,
    DeptID     INT,
    FOREIGN KEY (DeptID)    REFERENCES Department(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID)
);
CREATE TABLE Project (
    ProjectID    INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    StartDate    DATE,
    EndDate     DATE,
    DeptID     INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
CREATE TABLE Assignment (
    EmpID INT,
      ProjectID     INT,
    HoursPerWeek INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID)     REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
-- Departments
INSERT INTO Department VALUES
(10, 'Engineering', 'Lahore', 5000000),
(20, 'Marketing', 'Karachi', 2000000),
(30, 'Finance',     'Islamabad',3000000),
(40, 'Research',    'Lahore', 4000000),
(50, 'Sales',     'Karachi', NULL); -- new dept, no employees yet-- Employees (NULL ManagerID = top of the hierarchy)
INSERT INTO Employee VALUES
(101,'Ali Khan',    'M', 120000,'2018-03-15','Lahore',    NULL, 10),
(102,'Sara Iqbal', 'F', 95000,'2019-06-01','Lahore',     101, 10),
(103,'Hamza Raza', 'M', 85000,'2020-01-20','Karachi',    101, 10),
(104,'Ayesha Noor', 'F', 110000,'2017-11-10','Karachi', NULL, 20),
(105,'Bilal Ahmed', 'M', 70000,'2021-04-05','Karachi',    104, 20),
(106,'Fatima Sheikh','F', 90000,'2019-09-12','Islamabad', NULL, 30),
(107,'Usman Tariq', 'M', 78000,'2022-02-18','Islamabad', 106, 30),
(108,'Maira Javed', 'F', 115000,'2016-07-22','Lahore',    NULL, 40),
(109,'Zain Abbas', 'M', 60000,'2023-01-09','Lahore',     108, 40),
(110,'Nida Yousaf', 'F', 72000,'2022-08-30',NULL,         108, 40);-- Projects
INSERT INTO Project VALUES
(1001,'Website Revamp', '2024-01-10','2024-06-30', 10),
(1002,'Mobile App',     '2024-03-01','2024-12-31', 10),
(1003,'Brand Campaign', '2024-02-15','2024-05-15', 20),
(1004,'Audit System',    '2024-04-01',NULL,         30),
(1005,'AI Research',     '2024-05-01','2025-04-30', 40),
(1006,'Internal Tool', '2024-06-01','2024-09-30', NULL); -- no dept yet-- Assignments (note: employees 107 and 110 are NOT assigned, project 1006 has no staff)
INSERT INTO Assignment VALUES
(101, 1001, 10),
(102, 1001, 20),
(102, 1002, 15),
(103, 1002, 30),
(104, 1003, 25),
(105, 1003, 40),
(106, 1004, 35),
(108, 1005, 20),
(109, 1005, 30);

-------------------------------------------------------------
-- Task B1
-- Show each employee with their manager
SELECT 
    e.EmpName AS EmployeeName,
    m.EmpName AS ManagerName
FROM Employee e
LEFT JOIN Employee m
    ON e.ManagerID = m.EmpID;


-- Task B2
-- Employees earning more than their direct manager
SELECT 
    e.EmpName AS EmployeeName,
    e.Salary AS EmployeeSalary,
    m.EmpName AS ManagerName,
    m.Salary AS ManagerSalary
FROM Employee e
INNER JOIN Employee m
    ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;


-- Task B3
-- Employees whose manager belongs to another department
SELECT 
    e.EmpName AS EmployeeName,
    m.EmpName AS ManagerName,
    d1.DeptName AS EmployeeDepartment,
    d2.DeptName AS ManagerDepartment
FROM Employee e
INNER JOIN Employee m
    ON e.ManagerID = m.EmpID
INNER JOIN Department d1
    ON e.DeptID = d1.DeptID
INNER JOIN Department d2
    ON m.DeptID = d2.DeptID
WHERE e.DeptID <> m.DeptID;


-- Task B4
-- Employees with their projects and weekly hours
SELECT 
    e.EmpName,
    p.ProjectName,
    a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID;


-- Task B5
-- Assignment details with employee, project, and project department
SELECT 
    e.EmpName,
    p.ProjectName,
    d.DeptName AS ProjectDepartment
FROM Assignment a
INNER JOIN Employee e
    ON a.EmpID = e.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID
INNER JOIN Department d
    ON p.DeptID = d.DeptID;


-- Task B6
-- Employees working on Mobile App
SELECT 
    e.EmpName,
    a.HoursPerWeek
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID
WHERE p.ProjectName = 'Mobile App';


-- Task B7
-- Lahore employees with their assigned projects
-- Include employees with no assignments
SELECT 
    e.EmpName,
    p.ProjectName,
    a.HoursPerWeek
FROM Employee e
LEFT JOIN Assignment a
    ON e.EmpID = a.EmpID
LEFT JOIN Project p
    ON a.ProjectID = p.ProjectID
WHERE e.City = 'Lahore';


-- Task B8
-- Employees working on projects of another department
SELECT DISTINCT
    e.EmpName
FROM Employee e
INNER JOIN Assignment a
    ON e.EmpID = a.EmpID
INNER JOIN Project p
    ON a.ProjectID = p.ProjectID
WHERE e.DeptID <> p.DeptID;


-- Task B9
-- Projects started in 2024 for each department
-- Include departments without such projects
SELECT 
    d.DeptName,
    p.ProjectName,
    p.StartDate
FROM Department d
LEFT JOIN Project p
    ON d.DeptID = p.DeptID
    AND p.StartDate >= '2024-01-01'
    AND p.StartDate < '2025-01-01'
ORDER BY d.DeptID;


-- Task B10
-- Total weekly hours for every employee
-- Include employees with zero hours
SELECT 
    e.EmpID,
    e.EmpName,
    COALESCE(SUM(a.HoursPerWeek), 0) AS TotalHoursPerWeek
FROM Employee e
LEFT JOIN Assignment a
    ON e.EmpID = a.EmpID
GROUP BY e.EmpID, e.EmpName
ORDER BY e.EmpID;
--------------------------------------------------------------------

--                      ----------------------   Assessment Task  ----------------------------


CREATE DATABASE IF NOT EXISTS library_lab;
USE library_lab;
DROP TABLE IF EXISTS Loan, Book, Member, Author;
CREATE TABLE Author (
    AuthorID    INT PRIMARY KEY,
    AuthorName VARCHAR(60) NOT NULL,
    Country     VARCHAR(30)
);
CREATE TABLE Book (
    BookID         INT PRIMARY KEY,
    Title         VARCHAR(80) NOT NULL,
    Genre         VARCHAR(30),
    Price         DECIMAL(8,2),
    AuthorID     INT,
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);
CREATE TABLE Member (
    MemberID    INT PRIMARY KEY,
    MemberName VARCHAR(60) NOT NULL,
    City        VARCHAR(30),
    JoinDate    DATE
);
CREATE TABLE Loan (
    LoanID     INT PRIMARY KEY,
    MemberID    INT,
    BookID     INT,
    LoanDate    DATE,
  ReturnDate DATE,         -- NULL = not yet returned
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);
INSERT INTO Author VALUES
(1,'Jane Austen',     'UK'),
(2,'Chinua Achebe', 'Nigeria'),
(3,'Haruki Murakami', 'Japan'),
(4,'Bapsi Sidhwa',    'Pakistan'),
(5,'Mohsin Hamid',    'Pakistan'),
(6,'Anonymous Writer', NULL); -- no books
INSERT INTO Book VALUES
(101,'Pride and Prejudice','Fiction', 850.00, 1, 1813),
(102,'Emma',             'Fiction', 900.00, 1, 1815),
(103,'Things Fall Apart', 'Fiction', 1100.00, 2, 1958),
(104,'Norwegian Wood',     'Fiction', 1500.00, 3, 1987),
(105,'Kafka on the Shore', 'Fiction', 1700.00, 3, 2002),
(106,'Ice-Candy-Man',     'Fiction', 1200.00, 4, 1988),
(107,'The Reluctant Fundamentalist','Fiction',1300.00, 5, 2007),
(108,'Exit West',         'Fiction', 1450.00, 5, 2017),
(109,'Mystery Title',     'Mystery', 950.00, NULL, 2020); -- no author
INSERT INTO Member VALUES
(201,'Ahmad Raza', 'Lahore',    '2023-01-15'),
(202,'Sara Imran', 'Karachi', '2023-03-20'),
(203,'Bilal Khan', 'Lahore',    '2024-02-10'),
(204,'Fatima Ali', 'Islamabad', '2022-09-05'),
(205,'Hira Yousaf', NULL,        '2024-05-01'); -- no loans yet
INSERT INTO Loan VALUES
(1, 201, 101, '2024-03-01', '2024-03-15'),
(2, 201, 104, '2024-04-10', NULL),
(3, 202, 103, '2024-02-20', '2024-03-05'),
(4, 202, 107, '2024-05-01', NULL),
(5, 203, 105, '2024-04-25', '2024-05-15'),
(6, 204, 102, '2024-01-10', '2024-01-30'),
(7, 204, 108, '2024-06-01', NULL);

-----------------------------------------------------------------------------

-- Question Q1
-- Show every book with its author's name and country
SELECT 
    b.BookID,
    b.Title,
    a.AuthorName,
    a.Country
FROM Book b
INNER JOIN Author a
    ON b.AuthorID = a.AuthorID;


-- Question Q2
-- Show every author with their books
-- Authors without books should also appear
SELECT 
    a.AuthorID,
    a.AuthorName,
    b.Title
FROM Author a
LEFT JOIN Book b
    ON a.AuthorID = b.AuthorID
ORDER BY a.AuthorID;


-- Question Q3
-- Members who have never borrowed a book
SELECT 
    m.MemberID,
    m.MemberName
FROM Member m
LEFT JOIN Loan l
    ON m.MemberID = l.MemberID
WHERE l.LoanID IS NULL;


-- Question Q4
-- Every loan with member, book, and author information
SELECT 
    l.LoanID,
    m.MemberName,
    b.Title,
    a.AuthorName
FROM Loan l
INNER JOIN Member m
    ON l.MemberID = m.MemberID
INNER JOIN Book b
    ON l.BookID = b.BookID
LEFT JOIN Author a
    ON b.AuthorID = a.AuthorID;


-- Question Q5
-- Currently borrowed books
SELECT 
    b.Title,
    m.MemberName,
    m.City
FROM Loan l
INNER JOIN Book b
    ON l.BookID = b.BookID
INNER JOIN Member m
    ON l.MemberID = m.MemberID
WHERE l.ReturnDate IS NULL;


-- Question Q6
-- Pakistani authors and their books
-- Include Pakistani authors without books
SELECT 
    a.AuthorName,
    b.Title
FROM Author a
LEFT JOIN Book b
    ON a.AuthorID = b.AuthorID
WHERE a.Country = 'Pakistan';


-- Question Q7
-- Every book with members who borrowed it
-- Include books never borrowed
SELECT 
    b.BookID,
    b.Title,
    m.MemberName
FROM Book b
LEFT JOIN Loan l
    ON b.BookID = l.BookID
LEFT JOIN Member m
    ON l.MemberID = m.MemberID
ORDER BY b.BookID;


-- Question Q8
-- Authors whose books have never been borrowed
SELECT DISTINCT
    a.AuthorID,
    a.AuthorName
FROM Author a
INNER JOIN Book b
    ON a.AuthorID = b.AuthorID
LEFT JOIN Loan l
    ON b.BookID = l.BookID
WHERE l.LoanID IS NULL;


-- Question Q9
-- FULL OUTER JOIN of Author and Book using UNION
SELECT 
    a.AuthorID,
    a.AuthorName,
    b.BookID,
    b.Title
FROM Author a
LEFT JOIN Book b
    ON a.AuthorID = b.AuthorID

UNION

SELECT 
    a.AuthorID,
    a.AuthorName,
    b.BookID,
    b.Title
FROM Author a
RIGHT JOIN Book b
    ON a.AuthorID = b.AuthorID;


-- Question Q10
-- Members who borrowed books written by Pakistani authors
SELECT 
    m.MemberName,
    b.Title,
    a.AuthorName
FROM Loan l
INNER JOIN Member m
    ON l.MemberID = m.MemberID
INNER JOIN Book b
    ON l.BookID = b.BookID
INNER JOIN Author a
    ON b.AuthorID = a.AuthorID
WHERE a.Country = 'Pakistan';

