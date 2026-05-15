# Database Systems Lab 06 - SQL Joins
### Lab Description

This assignment is based on a Library Database Management System.

The purpose of this lab is to practice different types of SQL JOIN operations using multiple related tables.

The database contains the following tables:

- Author
- Book
- Member
- Loan

The assignment demonstrates how relational databases connect data using primary keys and foreign keys.

### Database Schema

#### 1. Author Table
Stores author information.

Columns:
- AuthorID
- AuthorName
- Country

### 2. Book Table
Stores book details.

Columns:
- BookID
- Title
- Genre
- Price
- AuthorID
- PublishedYear

## 3. Member Table
Stores library member information.

Columns:
- MemberID
- MemberName
- City
- JoinDate

### 4. Loan Table
Stores borrowing records.

Columns:
- LoanID
- MemberID
- BookID
- LoanDate
- ReturnDate

## SQL Concepts Used

The following SQL concepts are used in this assignment:

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER JOIN using UNION
- Multi-table JOINs
- Foreign Keys
- WHERE clause
- IS NULL
- DISTINCT
- UNION

### Questions Covered

The assignment contains the following tasks:

1. Books with author names and countries
2. Authors with their books
3. Members who never borrowed books
4. Loan records with member, book, and author details
5. Currently borrowed books
6. Pakistani authors and their books
7. Books with borrowers
8. Authors whose books were never borrowed
9. FULL OUTER JOIN using UNION
10. Members who borrowed books written by Pakistani authors

# Files Included

#### 1. 2024-SE-34_Joins.sql

This file contains:

- Database creation
- Table creation
- Sample data insertion
- All SQL JOIN queries
- Comments for each question
