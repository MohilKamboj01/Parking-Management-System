-- =====================================================
-- PARKING MANAGEMENT SYSTEM
-- =====================================================

-- 1. CREATE DATABASE
DROP DATABASE IF EXISTS parking_management;
CREATE DATABASE parking_management;
USE parking_management;


-- =====================================================
-- 2. CREATE CUSTOMER TABLE
-- =====================================================

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100)
);


-- =====================================================
-- 3. CREATE VEHICLE TABLE
-- =====================================================

CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    vehicle_number VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    
    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE CASCADE
);


-- =====================================================
-- 4. CREATE PARKING SLOT TABLE
-- =====================================================

CREATE TABLE Parking_Slot (
    slot_id INT PRIMARY KEY AUTO_INCREMENT,
    slot_number VARCHAR(10) UNIQUE NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    slot_status VARCHAR(20) DEFAULT 'Available'
);


-- =====================================================
-- 5. CREATE PARKING RECORD TABLE
-- =====================================================

CREATE TABLE Parking_Record (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    slot_id INT NOT NULL,
    entry_time DATETIME NOT NULL,
    exit_time DATETIME,
    parking_status VARCHAR(20) DEFAULT 'Parked',

    FOREIGN KEY (vehicle_id)
        REFERENCES Vehicle(vehicle_id),

    FOREIGN KEY (slot_id)
        REFERENCES Parking_Slot(slot_id)
);


-- =====================================================
-- 6. CREATE PAYMENT TABLE
-- =====================================================

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Paid',
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (record_id)
        REFERENCES Parking_Record(record_id)
);


-- =====================================================
-- 7. CREATE STAFF TABLE
-- =====================================================

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    shift_time VARCHAR(30)
);


-- =====================================================
-- 8. INSERT CUSTOMER DATA
-- =====================================================

INSERT INTO Customer (customer_name, phone, email)
VALUES
('Rahul Sharma', '9876543210', 'rahul@gmail.com'),
('Priya Singh', '9876543211', 'priya@gmail.com'),
('Aman Verma', '9876543212', 'aman@gmail.com'),
('Neha Gupta', '9876543213', 'neha@gmail.com'),
('Arjun Kumar', '9876543214', 'arjun@gmail.com');


-- =====================================================
-- 9. INSERT VEHICLE DATA
-- =====================================================

INSERT INTO Vehicle (customer_id, vehicle_number, vehicle_type)
VALUES
(1, 'PB10AB1234', 'Car'),
(2, 'PB10CD5678', 'Car'),
(3, 'PB10EF9012', 'Bike'),
(4, 'PB10GH3456', 'Car'),
(5, 'PB10IJ7890', 'Bike');


-- =====================================================
-- 10. INSERT PARKING SLOT DATA
-- =====================================================

INSERT INTO Parking_Slot (slot_number, vehicle_type, slot_status)
VALUES
('C01', 'Car', 'Occupied'),
('C02', 'Car', 'Occupied'),
('C03', 'Car', 'Available'),
('C04', 'Car', 'Available'),
('C05', 'Car', 'Available'),
('B01', 'Bike', 'Occupied'),
('B02', 'Bike', 'Available'),
('B03', 'Bike', 'Available'),
('B04', 'Bike', 'Available'),
('B05', 'Bike', 'Available');


-- =====================================================
-- 11. INSERT PARKING RECORDS
-- =====================================================

INSERT INTO Parking_Record
(vehicle_id, slot_id, entry_time, exit_time, parking_status)
VALUES
(1, 1, '2026-10-08 09:00:00', NULL, 'Parked'),

(2, 2, '2026-10-08 10:00:00', NULL, 'Parked'),

(3, 6, '2026-10-08 08:30:00',
 '2026-10-08 11:30:00', 'Completed'),

(4, 3, '2026-10-07 09:30:00',
 '2026-10-07 13:30:00', 'Completed'),

(5, 6, '2026-10-07 10:00:00',
 '2026-10-07 12:00:00', 'Completed');


-- =====================================================
-- 12. INSERT PAYMENT DATA
-- =====================================================

INSERT INTO Payment
(record_id, amount, payment_method, payment_status)
VALUES
(3, 60.00, 'Cash', 'Paid'),
(4, 120.00, 'UPI', 'Paid'),
(5, 40.00, 'Card', 'Paid');


-- =====================================================
-- 13. INSERT STAFF DATA
-- =====================================================

INSERT INTO Staff (staff_name, phone, shift_time)
VALUES
('Rajesh Kumar', '9876500001', 'Morning'),
('Suresh Singh', '9876500002', 'Afternoon'),
('Vikas Sharma', '9876500003', 'Evening');


-- =====================================================
-- BASIC QUERIES
-- =====================================================

-- Display all customers
SELECT * FROM Customer;

-- Display all vehicles
SELECT * FROM Vehicle;

-- Display all parking slots
SELECT * FROM Parking_Slot;

-- Display all parking records
SELECT * FROM Parking_Record;

-- Display all payments
SELECT * FROM Payment;

-- Display all staff
SELECT * FROM Staff;


-- =====================================================
-- 14. DISPLAY AVAILABLE PARKING SLOTS
-- =====================================================

SELECT *
FROM Parking_Slot
WHERE slot_status = 'Available';


-- =====================================================
-- 15. DISPLAY OCCUPIED PARKING SLOTS
-- =====================================================

SELECT *
FROM Parking_Slot
WHERE slot_status = 'Occupied';


-- =====================================================
-- 16. DISPLAY ALL CARS
-- =====================================================

SELECT *
FROM Vehicle
WHERE vehicle_type = 'Car';


-- =====================================================
-- 17. DISPLAY ALL BIKES
-- =====================================================

SELECT *
FROM Vehicle
WHERE vehicle_type = 'Bike';


-- =====================================================
-- JOINS
-- =====================================================

-- 18. Customer and Vehicle Details

SELECT
    c.customer_id,
    c.customer_name,
    c.phone,
    v.vehicle_number,
    v.vehicle_type
FROM Customer c
INNER JOIN Vehicle v
ON c.customer_id = v.customer_id;


-- =====================================================
-- 19. Parking Details with Vehicle Number
-- =====================================================

SELECT
    pr.record_id,
    v.vehicle_number,
    v.vehicle_type,
    ps.slot_number,
    pr.entry_time,
    pr.exit_time,
    pr.parking_status
FROM Parking_Record pr
INNER JOIN Vehicle v
ON pr.vehicle_id = v.vehicle_id
INNER JOIN Parking_Slot ps
ON pr.slot_id = ps.slot_id;


-- =====================================================
-- 20. COMPLETE CUSTOMER PARKING DETAILS
-- =====================================================

SELECT
    c.customer_name,
    v.vehicle_number,
    ps.slot_number,
    pr.entry_time,
    pr.exit_time,
    pr.parking_status
FROM Customer c
JOIN Vehicle v
ON c.customer_id = v.customer_id
JOIN Parking_Record pr
ON v.vehicle_id = pr.vehicle_id
JOIN Parking_Slot ps
ON pr.slot_id = ps.slot_id;


-- =====================================================
-- 21. PAYMENT DETAILS WITH CUSTOMER INFORMATION
-- =====================================================

SELECT
    c.customer_name,
    v.vehicle_number,
    p.amount,
    p.payment_method,
    p.payment_status,
    p.payment_date
FROM Payment p
JOIN Parking_Record pr
ON p.record_id = pr.record_id
JOIN Vehicle v
ON pr.vehicle_id = v.vehicle_id
JOIN Customer c
ON v.customer_id = c.customer_id;


-- =====================================================
-- AGGREGATE FUNCTIONS
-- =====================================================

-- 22. Total Revenue

SELECT SUM(amount) AS total_revenue
FROM Payment;


-- 23. Average Parking Payment

SELECT AVG(amount) AS average_payment
FROM Payment;


-- 24. Highest Payment

SELECT MAX(amount) AS highest_payment
FROM Payment;


-- 25. Lowest Payment

SELECT MIN(amount) AS lowest_payment
FROM Payment;


-- 26. Number of Customers

SELECT COUNT(*) AS total_customers
FROM Customer;


-- 27. Number of Vehicles

SELECT COUNT(*) AS total_vehicles
FROM Vehicle;


-- =====================================================
-- GROUP BY
-- =====================================================

-- 28. Count vehicles by type

SELECT
    vehicle_type,
    COUNT(*) AS total_vehicles
FROM Vehicle
GROUP BY vehicle_type;


-- 29. Total revenue by payment method

SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_method;


-- 30. Number of slots by status

SELECT
    slot_status,
    COUNT(*) AS total_slots
FROM Parking_Slot
GROUP BY slot_status;


-- =====================================================
-- HAVING
-- =====================================================

-- 31. Payment methods with revenue greater than 50

SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_method
HAVING SUM(amount) > 50;


-- =====================================================
-- ORDER BY
-- =====================================================

-- 32. Customers in alphabetical order

SELECT *
FROM Customer
ORDER BY customer_name ASC;


-- 33. Payments from highest to lowest

SELECT *
FROM Payment
ORDER BY amount DESC;


-- =====================================================
-- SUBQUERY
-- =====================================================

-- 34. Find customers who own cars

SELECT customer_name
FROM Customer
WHERE customer_id IN
(
    SELECT customer_id
    FROM Vehicle
    WHERE vehicle_type = 'Car'
);


-- =====================================================
-- 35. Find payment greater than average payment
-- =====================================================

SELECT *
FROM Payment
WHERE amount >
(
    SELECT AVG(amount)
    FROM Payment
);


-- =====================================================
-- UPDATE
-- =====================================================

-- 36. Update phone number

UPDATE Customer
SET phone = '9999999999'
WHERE customer_id = 1;


-- =====================================================
-- DELETE
-- =====================================================

-- 37. Delete a staff member

DELETE FROM Staff
WHERE staff_id = 3;


-- =====================================================
-- VIEW
-- =====================================================

-- 38. Create a view for active parking

CREATE VIEW Active_Parking AS
SELECT
    pr.record_id,
    c.customer_name,
    v.vehicle_number,
    v.vehicle_type,
    ps.slot_number,
    pr.entry_time,
    pr.parking_status
FROM Parking_Record pr
JOIN Vehicle v
ON pr.vehicle_id = v.vehicle_id
JOIN Customer c
ON v.customer_id = c.customer_id
JOIN Parking_Slot ps
ON pr.slot_id = ps.slot_id
WHERE pr.parking_status = 'Parked';


-- Display the view

SELECT *
FROM Active_Parking;


-- =====================================================
-- 39. PARKING SUMMARY
-- =====================================================

SELECT
    COUNT(*) AS total_records,
    SUM(parking_status = 'Parked') AS currently_parked,
    SUM(parking_status = 'Completed') AS completed_parking
FROM Parking_Record;


-- =====================================================
-- 40. END OF PROJECT
-- =====================================================