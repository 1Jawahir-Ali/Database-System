/*
  DATABASE SYSTEMS - LAB 04
  Topic: Database Normalization and First Normal Form (1NF)

  This lab covers:
    PART A - Online Bookstore
      1. Normalization overview
      2. Functional dependencies
      3. Database anomalies
      4. Conversion of raw data into 1NF
-------------------------------------------------------------
    PART B - Hospital Patient Visits
      1. Functional dependencies
      2. Candidate key
      3. Conversion of the given data into 1NF
*/
/*  PART A - ONLINE BOOKSTORE    */
DROP DATABASE IF EXISTS bookstore_lab;
CREATE DATABASE bookstore_lab;
USE bookstore_lab;

/* ------------------------------------------------------------
   NORMALIZATION OVERVIEW
   ------------------------------------------------------------
   Database normalization is a process used to organize data
   into suitable tables and reduce unnecessary duplication.

   Main purposes of normalization:
   1. Reduce data redundancy.
   2. Improve data consistency.
   3. Avoid insertion, update and deletion anomalies.
   4. Make the database easier to maintain.

   In this lab we focus on:
      - Functional Dependencies
      - Data Anomalies
      - First Normal Form (1NF)

   1NF requires:
      - Each field must contain one atomic value.
      - Repeating groups are not allowed.
      - Each row should be uniquely identifiable.
*/


/*TASK 1 - FUNCTIONAL DEPENDENCIES AND ANOMALIES */

/*
  RAW BOOKSTORE DATA

  OrderID | OrderDate  | CustID | CustName | CustEmail
  ----------------------------------------------------
  O-501   | 2026-04-02 | C-11   | Bilal    | bilal@x.com
  O-502   | 2026-04-03 | C-12   | Areeba   | areeba@x.com
  O-503   | 2026-04-05 | C-11   | Bilal    | bilal@x.com

  Books purchased:

  OrderID | BookID(s)       | BookTitle(s)               |
          |                 | Publisher(s)               |
          |                 | UnitPrice(s) | Qty(s)
  ------------------------------------------------------------
  O-501   | B-1; B-2        | SQL Basics; Python 101     |
          |                 | Pearson; OReilly           |
          |                 | 1200; 1500    | 1; 2

  O-502   | B-1             | SQL Basics                 |
          |                 | Pearson                    |
          |                 | 1200          | 3

  O-503   | B-3; B-2        | Networks; Python 101      |
          |                 | Pearson; OReilly          |
          |                 | 1800; 1500    | 1; 1


  ------------------------------------------------------------
                   FUNCTIONAL DEPENDENCIES
  ------------------------------------------------------------

  FD1:
      OrderID -> OrderDate, CustID

      An order has one order date and belongs to one customer.

  FD2:
      CustID -> CustName, CustEmail

      A customer ID identifies one customer name and email.

  FD3:
      BookID -> BookTitle, Publisher, UnitPrice

      A particular book has one title, publisher and listed price.
  FD4:
      OrderID, BookID -> Qty

      Quantity is related to a particular book within a
      particular order.


  The likely candidate key after converting the data into
  atomic rows is:

      (OrderID, BookID)

  OrderID alone is not enough because an order can contain
  multiple books.

  BookID alone is also not enough because the same book can
  appear in different orders.

  ------------------------------------------------------------
                      ANOMALIES
  ------------------------------------------------------------

  1. INSERTION ANOMALY

     Suppose a new book B-4, "Data Structures", is added to
     the bookstore but nobody has ordered it yet.

     In the current design, there is no suitable order row in
     which this book can be stored. Therefore book information
     cannot be inserted independently.


  2. UPDATE ANOMALY

     Bilal's email address appears with more than one order.
     If his email changes, all related rows must be updated.

     If one row is forgotten, different email addresses for
     the same customer may exist in the database.


  3. DELETION ANOMALY

     If order O-502 is deleted, Areeba's customer information
     may also disappear because her details are stored together
     with the order.

     Similarly, deleting the only order containing a book may
     remove the only stored information about that book.
*/

-------------------------------------------------------------------
/*  TASK 2 - CONVERSION TO FIRST NORMAL FORM (1NF) */
-------------------------------------------------------------------
/*
  To convert the bookstore data into 1NF, every multi-valued
  cell is separated into individual rows.

  Therefore:

      O-501 + B-1 -> one row
      O-501 + B-2 -> one row
      O-502 + B-1 -> one row
      O-503 + B-3 -> one row
      O-503 + B-2 -> one row

  After conversion, every column contains a single value.

  PRIMARY KEY:

      (OrderID, BookID)

  This combination uniquely identifies a purchased book in
  a particular order.


  1NF STRUCTURE

  OrderID | OrderDate  | CustID | CustName | CustEmail
  BookID  | BookTitle  | Publisher | UnitPrice | Qty
*/


CREATE TABLE OrderBook_1NF
(
    OrderID     VARCHAR(10)   NOT NULL,
    OrderDate   DATE          NOT NULL,
    CustID      VARCHAR(10)   NOT NULL,
    CustName    VARCHAR(50)   NOT NULL,
    CustEmail   VARCHAR(80)   NOT NULL,

    BookID      VARCHAR(10)   NOT NULL,
    BookTitle   VARCHAR(80)   NOT NULL,
    Publisher   VARCHAR(50)   NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL,
    Qty         INT           NOT NULL,

    PRIMARY KEY (OrderID, BookID)
);


/* Insert the atomic 1NF records */

INSERT INTO OrderBook_1NF
(
    OrderID,
    OrderDate,
    CustID,
    CustName,
    CustEmail,
    BookID,
    BookTitle,
    Publisher,
    UnitPrice,
    Qty
)
VALUES
(
    'O-501',
    '2026-04-02',
    'C-11',
    'Bilal',
    'bilal@x.com',
    'B-1',
    'SQL Basics',
    'Pearson',
    1200.00,
    1
),
(
    'O-501',
    '2026-04-02',
    'C-11',
    'Bilal',
    'bilal@x.com',
    'B-2',
    'Python 101',
    'OReilly',
    1500.00,
    2
),
(
    'O-502',
    '2026-04-03',
    'C-12',
    'Areeba',
    'areeba@x.com',
    'B-1',
    'SQL Basics',
    'Pearson',
    1200.00,
    3
),
(
    'O-503',
    '2026-04-05',
    'C-11',
    'Bilal',
    'bilal@x.com',
    'B-3',
    'Networks',
    'Pearson',
    1800.00,
    1
),
(
    'O-503',
    '2026-04-05',
    'C-11',
    'Bilal',
    'bilal@x.com',
    'B-2',
    'Python 101',
    'OReilly',
    1500.00,
    1
);


/* Check the created table */

DESCRIBE OrderBook_1NF;

SELECT *
FROM OrderBook_1NF
ORDER BY OrderID, BookID;


/*
  Expected result: 5 rows.

  Notice that all values are now atomic.

  However, some information is repeated:
    - Bilal's customer information
    - SQL Basics information
    - Python 101 information

  This redundancy is intentionally left in the 1NF table.

  The next normalization stages (2NF and 3NF) are NOT
  performed in this file.
*/


/* ============================================================
   PART B - HOSPITAL PATIENT VISITS
   ============================================================ */

DROP DATABASE IF EXISTS hospital_lab;
CREATE DATABASE hospital_lab;
USE hospital_lab;


/* ============================================================
   DELIVERABLE 1 - FUNCTIONAL DEPENDENCIES AND CANDIDATE KEY
   ============================================================ */

/*
  The given hospital information can be represented as:

  Visit
  (
      VisitID,
      VisitDate,
      PatientID,
      PatientName,
      PatientPhone,
      DoctorID,
      DoctorName,
      Specialty,
      DeptName,
      DeptHead,
      Diagnosis,
      Fee
  )


  ------------------------------------------------------------
  FUNCTIONAL DEPENDENCIES
  ------------------------------------------------------------

  FD1:
      VisitID -> VisitDate, PatientID, DoctorID,
                 Diagnosis, Fee

      Each visit has one date, one patient, one doctor,
      one diagnosis and one consultation fee.


  FD2:
      PatientID -> PatientName, PatientPhone

      A patient ID identifies the patient's name and phone.


  FD3:
      DoctorID -> DoctorName, Specialty, DeptName

      A doctor ID identifies the doctor's basic information
      and department.


  FD4:
      DeptName -> DeptHead

      A department has one department head according to the
      information provided.


  ------------------------------------------------------------
  TRANSITIVE DEPENDENCIES OBSERVED
  ------------------------------------------------------------

  These are noted only for understanding normalization:

      VisitID -> PatientID -> PatientName, PatientPhone

      VisitID -> DoctorID -> DoctorName, Specialty, DeptName

      VisitID -> DoctorID -> DeptName -> DeptHead


  ------------------------------------------------------------
  CANDIDATE KEY
  ------------------------------------------------------------

      VisitID

  VisitID uniquely identifies every consultation.

  PatientID cannot be the key because one patient can have
  multiple visits.

  DoctorID cannot be the key because one doctor can handle
  multiple visits.

  Therefore VisitID is selected as the primary key for the
  1NF table.
*/


/*-------------------------------------------------------------
   DELIVERABLE 2 - HOSPITAL TABLE IN 1NF
  ------------------------------------------------------------- */

/*
  The three supplied views are combined using VisitID.

  Each attribute contains one value only, so the resulting
  table satisfies the atomic-value requirement of 1NF.

  PRIMARY KEY = VisitID
*/


CREATE TABLE Visit_1NF
(
    VisitID       VARCHAR(10)  NOT NULL,
    VisitDate     DATE         NOT NULL,

    PatientID     VARCHAR(10)  NOT NULL,
    PatientName   VARCHAR(50)  NOT NULL,
    PatientPhone  VARCHAR(20)  NOT NULL,

    DoctorID      VARCHAR(10)  NOT NULL,
    DoctorName    VARCHAR(50)  NOT NULL,
    Specialty     VARCHAR(50)  NOT NULL,

    DeptName      VARCHAR(60)  NOT NULL,
    DeptHead      VARCHAR(50)  NOT NULL,

    Diagnosis     VARCHAR(80)  NOT NULL,
    Fee           INT          NOT NULL,

    PRIMARY KEY (VisitID)
);


/* Insert the hospital records */

INSERT INTO Visit_1NF
(
    VisitID,
    VisitDate,
    PatientID,
    PatientName,
    PatientPhone,
    DoctorID,
    DoctorName,
    Specialty,
    DeptName,
    DeptHead,
    Diagnosis,
    Fee
)
VALUES
(
    'V-9001',
    '2026-04-10',
    'P-201',
    'Hassan',
    '0300-1112233',
    'D-30',
    'Dr. Imran',
    'Cardiology',
    'Heart Care',
    'Dr. Tariq',
    'Hypertension',
    2500
),
(
    'V-9002',
    '2026-04-10',
    'P-202',
    'Mehreen',
    '0301-4445566',
    'D-31',
    'Dr. Asma',
    'Dermatology',
    'Skin Clinic',
    'Dr. Asma',
    'Eczema',
    2000
),
(
    'V-9003',
    '2026-04-11',
    'P-201',
    'Hassan',
    '0300-1112233',
    'D-31',
    'Dr. Asma',
    'Dermatology',
    'Skin Clinic',
    'Dr. Asma',
    'Allergy',
    2000
),
(
    'V-9004',
    '2026-04-12',
    'P-203',
    'Junaid',
    '0302-7778899',
    'D-30',
    'Dr. Imran',
    'Cardiology',
    'Heart Care',
    'Dr. Tariq',
    'Arrhythmia',
    3000
);


/* Verify the 1NF table */

DESCRIBE Visit_1NF;

SELECT *
FROM Visit_1NF
ORDER BY VisitID;


/*
  Expected result: 4 rows.

  Every column contains a single atomic value and VisitID
  uniquely identifies each row.

  Some values are repeated, for example:
    - Hassan's patient details
    - Dr. Imran's details
    - Dr. Asma's details
    - Department information

  This is acceptable at the 1NF stage.

  No 2NF or 3NF conversion is performed here.
*/
