USE dbparticion1;
--
SHOW TABLES;
--
DESCRIBE employees_partrange_year1;
--
EXPLAIN SELECT COUNT(*) AS Number_Of_Rows FROM employees_partrange_year1;
EXPLAIN ANALYZE SELECT COUNT(*) AS Number_Of_Rows FROM employees_partrange_year1;
SELECT COUNT(*) AS Number_Of_Rows FROM employees_partrange_year1;
SELECT 100000000 - COUNT(*) AS Number_Of_Rows FROM employees_partrange_year1;
SELECT COUNT(*) AS Number_Of_Rows FROM employees_partrange_year1 PARTITION(p7);
-- 39991710
-- SELECT id, hired FROM employees_partrange_year1;
SELECT id, hired FROM employees_partrange_year1 WHERE id = 5000000;
SELECT hired FROM employees_partrange_year1 WHERE id = 5000000;
SELECT * FROM employees_partrange_year1 WHERE id = 5000000;
SELECT * FROM employees_partrange_year1 WHERE hired = '1986-11-22';
SELECT fname, lname FROM employees_partrange_year1 WHERE hired = '1986-11-22';
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN 15000000 AND 16000000 AND (hired > '2000-01-01');
SELECT * FROM employees_partrange_year1 WHERE hired = '2000-01-01';
SELECT * FROM employees_partrange_year1 WHERE id = 45000000;
SELECT id, hired FROM employees_partrange_year1 WHERE hired > '2025-01-01';
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN 80000000 AND 85000000;
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN 99900000 AND 100000000;
--
DELIMITER //
CREATE PROCEDURE Update_Some_Rows_With_Procedure(IN from_row INTEGER, IN to_row INTEGER, IN change_date DATE)
BEGIN
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row FOR UPDATE;
UPDATE employees_partrange_year1 SET hired = change_date WHERE id BETWEEN from_row AND to_row;
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
ROLLBACK;
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
END;
// DELIMITER ;
--
DELIMITER //
CREATE FUNCTION Count_Some_Rows_With_Function(from_row INTEGER, to_row INTEGER)
RETURNS INTEGER DETERMINISTIC
BEGIN
DECLARE number_of_rows INTEGER;
SELECT COUNT(*) INTO number_of_rows FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
RETURN number_of_rows;
END;
// DELIMITER ;
--
DELIMITER //
CREATE PROCEDURE Delete_Some_Rows_With_Procedure(IN from_row INTEGER, IN to_row INTEGER, OUT rows_deleted INTEGER)
BEGIN
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row FOR UPDATE;
DELETE FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
SELECT COUNT(*) INTO rows_deleted FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
ROLLBACK;
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN from_row AND to_row;
END;
// DELIMITER ;
--
CALL Update_Some_Rows_With_Procedure(99999900, 100000000, '2027-01-01');
--
SELECT Count_Some_Rows_With_Function(99999900, 100000000) AS number_of_rows_being_updated;
--
CALL Delete_Some_Rows_With_Procedure(99999900, 100000000, @rows_deleted);
SELECT @rows_deleted AS number_of_rows_being_deleted;
--
SELECT * FROM employees_partrange_year1 WHERE id BETWEEN 99999900 AND 100000000;
EXPLAIN UPDATE employees_partrange_year1 SET hired = '2027-01-01' WHERE id BETWEEN 99999900 AND 100000000;
EXPLAIN ANALYZE UPDATE employees_partrange_year1 SET hired = '2027-01-01' WHERE id BETWEEN 99999900 AND 100000000;
EXPLAIN DELETE FROM employees_partrange_year1 WHERE id BETWEEN 99999900 AND 100000000;
EXPLAIN ANALYZE DELETE FROM employees_partrange_year1 WHERE id BETWEEN 99999900 AND 100000000;
-- UPDATE employees_partrange_year1 SET hired = '2027-01-01' WHERE id BETWEEN 99999900 AND 100000000;
-- DELETE FROM employees_partrange_year1 WHERE id BETWEEN 99999900 AND 100000000;
--
DROP PROCEDURE IF EXISTS Delete_Some_Rows_With_Procedure;
--
DROP FUNCTION IF EXISTS Count_Some_Rows_With_Function;
--
DROP PROCEDURE IF EXISTS Update_Some_Rows_With_Procedure;
--
SHOW INDEXES FROM employees_partrange_year1;