## DATABASE-SYSTEM LABS
##### COURSE: Introduction to Database Systems<br>
##### TOPIC COVERAGE: Data vs Information, DBMS, ER Modeling, Normalization, SQL


## LAB-2 DATABASE DESIGN & SQL IMPLEMENTATION

#### OBJECTIVE
Design and implement a normalized relational database schema for a **Point of Sale (POS)** system using MySQL/phpMyAdmin.

#### FILE
`Lab_02.sql` — Full SQL dump including table structure, constraints, and sample data.

#### DATABASE: `pos`

The POS database consists of the following tables:

| TABLE| DESCRIPTION|
|-------|-------------|
| `user` | System users with roles (Admin, Seller, Customer, etc.) |
| `role` | Defines user roles (Admin, Seller, Customer, Manager, etc.) |
| `admin` | Admin users with access levels (Normal, Supervisor, Security, etc.) |
| `customer` | Customer profiles linked to user accounts |
| `sell` | Seller information with associated shop names |
| `categories` | Product categories (Electronics, Clothes, Food, etc.) |
| `products` | Product catalog with price, stock, and category |
| `orders` | Customer orders with date and total amount |
| `order_items` | Individual items within each order |

#### RELATIONSHIP & CONSTRAINTS

- `user` ← `role` (Foreign Key: `role_id`) — Each user has one role
- `admin` ← `user` (Foreign Key: `user_id`) — Admins are users
- `customer` ← `user` (Foreign Key: `user_id`) — Customers are users
- `sell` ← `user` (Foreign Key: `user_id`) — Sellers are users
- `products` ← `categories` (Foreign Key: `category_id`) — Products belong to categories
- `orders` ← `customer` (Foreign Key: `customer_id`) — Orders placed by customers
- `order_items` ← `orders` & `products` (Foreign Keys) — Items reference orders and products

All foreign keys use `ON DELETE CASCADE ON UPDATE CASCADE` where applicable.

#### SAMPLE DATA OVERVIEW

- **10 Users** — Jawahir, Hussain, Usman, Bilal, Hamza, Zain, Kashif, Faisal, Imran (various roles)
- **10 Customers** — Hassan, Usman, Hamza, Kashif, Imran, Ahsan, Saad, Zeeshan, Noman, Tariq
- **10 Products** — Laptop (80,000), Mobile (50,000), T-Shirt (1,500), Shoes (4,000), etc.
- **10 Orders** — Ranging from Rs. 50 to Rs. 80,000
- **10 Categories** — Electronics, Clothes, Food, Books, Sports, Shoes, Bags, Accessories, Furniture, Stationary

#### CONCEPT APPLIED

- **DDL (Data Definition Language):** `CREATE TABLE`, `ALTER TABLE`, Primary Keys, Foreign Keys
- **DML (Data Manipulation Language):** `INSERT INTO` for populating tables
- **TCL (Transaction Control Language):** `START TRANSACTION`, `COMMIT`
- **Relational Schema Design:** Entities, attributes, keys, and relationships
- **ER Model Concepts:** Entity sets, relationship sets, weak entities, primary & foreign keys
- **Normalization:**
  - **1NF** — Atomic values, no repeating groups
  - **2NF** — No partial dependencies on composite keys
  - **3NF** — No transitive dependencies

#### COURSE TOPICS OVERVIEW

#### CORE CONCEPT

**Data vs Information & File Systems**
- Difference between raw data and meaningful information
- Problems with traditional file-based systems
- Definition and purpose of a DBMS
- Database environment, components, and applications
- Overview of database languages: DDL, DML, DCL, TCL

**Relational Data Model & ER Modeling**
- Introduction to the relational data model
- Entities, entity sets, and attributes (simple, composite, derived, multivalued)
- Keys: Super key, Candidate key, Primary key
- Relationships, relationship sets, and ER diagram notation
- Weak entities and recursive relationships
- Relationship attributes and ER diagram examples
- Introduction to relational schema design

**Functional Dependencies & Normalization**
- Redundancy and update/insertion/deletion anomalies
- Functional dependency definition and types
- Purpose of normalization and characteristics of good design

**Normal Forms**
- **1NF:** Eliminate repeating groups, ensure atomic values
- **2NF:** Eliminate partial dependencies (every non-key attribute fully depends on the whole primary key)
- **3NF:** Eliminate transitive dependencies (non-key attributes depend only on primary key)
- Step-by-step schema decomposition examples

