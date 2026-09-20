-- DATABASE SYSTEMS LAB 04
-- Topic: Database Normalization
-- Scenario: Hospital Patient Visits
-- Scope: Normalization Overview and 1NF

CREATE DATABASE IF NOT EXISTS hospital_normalization;

USE hospital_normalization;

-- _______________________
-- DELIVERABLE 1
-- FUNCTIONAL DEPENDENCIES + CANDIDATE KEY
-- _______________________

/*

FUNCTIONAL DEPENDENCIES

1.
VisitID → VisitDate, PatientID, DoctorID, Diagnosis, Fee

2.
PatientID → PatientName, PatientPhone

3.
DoctorID → DoctorName, Specialty, DeptName

4.
DeptName → DeptHead

CANDIDATE KEY

VisitID

*/

-- ___________________
-- DELIVERABLE 2
-- 1NF TABLE
-- ___________________

DROP TABLE IF EXISTS HospitalVisit_1NF;

CREATE TABLE HospitalVisit_1NF (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20),
    DoctorID VARCHAR(10),
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),
    DeptHead VARCHAR(50),
    Diagnosis VARCHAR(100),
    Fee INT
);

INSERT INTO HospitalVisit_1NF VALUES
('V-9001','2026-04-10','P-201','Hassan','0300-1112233',
'D-30','Dr. Imran','Cardiology','Heart Care','Dr. Tariq',
'Hypertension',2500),

('V-9002','2026-04-10','P-202','Mehreen','0301-4445566',
'D-31','Dr. Asma','Dermatology','Skin Clinic','Dr. Asma',
'Eczema',2000),

('V-9003','2026-04-11','P-201','Hassan','0300-1112233',
'D-31','Dr. Asma','Dermatology','Skin Clinic','Dr. Asma',
'Allergy',2000),

('V-9004','2026-04-12','P-203','Junaid','0302-7778899',
'D-30','Dr. Imran','Cardiology','Heart Care','Dr. Tariq',
'Arrhythmia',3000);
