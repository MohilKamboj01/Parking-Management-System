Parking Management System
A DBMS mini-project developed using MySQL 8.0 to manage
customers, vehicles, parking slots, parking records, payments, and
staff. The project demonstrates common SQL operations and relational
database concepts.
Features
- Maintain customer details, including name, phone number, and email
- Register vehicles and associate them with customers
- Manage parking slots by vehicle type and slot status
- Record vehicle entry and exit times
- Track parking status as Parked or Completed
- Store payments, payment methods, payment status, and payment date
- Maintain parking staff details and shifts
- View available and occupied parking slots
- Display customer, vehicle, parking, and payment information using
  JOIN
- Calculate total, average, highest, and lowest payment amounts
- Use GROUP BY, HAVING, ORDER BY, and subqueries
- Update customer information and delete a staff record
- Create an Active_Parking view
- Generate a parking summary report
Technologies Used
- Database: MySQL 8.0
- Language: SQL
- Recommended tool: MySQL Workbench
Database Tables
The SQL script creates six tables:
  Table                               Purpose
  Customer                          Stores customer name, phone number,
                                      and email

  Vehicle                           Stores vehicle registration number
                                      and type, linked to a customer

  Parking_Slot                      Stores slot number, vehicle type,
                                      and availability status

  Parking_Record                    Stores vehicle/slot assignment,
                                      entry and exit time, and parking
                                      status

  Payment                           Stores parking charges, payment
                                      method, payment status, and payment
                                      date

  Staff                             Stores staff names, phone numbers,
                                  and shift times
Relationships
- Vehicle.customer_id references Customer.customer_id.
- Parking_Record.vehicle_id references Vehicle.vehicle_id.
- Parking_Record.slot_id references Parking_Slot.slot_id.
- Payment.record_id references Parking_Record.record_id.
Primary keys uniquely identify records. Foreign keys connect related
tables. UNIQUE and NOT NULL constraints help maintain data
consistency.
How to Run
Requirements
Install MySQL Server 8.0. MySQL Workbench is recommended for running the
script and viewing query results.
Steps
1. Download or clone this repository.
2. Open parking_management.sql in MySQL Workbench.
3. Connect to your MySQL server.
4. Execute the script.
5. Review the result grids produced by the SELECT statements.
Warning: The script begins with
DROP DATABASE IF EXISTS parking_management;. It deletes an existing
database with that name before recreating it. Back up any data you
need before running the script.

Example Queries
Display all customers
SELECT * FROM Customer;
Show complete customer parking details
SELECT
    c.customer_name,
    v.vehicle_number,
    ps.slot_number,
    pr.entry_time,
    pr.exit_time,
    pr.parking_status
FROM Customer c
JOIN Vehicle v ON c.customer_id = v.customer_id
JOIN Parking_Record pr ON v.vehicle_id = pr.vehicle_id
JOIN Parking_Slot ps ON pr.slot_id = ps.slot_id;
Calculate total revenue
SELECT SUM(amount) AS total_revenue
FROM Payment;
Count vehicles by type
SELECT vehicle_type, COUNT(*) AS total_vehicles
FROM Vehicle
GROUP BY vehicle_type;
Display active parking sessions
SELECT * FROM Active_Parking;
Sample Data
The script inserts sample data for five customers, five vehicles, ten
parking slots, five parking records, three payments, and three staff
members. The names, contact details, and records are sample data for
academic demonstration only.
Repository Structure
Parking-Management-System/
├── parking_management.sql
└── README.md
You can also add your academic project report, such as
Parking_Management_System_Mini_Project.docx, if you want to include it
in the repository.
Limitations and Future Improvements
- Parking slot status is not automatically synchronized with parking
  records.
- Parking charges are stored as values rather than calculated
  automatically from parking duration.
- The project does not include a graphical user interface or user
  authentication.
- Additional constraints or triggers could be added to prevent
  assigning an occupied slot to multiple active parking sessions.
Possible future improvements include automatic fee calculation, slot
allocation, payment validation, staff access control, and a web-based
interface.
Academic Purpose
This project is intended for educational use and demonstrates database
creation, table design, primary and foreign keys, constraints, data
insertion, joins, aggregate functions, grouping, filtering, sorting,
subqueries, updates, deletes, views, and summary queries.
