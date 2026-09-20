# LAB 05 — Conversion to 2NF and 3NF

## Purpose
The purpose of this lab is to further normalize the hospital patient-visit database by converting the 1NF design into Second Normal Form (2NF) and Third Normal Form (3NF).
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



