USE cargo_rentals;

-- =====================================================================
--  TASK 5 : TRIGGERS
--  (The manual skips the Task 5 heading, but the submission list and
--   rubric require a TRIGGER. Business rule: a vehicle must not be
--   rentable while it is already rented.)
--
--  phpMyAdmin note: if DELIMITER gives an error when running the whole
--  file, run each trigger/procedure separately in the SQL tab and type
--  $$ in the "Delimiter" box below the text area (remove the DELIMITER
--  lines from the text in that case).
-- =====================================================================
DELIMITER $$

-- Trigger 1 : reject a new active rental if the vehicle is not Available
CREATE TRIGGER trg_prevent_double_rental
BEFORE INSERT ON rentals
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);
    IF NEW.return_date IS NULL THEN
        SELECT status INTO v_status FROM vehicles WHERE vehicle_id = NEW.vehicle_id;
        IF v_status <> 'Available' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Rental rejected: vehicle is not available (already rented or under maintenance).';
        END IF;
    END IF;
END$$

-- Trigger 2 : after a successful active rental, mark the vehicle Rented
CREATE TRIGGER trg_mark_vehicle_rented
AFTER INSERT ON rentals
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NULL THEN
        UPDATE vehicles SET status = 'Rented' WHERE vehicle_id = NEW.vehicle_id;
    END IF;
END$$

-- Trigger 3 : when return_date is filled in, make the vehicle Available again
CREATE TRIGGER trg_mark_vehicle_available
AFTER UPDATE ON rentals
FOR EACH ROW
BEGIN
    IF OLD.return_date IS NULL AND NEW.return_date IS NOT NULL THEN
        UPDATE vehicles SET status = 'Available'
        WHERE vehicle_id = NEW.vehicle_id AND status = 'Rented';
    END IF;
END$$

DELIMITER ;

-- ---- Trigger demonstration ----
-- NOTE: (a) and (b) are supposed to raise an error. Errors stop a full-file
-- import, so they are commented out. For the screenshot, remove the leading
-- "-- " and run each one ALONE in the phpMyAdmin SQL tab.

-- (a) Vehicle 1 (ABC-123) is currently rented -> MUST FAIL with the trigger message
-- INSERT INTO rentals (customer_id, vehicle_id, rental_date, due_date, daily_rate_applied, total_charge)
-- VALUES (7, 1, '2026-09-20', '2026-09-22', 5000.00, 10000.00);

-- (b) Vehicle 8 (RWP-6677) is under maintenance -> MUST ALSO FAIL
-- INSERT INTO rentals (customer_id, vehicle_id, rental_date, due_date, daily_rate_applied, total_charge)
-- VALUES (7, 8, '2026-09-20', '2026-09-22', 6500.00, 13000.00);

-- (c) The success case and the 'Available' again case are shown with the
--     stored procedure below (it inserts through the same trigger).
