##  Database Systems Labs
**Instructor:** Engr. Awais Rathore  | **Course:** Database Systems Laboratory  

**Tools Used:** MySQL / MariaDB, SQL Workbench, ER Modeling Tools  

### Overview

This repository contains comprehensive lab work and practical implementations of core Database Systems concepts. It covers everything from fundamental database theory to advanced relational schema design and normalization techniques.

The objective of this lab series is to develop a strong understanding of **how data is structured, managed, and optimized in relational database systems**.

### Key Concepts Covered

#### 1. Data vs Information
- **Data:** Raw, unprocessed facts (e.g., numbers, text)
- **Information:** Processed data that has meaning and context
- Importance of converting raw data into meaningful insights

#### 2. DBMS (Database Management System)
- Definition and purpose of DBMS
- Advantages over traditional file systems:
  - Reduced redundancy
  - Improved data security
  - Efficient data access
  - Data consistency and integrity
#### 3. Database Languages

#### 🔹 DDL (Data Definition Language)
Used for schema creation and structure definition:
- `CREATE TABLE`
- `ALTER TABLE`
- Constraints (Primary Key, Foreign Key, etc.)

#### 🔹 DML (Data Manipulation Language)
Used for data operations:
- `INSERT INTO`
- `UPDATE`
- `DELETE`
- `SELECT`

#### 🔹 TCL (Transaction Control Language)
Used for transaction management:
- `START TRANSACTION`
- `COMMIT`
- `ROLLBACK`

#### 🔗 4. Relational Data Model
- Structure based on tables (relations)
- Key components:
  - Entities
  - Attributes (simple, composite, derived, multivalued)
  - Relationships (1:1, 1:M, M:M)
- Schema design and relational integrity

### 5. ER Modeling (Entity-Relationship Model)
- Entity sets and relationship sets
- Weak entities and identifying relationships
- Primary keys & foreign keys
- ER diagram representation techniques

#### 6. Keys in Database Design
- Super Key
- Candidate Key
- Primary Key
- Foreign Key
- Composite Key
#### 7. Database Anomalies
- Insertion Anomaly
- Update Anomaly
- Deletion Anomaly  
Caused due to poor database design and redundancy

#### 8. Functional Dependencies
- Relationship between attributes in a relation
- Helps in normalization and schema decomposition

###  9. Normalization

Normalization is the process of organizing data to reduce redundancy and improve integrity.

#### 🔹 First Normal Form (1NF)
- Atomic values only
- No repeating groups

#### 🔹 Second Normal Form (2NF)
- Must be in 1NF
- No partial dependency on composite key

#### 🔹 Third Normal Form (3NF)
- Must be in 2NF
- No transitive dependencies

###  10. Relational Schema Design
- Decomposition of complex tables into smaller relations
- Ensures:
  - Data consistency
  - Reduced redundancy
  - Better performance
  - Easier maintenance

### Learning Outcomes

By completing this lab series, students are able to:

- Design efficient relational databases
- Build ER diagrams from real-world scenarios
- Normalize databases up to 3NF
- Write optimized SQL queries (DDL, DML, TCL)
- Understand real-world database design principles

###  Conclusion

This repository demonstrates practical implementation of database concepts from basic data handling to advanced normalization techniques. It provides a strong foundation for designing scalable, efficient, and real-world database systems.

## 👨‍💻 Author
**Jawahir Ali (UAJ&K)**  
Session: 2024–2028
