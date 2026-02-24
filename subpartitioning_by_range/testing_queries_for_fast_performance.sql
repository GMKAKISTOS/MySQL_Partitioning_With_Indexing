USE dbparticion1;
--
SHOW TABLES;
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
SHOW INDEXES FROM employees_partrange_year1;