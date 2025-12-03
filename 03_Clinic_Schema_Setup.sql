-- Clinic schema setup
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;


CREATE TABLE clinic_sales (
sale_id INT PRIMARY KEY,
sale_date DATE,
sales_channel VARCHAR(50), -- e.g., Online, Walk-in, Referral
amount DECIMAL(12,2)
);


CREATE TABLE expenses (
expense_id INT PRIMARY KEY,
expense_date DATE,
category VARCHAR(100),
amount DECIMAL(12,2)
);


-- Sample data
INSERT INTO clinic_sales VALUES
(1, '2021-11-01', 'Walk-in', 1200.00),
(2, '2021-11-05', 'Online', 800.00),
(3, '2021-11-20', 'Referral', 2000.00),
(4, '2021-12-02', 'Walk-in', 1500.00),
(5, '2021-12-10', 'Online', 600.00);


INSERT INTO expenses VALUES
(1, '2021-11-03', 'Salaries', 1000.00),
(2, '2021-11-10', 'Supplies', 300.00),
(3, '2021-11-22', 'Rent', 800.00),
(4, '2021-12-05', 'Supplies', 200.00);