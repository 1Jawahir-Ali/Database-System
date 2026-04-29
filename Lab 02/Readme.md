 ## __🔹LAB-2 DATABASE DESIGN & SQL IMPLEMENTATION (POS)🔹__

 #### 🔺OBJECTIVE
Design and implement a normalized relational database schema for a **Point of Sale (POS)** system using MySQL/phpMyAdmin.

#### 🔺FILE
`Lab_02.sql` — Full SQL dump including table structure, constraints, and sample data.

#### 🔺DATABASE: `pos`

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

#### 🔹RELATIONSHIP & CONSTRAINTS

- `user` ← `role` (Foreign Key: `role_id`) — Each user has one role
- `admin` ← `user` (Foreign Key: `user_id`) — Admins are users
- `customer` ← `user` (Foreign Key: `user_id`) — Customers are users
- `sell` ← `user` (Foreign Key: `user_id`) — Sellers are users
- `products` ← `categories` (Foreign Key: `category_id`) — Products belong to categories
- `orders` ← `customer` (Foreign Key: `customer_id`) — Orders placed by customers
- `order_items` ← `orders` & `products` (Foreign Keys) — Items reference orders and products

All foreign keys use `ON DELETE CASCADE ON UPDATE CASCADE` where applicable.
