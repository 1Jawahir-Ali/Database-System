-- LAB 12 — Aggregate Functions
-- Submission: RollNo_Aggregates.sql

CREATE DATABASE IF NOT EXISTS uni_lab;
USE uni_lab;

DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(60) NOT NULL,
    City VARCHAR(30),
    EnrollDate DATE
);

CREATE TABLE Course (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(60) NOT NULL,
    Department VARCHAR(30),
    Credits INT,
    Fee DECIMAL(10,2)
);

CREATE TABLE Enrollment (
    EnrollID INT PRIMARY KEY,
    StudentID INT,
    CourseID VARCHAR(10),
    Marks INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Student VALUES
(1001,'Ahmad Raza','Lahore','2022-09-01'),
(1002,'Sara Imran','Karachi','2022-09-01'),
(1003,'Bilal Khan','Lahore','2023-09-01'),
(1004,'Fatima Ali','Islamabad','2022-09-01'),
(1005,'Hira Yousaf',NULL,'2024-09-01'),
(1006,'Zain Abbas','Karachi','2023-09-01'),
(1007,'Mehwish Anwar','Lahore','2022-09-01'),
(1008,'Talha Hussain','Islamabad','2024-09-01'),
(1009,'Areeba Yasin','Lahore','2023-09-01');

INSERT INTO Course VALUES
('CS101','Intro to Programming','Computer Science',3,25000),
('CS201','Database Systems','Computer Science',3,28000),
('CS301','Operating Systems','Computer Science',4,30000),
('MT101','Calculus I','Mathematics',3,22000),
('EE201','Digital Logic','Electrical Engg',3,26000),
('BB301','Marketing Basics','Business',3,24000);

INSERT INTO Enrollment VALUES
(1,1001,'CS101',78,'2022-09-15'),
(2,1001,'CS201',85,'2023-09-15'),
(3,1001,'MT101',90,'2022-09-15'),
(4,1002,'CS101',65,'2022-09-15'),
(5,1002,'CS201',72,'2023-09-15'),
(6,1003,'CS101',88,'2023-09-15'),
(7,1003,'EE201',80,'2023-09-15'),
(8,1004,'MT101',95,'2022-09-15'),
(9,1004,'CS201',70,'2023-09-15'),
(10,1005,'CS101',55,'2024-09-15'),
(11,1006,'CS101',82,'2023-09-15'),
(12,1006,'CS301',76,'2024-09-15'),
(13,1007,'CS201',91,'2023-09-15'),
(14,1007,'CS301',86,'2024-09-15'),
(15,1008,'CS101',60,'2024-09-15'),
(16,1008,'MT101',68,'2024-09-15');

-- Q1
SELECT (SELECT COUNT(*) FROM Student) AS TotalStudents,
       (SELECT COUNT(*) FROM Course) AS TotalCourses;

-- Q2
SELECT COUNT(DISTINCT City) AS DistinctCities
FROM Student WHERE City IS NOT NULL;

-- Q3
SELECT AVG(Marks) AS AverageMarks,
       MIN(Marks) AS MinimumMarks,
       MAX(Marks) AS MaximumMarks
FROM Enrollment;

-- Q4
SELECT City, COUNT(*) AS StudentCount
FROM Student
GROUP BY City
ORDER BY CASE WHEN City IS NULL THEN 1 ELSE 0 END,
         StudentCount DESC;

-- Q5
SELECT Department, COUNT(*) AS CourseCount
FROM Course
GROUP BY Department
ORDER BY CourseCount DESC;

-- Q6
SELECT c.CourseName,
       COUNT(e.StudentID) AS StudentsEnrolled,
       AVG(e.Marks) AS AverageMarks
FROM Course c
LEFT JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

-- Q7
SELECT c.CourseName, AVG(e.Marks) AS AverageMarks
FROM Course c
INNER JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
HAVING AVG(e.Marks) > 80;

-- Q8
SELECT c.Department, SUM(c.Fee) AS TotalFeeRevenue
FROM Course c
INNER JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.Department;

-- Q9
SELECT s.FullName,
       COUNT(e.EnrollID) AS CourseCount,
       AVG(e.Marks) AS AverageMarks
FROM Student s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FullName;

-- Q10
SELECT s.FullName, MAX(e.Marks) AS HighestMark
FROM Student s
INNER JOIN Enrollment e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FullName
HAVING MAX(e.Marks) > 85;

-- Q11
SELECT c.Department, AVG(e.Marks) AS DepartmentAverageMarks
FROM Course c
INNER JOIN Enrollment e ON c.CourseID = e.CourseID
GROUP BY c.Department
HAVING AVG(e.Marks) < 75;

-- Q12
SELECT s.FullName, SUM(c.Fee) AS TotalFee
FROM Student s
INNER JOIN Enrollment e ON s.StudentID = e.StudentID
INNER JOIN Course c ON e.CourseID = c.CourseID
GROUP BY s.StudentID, s.FullName
ORDER BY TotalFee DESC
LIMIT 3;
