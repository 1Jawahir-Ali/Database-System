# LAB 04 — Normalization: Overview and 1NF

## Purpose
The purpose of this lab is to understand database normalization and convert an unnormalized hospital patient-visit table into First Normal Form (1NF).

## Topics Covered
- Functional Dependencies
- Candidate Key
- Normalization
- Unnormalized Data
- First Normal Form (1NF)
- Atomic values
- Data redundancy

## Work Performed
- Analyzed the hospital patient-visit dataset
- Identified functional dependencies
- Identified the candidate key
- Converted the original table into 1NF
- Inserted the normalized data using SQL

## Objective
To understand the need for normalization and how 1NF improves the structure of relational data.

##  Hospital Patient Visit Normalization (UNF → 1NF)

## Scenario

A hospital maintains records of patient visits in a single table. Each record contains visit details, patient information, doctor details, department data, diagnosis, and fee.

Initially, all this data is stored in one large table, which leads to redundancy, inconsistency, and anomalies.

## Unnormalized Form (UNF)
The original table stores all information together:

* Patient details (Name, Phone)
* Doctor details (Name, Specialty)
* Department details (DeptName, DeptHead)
* Visit details (Date, Diagnosis, Fee)

### Problems:

* Repeated data (e.g., same patient or doctor appears multiple times)
* Difficult to update (changing one value requires multiple updates)
* Risk of data loss (deleting a visit removes important info)

 This structure is considered **UNF (Unnormalized Form)** because:

* Data is not properly organized
* Multiple dependencies exist in one table
* High redundancy
##  Unnormalized Form (UNF)

The hospital initially stores all data in a single table:

| VisitID | VisitDate  | PatientID | PatientName | PatientPhone | DoctorID | DoctorName | Specialty   | DeptName    | DeptHead  | Diagnosis    | Fee  |
| ------- | ---------- | --------- | ----------- | ------------ | -------- | ---------- | ----------- | ----------- | --------- | ------------ | ---- |
| V-9001  | 2026-04-10 | P-201     | Hassan      | 0300-1112233 | D-30     | Dr. Imran  | Cardiology  | Heart Care  | Dr. Tariq | Hypertension | 2500 |
| V-9002  | 2026-04-10 | P-202     | Mehreen     | 0301-4445566 | D-31     | Dr. Asma   | Dermatology | Skin Clinic | Dr. Asma  | Eczema       | 2000 |
| V-9003  | 2026-04-11 | P-201     | Hassan      | 0300-1112233 | D-31     | Dr. Asma   | Dermatology | Skin Clinic | Dr. Asma  | Allergy      | 2000 |
| V-9004  | 2026-04-12 | P-203     | Junaid      | 0302-7778899 | D-30     | Dr. Imran  | Cardiology  | Heart Care  | Dr. Tariq | Arrhythmia   | 3000 |

### Why this is UNF?

* Data from multiple entities (Patient, Doctor, Department) is stored in one table
* High redundancy (same patient and doctor repeated)
* Contains multiple dependencies in a single relation
* Leads to insertion, update, and deletion anomalies

  
## First Normal Form (1NF)

### Rule:
* All values are **atomic (single value per cell)**
* Each record is uniquely identified using a **Primary Key (VisitID)**

### What we did:

* Ensured each row represents **one visit**
* Assigned **VisitID as Primary Key**
* 
###  1NF Table

| VisitID | VisitDate  | PatientID | PatientName | PatientPhone | DoctorID | DoctorName | Specialty   | DeptName    | DeptHead  | Diagnosis    | Fee  |
| ------- | ---------- | --------- | ----------- | ------------ | -------- | ---------- | ----------- | ----------- | --------- | ------------ | ---- |
| V-9001  | 2026-04-10 | P-201     | Hassan      | 0300-1112233 | D-30     | Dr. Imran  | Cardiology  | Heart Care  | Dr. Tariq | Hypertension | 2500 |
| V-9002  | 2026-04-10 | P-202     | Mehreen     | 0301-4445566 | D-31     | Dr. Asma   | Dermatology | Skin Clinic | Dr. Asma  | Eczema       | 2000 |
| V-9003  | 2026-04-11 | P-201     | Hassan      | 0300-1112233 | D-31     | Dr. Asma   | Dermatology | Skin Clinic | Dr. Asma  | Allergy      | 2000 |
| V-9004  | 2026-04-12 | P-203     | Junaid      | 0302-7778899 | D-30     | Dr. Imran  | Cardiology  | Heart Care  | Dr. Tariq | Arrhythmia   | 3000 |


###  Still Problems in 1NF:

* **Redundancy still exists** (same patient and doctor repeated)
* **Partial and transitive dependencies still present**
* Data is atomic but **not fully normalized yet**
* Efficient and scalable database design

## Author

_**Jawahir Ali**_ | _**Roll No:2024-SE-34**_
