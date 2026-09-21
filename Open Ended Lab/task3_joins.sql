USE cargo_rentals;

-- =====================================================================
--  TASK 3 : JOIN QUERIES
-- =====================================================================

-- Q1. Customer name, vehicle number, vehicle model, rental date and
--     return date for every rental  (INNER JOIN)
SELECT c.full_name                          AS customer_name,
       v.vehicle_number,
       CONCAT(m.brand, ' ', m.model_name)   AS vehicle_model,
       r.rental_date,
       r.return_date
FROM rentals r
INNER JOIN customers      c ON c.customer_id = r.customer_id
INNER JOIN vehicles       v ON v.vehicle_id  = r.vehicle_id
INNER JOIN vehicle_models m ON m.model_id    = v.model_id
ORDER BY r.rental_date;

-- Q2. All customers and the vehicles they rented, including customers
--     who never rented  (LEFT JOIN from customers)
SELECT c.customer_id,
       c.full_name                          AS customer_name,
       v.vehicle_number,
       CONCAT(m.brand, ' ', m.model_name)   AS vehicle_model,
       r.rental_date
FROM customers c
LEFT JOIN rentals        r ON r.customer_id = c.customer_id
LEFT JOIN vehicles       v ON v.vehicle_id  = r.vehicle_id
LEFT JOIN vehicle_models m ON m.model_id    = v.model_id
ORDER BY c.customer_id, r.rental_date;

-- Q3. All vehicles with their CURRENT rental information; vehicles that
--     are not rented right now also appear (LEFT JOIN from vehicles).
--     The "return_date IS NULL" filter is in the ON clause on purpose:
--     if it were in WHERE, available vehicles would disappear.
SELECT v.vehicle_number,
       CONCAT(m.brand, ' ', m.model_name)   AS vehicle_model,
       v.status,
       c.full_name                          AS rented_by,
       r.rental_date,
       r.due_date
FROM vehicles v
INNER JOIN vehicle_models m ON m.model_id   = v.model_id
LEFT  JOIN rentals        r ON r.vehicle_id = v.vehicle_id AND r.return_date IS NULL
LEFT  JOIN customers      c ON c.customer_id = r.customer_id
ORDER BY v.vehicle_id;

-- Q4. Total rentals per customer, including customers with zero rentals.
--     COUNT(r.rental_id) (not COUNT(*)) so that customers with no rows
--     in rentals are counted as 0.
SELECT c.customer_id,
       c.full_name                AS customer_name,
       COUNT(r.rental_id)         AS total_rentals
FROM customers c
LEFT JOIN rentals r ON r.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY total_rentals DESC, c.customer_id;
