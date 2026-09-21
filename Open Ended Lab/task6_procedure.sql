USE cargo_rentals;

-- =====================================================================
--  TASK 6 : STORED PROCEDURE  -  register a new rental
--  Inputs : customer, vehicle, start date, number of days,
--           advance payment (0 if none), payment method
--  Does   : validates input, reads the vehicle's daily rate, calculates
--           due date and total charge, inserts the rental (the trigger
--           blocks unavailable vehicles), records the advance payment,
--           and returns a summary. Everything runs in one transaction.
-- =====================================================================
DELIMITER $$

CREATE PROCEDURE sp_register_rental(
    IN p_customer_id INT,
    IN p_vehicle_id  INT,
    IN p_rental_date DATE,
    IN p_days        INT,
    IN p_advance     DECIMAL(10,2),
    IN p_method      VARCHAR(20)
)
BEGIN
    DECLARE v_rate      DECIMAL(10,2);
    DECLARE v_total     DECIMAL(10,2);
    DECLARE v_due       DATE;
    DECLARE v_rental_id INT;

    -- any error (including the trigger's) -> undo everything and re-raise it
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    SET p_advance = IFNULL(p_advance, 0);

    -- ---- validation ----
    IF p_days IS NULL OR p_days < 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Rental period must be at least 1 day.';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM customers WHERE customer_id = p_customer_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Customer does not exist.';
    END IF;

    SELECT m.daily_rate INTO v_rate
    FROM vehicles v
    INNER JOIN vehicle_models m ON m.model_id = v.model_id
    WHERE v.vehicle_id = p_vehicle_id;

    IF v_rate IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Vehicle does not exist.';
    END IF;

    -- ---- calculation ----
    SET v_due   = DATE_ADD(p_rental_date, INTERVAL p_days DAY);
    SET v_total = v_rate * p_days;

    IF p_advance < 0 OR p_advance > v_total THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Advance payment must be between 0 and the total charge.';
    END IF;

    -- ---- database work ----
    START TRANSACTION;

    INSERT INTO rentals (customer_id, vehicle_id, rental_date, due_date, daily_rate_applied, total_charge)
    VALUES (p_customer_id, p_vehicle_id, p_rental_date, v_due, v_rate, v_total);

    SET v_rental_id = LAST_INSERT_ID();

    IF p_advance > 0 THEN
        INSERT INTO payments (rental_id, amount, payment_date, method)
        VALUES (v_rental_id, p_advance, p_rental_date, p_method);
    END IF;

    COMMIT;

    -- ---- result shown to the user ----
    SELECT v_rental_id          AS rental_id,
           p_rental_date        AS rental_date,
           v_due                AS due_date,
           p_days               AS rental_days,
           v_rate               AS daily_rate,
           v_total              AS total_charge,
           p_advance            AS advance_paid,
           v_total - p_advance  AS balance_due;
END$$

DELIMITER ;

-- ---- Stored procedure demonstration ----
-- (a) Successful rental: Zain Abbas (7) rents ISB-3344 (vehicle 4) for 3 days, pays 5000 advance
--     Expected: total = 3 x 3500 = 10500, balance = 5500
CALL sp_register_rental(7, 4, '2026-09-20', 3, 5000.00, 'Cash');

SELECT vehicle_number, status FROM vehicles WHERE vehicle_id = 4;     -- now 'Rented'
SELECT * FROM vw_rental_report WHERE vehicle_number = 'ISB-3344' ORDER BY rental_id;

-- (b) Same vehicle again -> must FAIL (trigger blocks it). Run ALONE for the screenshot.
-- CALL sp_register_rental(8, 4, '2026-09-20', 2, 0, 'Cash');

-- (c) Invalid input -> must FAIL. Run each ALONE for the screenshot.
-- CALL sp_register_rental(8, 5, '2026-09-20', 0, 0, 'Cash');         -- 0 days
-- CALL sp_register_rental(99, 5, '2026-09-20', 2, 0, 'Cash');        -- unknown customer

-- (d) Return the vehicle -> trigger 3 makes it Available again
UPDATE rentals SET return_date = '2026-09-23'
WHERE vehicle_id = 4 AND return_date IS NULL;
SELECT vehicle_number, status FROM vehicles WHERE vehicle_id = 4;     -- back to 'Available'
