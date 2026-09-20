-- DATABASE SYSTEMS LAB 05
-- Topic: Database Normalization
-- Scenario: Hospital Patient Visits
-- Scope: Conversion to 2NF and 3NF

CREATE DATABASE IF NOT EXISTS hospital_normalization;

USE hospital_normalization;

-- ______________________________
-- DELIVERABLE 3
-- 2NF SCHEMA
-- ______________________________

/*

PARTIAL DEPENDENCIES REMOVED

1.
PatientName and PatientPhone depend only on PatientID

2.
DoctorName, Specialty, DeptName depend only on DoctorID

3.
DeptHead depends only on DeptName

Therefore separate tables are created.

*/

-- ____________________________
-- PATIENT TABLE
-- ___________________________

DROP TABLE IF EXISTS Patient;

CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20)
);

INSERT INTO Patient VALUES
('P-201','Hassan','0300-1112233'),
('P-202','Mehreen','0301-4445566'),
('P-203','Junaid','0302-7778899');

-- ___________________________
-- DOCTOR TABLE
-- ___________________________

DROP TABLE IF EXISTS Doctor;

CREATE TABLE Doctor (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50)
);

INSERT INTO Doctor VALUES
('D-30','Dr. Imran','Cardiology','Heart Care'),
('D-31','Dr. Asma','Dermatology','Skin Clinic');

-- ____________________________
-- DEPARTMENT TABLE
-- ____________________________

DROP TABLE IF EXISTS Department;

CREATE TABLE Department (
    DeptName VARCHAR(50) PRIMARY KEY,
    DeptHead VARCHAR(50)
);

INSERT INTO Department VALUES
('Heart Care','Dr. Tariq'),
('Skin Clinic','Dr. Asma');

-- _____________________________
-- VISIT TABLE
-- _____________________________

DROP TABLE IF EXISTS VisitRecord;

CREATE TABLE VisitRecord (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    DoctorID VARCHAR(10),
    Diagnosis VARCHAR(100),
    Fee INT
);

INSERT INTO VisitRecord VALUES
('V-9001','2026-04-10','P-201','D-30','Hypertension',2500),
('V-9002','2026-04-10','P-202','D-31','Eczema',2000),
('V-9003','2026-04-11','P-201','D-31','Allergy',2000),
('V-9004','2026-04-12','P-203','D-30','Arrhythmia',3000);

-- ___________________________
-- DELIVERABLE 4
-- 3NF SCHEMA WITH FOREIGN KEYS
-- __________________________

DROP TABLE IF EXISTS Visit3NF;
DROP TABLE IF EXISTS Doctor3NF;
DROP TABLE IF EXISTS Department3NF;
DROP TABLE IF EXISTS Patient3NF;

-- _____________________________
-- PATIENT 3NF
-- _____________________________

CREATE TABLE Patient3NF (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20)
);

INSERT INTO Patient3NF VALUES
('P-201','Hassan','0300-1112233'),
('P-202','Mehreen','0301-4445566'),
('P-203','Junaid','0302-7778899');

-- __________________________
-- DEPARTMENT 3NF
-- _________________________

CREATE TABLE Department3NF (
    DeptName VARCHAR(50) PRIMARY KEY,
    DeptHead VARCHAR(50)
);

INSERT INTO Department3NF VALUES
('Heart Care','Dr. Tariq'),
('Skin Clinic','Dr. Asma');

-- ________________________________
-- DOCTOR 3NF
-- ________________________________

CREATE TABLE Doctor3NF (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),

    FOREIGN KEY (DeptName)
    REFERENCES Department3NF(DeptName)
);

INSERT INTO Doctor3NF VALUES
('D-30','Dr. Imran','Cardiology','Heart Care'),
('D-31','Dr. Asma','Dermatology','Skin Clinic');

-- ___________________________
-- VISIT 3NF
-- ___________________________

CREATE TABLE Visit3NF (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    DoctorID VARCHAR(10),
    Diagnosis VARCHAR(100),
    Fee INT,

    FOREIGN KEY (PatientID)
    REFERENCES Patient3NF(PatientID),

    FOREIGN KEY (DoctorID)
    REFERENCES Doctor3NF(DoctorID)
);

INSERT INTO Visit3NF VALUES
('V-9001','2026-04-10','P-201','D-30','Hypertension',2500),

('V-9002','2026-04-10','P-202','D-31','Eczema',2000),

('V-9003','2026-04-11','P-201','D-31','Allergy',2000),

('V-9004','2026-04-12','P-203','D-30','Arrhythmia',3000);

-- 
-- DELIVERABLE 5
-- SINGLE SELECT QUERY TO RECREATE TABLE 8.1
--

SELECT
    v.VisitID,
    v.VisitDate,

    p.PatientID,
    p.PatientName,
    p.PatientPhone,

    d.DoctorID,
    d.DoctorName,
    d.Specialty,

    dept.DeptName,
    dept.DeptHead,

    v.Diagnosis,
    v.Fee

FROM Visit3NF v

JOIN Patient3NF p
ON v.PatientID = p.PatientID

JOIN Doctor3NF d
ON v.DoctorID = d.DoctorID

JOIN Department3NF dept
ON d.DeptName = dept.DeptName;

-- DELIVERABLE 6
-- ANOMALIES ELIMINATED
--

/*

1. INSERTION ANOMALY REMOVED
New patients, doctors, or departments can be added
without creating a visit record.

2. UPDATE ANOMALY REMOVED
Patient phone number or department head can be updated
in only one place.

3. DELETION ANOMALY REMOVED
Deleting a visit does not remove doctor, patient,
or department information.

4. DATA REDUNDANCY REDUCED
Duplicate patient, doctor, and department data
is minimized.

5. DATA INTEGRITY IMPROVED
Foreign keys maintain proper relationships between tables.

*/
