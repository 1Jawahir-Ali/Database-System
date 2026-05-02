#  Hospital Patient Visit Normalization (UNF → 3NF)

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

 So, we move to **2NF** to remove partial dependencies.

## Second Normal Form (2NF)
### Rule:
* Must be in 1NF
* Remove **partial dependencies**
### What we did:
* Separated data into multiple tables:
  * **Patient Table**
  * **Doctor Table**
  * **Visit Table**

### Why?

* Patient info depends only on PatientID
* Doctor info depends only on DoctorID
  
###  Key Idea:
* Table must be in **1NF**
* All non-key attributes must depend on the **whole primary key**

## 2NF Tables
### Patient Table

| PatientID | PatientName | PatientPhone |
| --------- | ----------- | ------------ |
| P-201     | Hassan      | 0300-1112233 |
| P-202     | Mehreen     | 0301-4445566 |
| P-203     | Junaid      | 0302-7778899 |

###  Doctor Table

| DoctorID | DoctorName | Specialty   |
| -------- | ---------- | ----------- |
| D-30     | Dr. Imran  | Cardiology  |
| D-31     | Dr. Asma   | Dermatology |

###  Visit Table

| VisitID | VisitDate  | PatientID | DoctorID | Diagnosis    | Fee  |
| ------- | ---------- | --------- | -------- | ------------ | ---- |
| V-9001  | 2026-04-10 | P-201     | D-30     | Hypertension | 2500 |
| V-9002  | 2026-04-10 | P-202     | D-31     | Eczema       | 2000 |
| V-9003  | 2026-04-11 | P-201     | D-31     | Allergy      | 2000 |
| V-9004  | 2026-04-12 | P-203     | D-30     | Arrhythmia   | 3000 |


## Still Problem in 2NF

* **Transitive dependency still exists**

  * Specialty → DeptName, DeptHead
* Department data is still indirectly dependent on VisitID

 Therefore, we move to **3NF** to remove transitive dependency.

## Improvement from 1NF

* ✔ Reduced redundancy
* ✔ Data split into logical tables
* ✔ Better structure than 1NF
*  Still not fully normalized


Next step: **3NF (final optimized design)**

### Result:
* Reduced redundancy
* Better data organization
* Still contains **transitive dependency**


## Third Normal Form (3NF)

### Rule:
* Must be in 2NF
* Remove **transitive dependencies**

### What we did:
* Created a separate **Department table**
* Linked Doctor → Department using foreign key

### Why?

* Department data depends on Specialty, not directly on VisitID
##  Third Normal Form (3NF)

After applying 3NF, we remove **transitive dependencies** and split the data into multiple related tables.

###  Key Idea:

* Every non-key attribute depends **only on the primary key**
* No dependency on another non-key attribute



##  Final 3NF Tables

###  Patient Table

| PatientID | PatientName | PatientPhone |
| --------- | ----------- | ------------ |
| P-201     | Hassan      | 0300-1112233 |
| P-202     | Mehreen     | 0301-4445566 |
| P-203     | Junaid      | 0302-7778899 |


### Department Table

| DeptID | DeptName    | DeptHead  |
| ------ | ----------- | --------- |
| 1      | Heart Care  | Dr. Tariq |
| 2      | Skin Clinic | Dr. Asma  |



### Doctor Table

| DoctorID | DoctorName | Specialty   | DeptID |
| -------- | ---------- | ----------- | ------ |
| D-30     | Dr. Imran  | Cardiology  | 1      |
| D-31     | Dr. Asma   | Dermatology | 2      |



### Visit Table

| VisitID | VisitDate  | PatientID | DoctorID | Diagnosis    | Fee  |
| ------- | ---------- | --------- | -------- | ------------ | ---- |
| V-9001  | 2026-04-10 | P-201     | D-30     | Hypertension | 2500 |
| V-9002  | 2026-04-10 | P-202     | D-31     | Eczema       | 2000 |
| V-9003  | 2026-04-11 | P-201     | D-31     | Allergy      | 2000 |
| V-9004  | 2026-04-12 | P-203     | D-30     | Arrhythmia   | 3000 |


## Benefits of 3NF

* ✔ No redundancy (data stored only once)
* ✔ No update anomalies
* ✔ No insertion anomalies
* ✔ No deletion anomalies
* ✔ Clean and scalable database design

 Final structure follows proper relationships using **Primary Keys and Foreign Keys**, making the database efficient and reliable.

## Final Result:
* No redundancy
* No anomalies
* Clean relational structure using:

  * Patient
  * Doctor
  * Department
  * Visit

## Conclusion

By converting the hospital data step-by-step from **UNF → 1NF → 2NF → 3NF**, we achieved:

* ✔ Elimination of redundancy
* ✔ Removal of anomalies
* ✔ Improved data integrity
* ✔ Efficient and scalable database design

## Author

_**Jawahir Ali**_ | _**Roll No:2024-SE-34**_
