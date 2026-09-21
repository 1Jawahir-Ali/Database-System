-- =====================================================================
--  TASK 1 : DATABASE DESIGN AND IMPLEMENTATION
-- =====================================================================

DROP DATABASE IF EXISTS cargo_rentals;
CREATE DATABASE cargo_rentals CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE cargo_rentals;

-- ---------- 1. customers ----------
CREATE TABLE customers (
    customer_id    INT AUTO_INCREMENT,
    full_name      VARCHAR(80)  NOT NULL,
    phone          VARCHAR(15)  NOT NULL,
    cnic           VARCHAR(15)  NOT NULL,
    license_no     VARCHAR(20)  NOT NULL,
    email          VARCHAR(100) NULL,
    address        VARCHAR(150) NULL,
    registered_on  DATE         NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_customers   PRIMARY KEY (customer_id),
    CONSTRAINT uq_cust_phone  UNIQUE (phone),
    CONSTRAINT uq_cust_cnic   UNIQUE (cnic),
    CONSTRAINT uq_cust_lic    UNIQUE (license_no),
    CONSTRAINT uq_cust_email  UNIQUE (email)
) ENGINE=InnoDB;

-- ---------- 2. vehicle_models (daily rate depends on the model) ----------
CREATE TABLE vehicle_models (
    model_id    INT AUTO_INCREMENT,
    brand       VARCHAR(40)   NOT NULL,
    model_name  VARCHAR(40)   NOT NULL,
    daily_rate  DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_models       PRIMARY KEY (model_id),
    CONSTRAINT uq_model        UNIQUE (brand, model_name),
    CONSTRAINT chk_model_rate  CHECK (daily_rate > 0)
) ENGINE=InnoDB;

-- ---------- 3. vehicles ----------
CREATE TABLE vehicles (
    vehicle_id      INT AUTO_INCREMENT,
    vehicle_number  VARCHAR(15) NOT NULL,
    model_id        INT         NOT NULL,
    color           VARCHAR(20) NULL,
    model_year      SMALLINT    NOT NULL,
    status          ENUM('Available','Rented','Maintenance') NOT NULL DEFAULT 'Available',
    CONSTRAINT pk_vehicles   PRIMARY KEY (vehicle_id),
    CONSTRAINT uq_veh_number UNIQUE (vehicle_number),
    CONSTRAINT chk_veh_year  CHECK (model_year BETWEEN 2000 AND 2035),
    CONSTRAINT fk_veh_model  FOREIGN KEY (model_id) REFERENCES vehicle_models(model_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------- 4. rentals (rental + return information) ----------
-- return_date stays NULL while the vehicle is still with the customer.
-- daily_rate_applied stores the rate at booking time so old rentals keep
-- their original price even if the model's daily_rate changes later.
CREATE TABLE rentals (
    rental_id           INT AUTO_INCREMENT,
    customer_id         INT           NOT NULL,
    vehicle_id          INT           NOT NULL,
    rental_date         DATE          NOT NULL,
    due_date            DATE          NOT NULL,
    return_date         DATE          NULL,
    daily_rate_applied  DECIMAL(10,2) NOT NULL,
    total_charge        DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_rentals      PRIMARY KEY (rental_id),
    CONSTRAINT fk_rent_cust    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_rent_veh     FOREIGN KEY (vehicle_id)  REFERENCES vehicles(vehicle_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_rent_due    CHECK (due_date > rental_date),
    CONSTRAINT chk_rent_ret    CHECK (return_date IS NULL OR return_date >= rental_date),
    CONSTRAINT chk_rent_rate   CHECK (daily_rate_applied > 0),
    CONSTRAINT chk_rent_total  CHECK (total_charge > 0)
) ENGINE=InnoDB;

-- ---------- 5. payments (one rental can have many payments) ----------
CREATE TABLE payments (
    payment_id    INT AUTO_INCREMENT,
    rental_id     INT           NOT NULL,
    amount        DECIMAL(10,2) NOT NULL,
    payment_date  DATE          NOT NULL DEFAULT (CURRENT_DATE),
    method        ENUM('Cash','Card','Bank Transfer','Mobile Wallet') NOT NULL DEFAULT 'Cash',
    CONSTRAINT pk_payments    PRIMARY KEY (payment_id),
    CONSTRAINT fk_pay_rental  FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_pay_amount CHECK (amount > 0)
) ENGINE=InnoDB;

-- ---------- Sample data ----------
INSERT INTO customers (full_name, phone, cnic, license_no, email, address, registered_on) VALUES
('Ali Khan',       '0300-1234567', '42101-1234567-1', 'KHI-2019-1001', 'ali.khan@example.com',       'Gulshan-e-Iqbal, Karachi', '2026-01-10'),
('Sara Ahmed',     '0321-2345678', '35202-2345678-3', 'LHR-2018-2002', 'sara.ahmed@example.com',     'Model Town, Lahore',       '2026-02-14'),
('Usman Raza',     '0333-3456789', '37405-3456789-5', 'RWP-2020-3003', 'usman.raza@example.com',     'Satellite Town, Rawalpindi','2026-03-05'),
('Ayesha Noor',    '0345-4567890', '61101-4567890-7', 'ISB-2017-4004', 'ayesha.noor@example.com',    'F-10, Islamabad',          '2026-03-22'),
('Bilal Hussain',  '0301-5678901', '34101-5678901-9', 'GRW-2021-5005', 'bilal.hussain@example.com',  'Gujranwala Cantt',         '2026-05-01'),
('Hina Malik',     '0312-6789012', '42201-6789012-2', 'KHI-2016-6006', 'hina.malik@example.com',     'DHA Phase 5, Karachi',     '2026-06-18'),
('Zain Abbas',     '0322-7890123', '35201-7890123-4', 'LHR-2022-7007', 'zain.abbas@example.com',     'Johar Town, Lahore',       '2026-08-02'),
('Fatima Shah',    '0334-8901234', '71501-8901234-6', 'SKD-2019-8008', 'fatima.shah@example.com',    'Saddar, Rawalpindi',      '2026-09-01');

INSERT INTO vehicle_models (brand, model_name, daily_rate) VALUES
('Toyota', 'Corolla',   5000.00),
('Honda',  'Civic',     6500.00),
('Suzuki', 'Alto',      3000.00),
('Suzuki', 'Cultus',    3500.00),
('Toyota', 'Fortuner', 12000.00),
('Kia',    'Sportage',  9000.00);

INSERT INTO vehicles (vehicle_number, model_id, color, model_year, status) VALUES
('ABC-123',  1, 'White',  2022, 'Available'),
('LEA-4521', 2, 'Black',  2021, 'Available'),
('KHI-7788', 3, 'Silver', 2023, 'Available'),
('ISB-3344', 4, 'Red',    2020, 'Available'),
('LHR-9012', 5, 'Grey',   2022, 'Available'),
('GLT-2210', 6, 'Blue',   2023, 'Available'),
('ABD-456',  1, 'Silver', 2019, 'Available'),
('RWP-6677', 2, 'White',  2018, 'Maintenance');

-- rental_id 1 is the R001 record given in Task 2 (Ali Khan, ABC-123, 3 days x 5000 = 15000)
INSERT INTO rentals (customer_id, vehicle_id, rental_date, due_date, return_date, daily_rate_applied, total_charge) VALUES
(1, 1, '2026-09-01', '2026-09-04', '2026-09-04',  5000.00, 15000.00),   -- 1  completed
(2, 2, '2026-08-10', '2026-08-15', '2026-08-15',  6500.00, 32500.00),   -- 2  completed
(3, 3, '2026-08-20', '2026-08-27', '2026-08-27',  3000.00, 21000.00),   -- 3  completed
(1, 4, '2026-09-08', '2026-09-10', '2026-09-10',  3500.00,  7000.00),   -- 4  completed
(4, 5, '2026-09-05', '2026-09-12', '2026-09-12', 12000.00, 84000.00),   -- 5  completed
(3, 3, '2026-09-12', '2026-09-14', '2026-09-14',  3000.00,  6000.00),   -- 6  completed
(1, 7, '2026-07-01', '2026-07-08', '2026-07-08',  5000.00, 35000.00),   -- 7  completed
(4, 3, '2025-12-20', '2025-12-23', '2025-12-23',  3000.00,  9000.00),   -- 8  completed (2025)
(5, 2, '2026-09-15', '2026-09-22', NULL,          6500.00, 45500.00),   -- 9  ACTIVE
(2, 6, '2026-09-18', '2026-09-21', NULL,          9000.00, 27000.00),   -- 10 ACTIVE
(6, 1, '2026-09-17', '2026-09-24', NULL,          5000.00, 35000.00);   -- 11 ACTIVE

INSERT INTO payments (rental_id, amount, payment_date, method) VALUES
(1,  15000.00, '2026-09-01', 'Cash'),
(2,  32500.00, '2026-08-10', 'Card'),
(3,  21000.00, '2026-08-20', 'Bank Transfer'),
(4,   7000.00, '2026-09-08', 'Cash'),
(5,  40000.00, '2026-09-05', 'Card'),           -- advance
(5,  44000.00, '2026-09-12', 'Card'),           -- remaining (two payments for one rental)
(6,   6000.00, '2026-09-12', 'Cash'),
(7,  35000.00, '2026-07-01', 'Bank Transfer'),
(8,   9000.00, '2025-12-20', 'Cash'),
(9,  20000.00, '2026-09-15', 'Mobile Wallet'),  -- advance only
(10, 10000.00, '2026-09-18', 'Cash'),           -- advance only
(11, 15000.00, '2026-09-17', 'Card');           -- advance only

-- Vehicles that are currently out on an active rental must show as 'Rented'
UPDATE vehicles
SET status = 'Rented'
WHERE vehicle_id IN (SELECT vehicle_id FROM rentals WHERE return_date IS NULL);

-- Quick check
SELECT * FROM customers;
SELECT * FROM vehicle_models;
SELECT * FROM vehicles;
SELECT * FROM rentals;
SELECT * FROM payments;
