USE cargo_rentals;

-- =====================================================================
--  TASK 7 : OPTIMIZATION ANALYSIS
--  Problem : "rentals in 2026" is written with YEAR(rental_date) = 2026.
--            A function applied on the column stops MySQL from using an
--            index on rental_date (non-sargable) and forces it to
--            evaluate YEAR() for every row -> full table scan.
--  Fix     : (1) add an index on rentals(rental_date)
--            (2) rewrite the condition as a date range.
-- =====================================================================

-- BEFORE : non-sargable query, no index on rental_date
EXPLAIN SELECT rental_id, customer_id, rental_date, total_charge
FROM rentals
WHERE YEAR(rental_date) = 2026;

-- Improvement 1 : index
CREATE INDEX idx_rentals_rental_date ON rentals (rental_date);

-- Still non-sargable even with the index (function on the column)
EXPLAIN SELECT rental_id, customer_id, rental_date, total_charge
FROM rentals
WHERE YEAR(rental_date) = 2026;

-- AFTER : sargable range query - the index can now be used
EXPLAIN SELECT rental_id, customer_id, rental_date, total_charge
FROM rentals
WHERE rental_date >= '2026-01-01' AND rental_date < '2027-01-01';

-- Same result set, better plan
SELECT rental_id, customer_id, rental_date, total_charge
FROM rentals
WHERE rental_date >= '2026-01-01' AND rental_date < '2027-01-01';
