USE cargo_rentals;

-- =====================================================================
--  TASK 4 : VIEW  -  consolidated rental report
-- =====================================================================
CREATE OR REPLACE VIEW vw_rental_report AS
SELECT r.rental_id,
       c.full_name                                   AS customer_name,
       c.phone                                       AS customer_phone,
       v.vehicle_number,
       CONCAT(m.brand, ' ', m.model_name)            AS vehicle_model,
       r.rental_date,
       r.due_date,
       r.return_date,
       DATEDIFF(r.due_date, r.rental_date)           AS rental_days,
       r.daily_rate_applied,
       r.total_charge,
       COALESCE(p.total_paid, 0)                     AS amount_paid,
       r.total_charge - COALESCE(p.total_paid, 0)    AS balance_due,
       CASE WHEN r.return_date IS NULL THEN 'Active' ELSE 'Completed' END AS rental_status,
       CASE WHEN COALESCE(p.total_paid, 0) >= r.total_charge THEN 'Paid'
            WHEN COALESCE(p.total_paid, 0) = 0               THEN 'Unpaid'
            ELSE 'Partially Paid' END                AS payment_status
FROM rentals r
INNER JOIN customers      c ON c.customer_id = r.customer_id
INNER JOIN vehicles       v ON v.vehicle_id  = r.vehicle_id
INNER JOIN vehicle_models m ON m.model_id    = v.model_id
LEFT  JOIN (SELECT rental_id, SUM(amount) AS total_paid
            FROM payments
            GROUP BY rental_id) p ON p.rental_id = r.rental_id;

-- Demonstration
SELECT * FROM vw_rental_report ORDER BY rental_id;
-- Only currently rented vehicles with pending balance
SELECT * FROM vw_rental_report WHERE rental_status = 'Active' AND balance_due > 0;
