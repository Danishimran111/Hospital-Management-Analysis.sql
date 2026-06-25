-- ==========================================================
-- HOSPITAL MANAGEMENT ANALYTICS SYSTEM
-- Database: Healthcare_Analytics
-- Target: MySQL Workbench
-- ==========================================================

-- 1. DATABASE ARCHITECTURE
-- ----------------------------------------------------------

DROP DATABASE IF EXISTS Healthcare_Analytics;
CREATE DATABASE Healthcare_Analytics;
USE Healthcare_Analytics;

-- Table 1: Departments
CREATE TABLE Departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- Table 2: Patients
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    registration_date DATE DEFAULT (CURRENT_DATE)
);

-- Table 3: Doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dept_id INT,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);

-- Table 4: Staff
CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dept_id INT,
    role VARCHAR(50),
    phone VARCHAR(15) UNIQUE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);

-- Table 5: Appointments
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Table 6: Medical_Records
CREATE TABLE Medical_Records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis TEXT NOT NULL,
    treatment TEXT,
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- Table 7: Invoices
CREATE TABLE Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE,
    amount DECIMAL(10, 2) NOT NULL,
    invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('Paid', 'Unpaid', 'Pending') DEFAULT 'Unpaid',
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- 2. BULK DATA GENERATION (20+ Records per Table)
-- ----------------------------------------------------------

-- Populate Departments
INSERT INTO Departments (dept_name, location) VALUES
('Cardiology', 'Block A, 1st Floor'),
('Neurology', 'Block B, 2nd Floor'),
('Pediatrics', 'Block C, 1st Floor'),
('Orthopedics', 'Block A, 2nd Floor'),
('Oncology', 'Block D, 3rd Floor'),
('Emergency', 'Ground Floor'),
('Dermatology', 'Block B, 1st Floor');

-- Populate Patients
INSERT INTO Patients (first_name, last_name, dob, gender, phone, email, registration_date) VALUES
('John', 'Doe', '1955-05-15', 'Male', '555-0101', 'john.doe@email.com', '2023-06-01'),
('Jane', 'Smith', '1962-08-22', 'Female', '555-0102', 'jane.smith@email.com', '2023-07-15'),
('Alice', 'Johnson', '1985-12-10', 'Female', '555-0103', 'alice.j@email.com', '2023-08-20'),
('Robert', 'Brown', '1948-03-30', 'Male', '555-0104', 'robert.b@email.com', '2023-09-05'),
('Emily', 'Davis', '1992-01-25', 'Female', '555-0105', 'emily.d@email.com', '2023-10-12'),
('Michael', 'Wilson', '1970-11-02', 'Male', '555-0106', 'michael.w@email.com', '2023-11-18'),
('Sarah', 'Miller', '1988-06-14', 'Female', '555-0107', 'sarah.m@email.com', '2023-12-01'),
('James', 'Taylor', '1950-09-09', 'Male', '555-0108', 'james.t@email.com', '2024-01-05'),
('Linda', 'Anderson', '1975-04-20', 'Female', '555-0109', 'linda.a@email.com', '2024-01-20'),
('William', 'Thomas', '1965-07-30', 'Male', '555-0110', 'william.t@email.com', '2024-02-10'),
('Patricia', 'Jackson', '1995-02-18', 'Female', '555-0111', 'patricia.j@email.com', '2024-02-25'),
('David', 'White', '1942-12-05', 'Male', '555-0112', 'david.w@email.com', '2024-03-01'),
('Barbara', 'Harris', '1982-10-12', 'Female', '555-0113', 'barbara.h@email.com', '2024-03-15'),
('Richard', 'Martin', '1958-05-25', 'Male', '555-0114', 'richard.m@email.com', '2024-03-20'),
('Elizabeth', 'Thompson', '2000-08-08', 'Female', '555-0115', 'elizabeth.t@email.com', '2024-04-01'),
('Joseph', 'Garcia', '1972-03-14', 'Male', '555-0116', 'joseph.g@email.com', '2024-04-10'),
('Susan', 'Martinez', '1968-11-30', 'Female', '555-0117', 'susan.m@email.com', '2024-04-15'),
('Thomas', 'Robinson', '1940-01-01', 'Male', '555-0118', 'thomas.r@email.com', '2024-04-20'),
('Jessica', 'Clark', '1990-09-22', 'Female', '555-0119', 'jessica.c@email.com', '2024-05-01'),
('Charles', 'Rodriguez', '1955-06-15', 'Male', '555-0120', 'charles.r@email.com', '2024-05-05');

-- Populate Doctors
INSERT INTO Doctors (first_name, last_name, dept_id, specialization, phone) VALUES
('Gregory', 'House', 2, 'Diagnostic Medicine', '555-1001'),
('James', 'Wilson', 5, 'Oncology', '555-1002'),
('Lisa', 'Cuddy', 1, 'Endocrinology', '555-1003'),
('Eric', 'Foreman', 2, 'Neurology', '555-1004'),
('Allison', 'Cameron', 6, 'Immunology', '555-1005'),
('Robert', 'Chase', 1, 'Cardiology', '555-1006'),
('Chris', 'Taub', 7, 'Plastic Surgery', '555-1007'),
('Remy', 'Hadley', 2, 'Internal Medicine', '555-1008'),
('Lawrence', 'Kutner', 6, 'Sports Medicine', '555-1009'),
('Martha', 'Masters', 3, 'Pediatrics', '555-1010'),
('Jessica', 'Adams', 4, 'Orthopedics', '555-1011'),
('Chi', 'Park', 2, 'Neurology', '555-1012'),
('Amber', 'Volakis', 6, 'Radiology', '555-1013'),
('Lucas', 'Douglas', 1, 'Cardiology', '555-1014'),
('Stacy', 'Warner', 2, 'Medical Law', '555-1015'),
('Edward', 'Vogler', 1, 'Business Administration', '555-1016'),
('Charles', 'Tritter', 6, 'Emergency Medicine', '555-1017'),
('Michael', 'Tritter', 4, 'Orthopedics', '555-1018'),
('Sarah', 'Tancredi', 6, 'Prison Medicine', '555-1019'),
('Derek', 'Shepherd', 2, 'Neurosurgery', '555-1020');

-- Populate Staff
INSERT INTO Staff (first_name, last_name, dept_id, role, phone) VALUES
('Mark', 'Sloan', 7, 'Nurse', '555-2001'),
('Lexie', 'Grey', 3, 'Administrator', '555-2002'),
('Callie', 'Torres', 4, 'Nurse', '555-2003'),
('Arizona', 'Robbins', 3, 'Receptionist', '555-2004'),
('Owen', 'Hunt', 6, 'Security', '555-2005'),
('Teddy', 'Altman', 1, 'Nurse', '555-2006'),
('Jackson', 'Avery', 7, 'Administrator', '555-2007'),
('April', 'Kepner', 6, 'Receptionist', '555-2008'),
('Miranda', 'Bailey', 6, 'Manager', '555-2009'),
('Richard', 'Webber', 1, 'Director', '555-2010'),
('Cristina', 'Yang', 1, 'Nurse', '555-2011'),
('Meredith', 'Grey', 6, 'Nurse', '555-2012'),
('Alex', 'Karev', 3, 'Nurse', '555-2013'),
('George', 'OMalley', 6, 'Orderly', '555-2014'),
('Izzie', 'Stevens', 5, 'Receptionist', '555-2015'),
('Preston', 'Burke', 1, 'Administrator', '555-2016'),
('Addison', 'Montgomery', 3, 'Manager', '555-2017'),
('Amelia', 'Shepherd', 2, 'Nurse', '555-2018'),
('Jo', 'Wilson', 6, 'Nurse', '555-2019'),
('Maggie', 'Pierce', 1, 'Administrator', '555-2020');

-- Populate Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 6, '2023-06-05 10:00:00', 'Completed'),
(1, 6, '2023-07-10 11:30:00', 'Completed'),
(1, 6, '2023-08-15 09:00:00', 'Completed'),
(1, 6, '2023-09-20 14:00:00', 'Completed'), -- High risk candidate
(4, 1, '2023-09-10 08:30:00', 'Completed'),
(4, 1, '2023-10-12 10:00:00', 'Completed'),
(4, 1, '2023-11-15 11:00:00', 'Completed'),
(4, 4, '2023-12-20 15:30:00', 'Completed'), -- High risk candidate
(8, 2, '2024-01-10 09:45:00', 'Completed'),
(12, 11, '2024-03-05 14:15:00', 'Completed'),
(12, 11, '2024-03-20 10:00:00', 'Completed'),
(12, 18, '2024-04-10 11:30:00', 'Completed'),
(12, 18, '2024-05-01 09:00:00', 'Completed'), -- High risk candidate
(18, 1, '2024-04-25 13:00:00', 'Completed'),
(2, 2, '2023-07-20 10:30:00', 'Completed'),
(3, 10, '2023-08-25 11:00:00', 'Completed'),
(5, 7, '2023-10-20 09:00:00', 'Completed'),
(6, 4, '2023-11-25 15:00:00', 'Cancelled'),
(7, 2, '2023-12-10 10:00:00', 'Completed'),
(9, 6, '2024-01-25 11:30:00', 'Completed'),
(10, 8, '2024-02-15 14:00:00', 'Completed'),
(11, 10, '2024-03-01 09:00:00', 'Completed'),
(13, 20, '2024-03-25 11:00:00', 'Completed'),
(14, 12, '2024-04-05 15:30:00', 'Completed'),
(15, 10, '2024-04-15 10:00:00', 'Completed'),
(16, 4, '2024-04-20 11:30:00', 'Completed'),
(17, 1, '2024-05-01 14:00:00', 'Completed'),
(19, 7, '2024-05-10 09:00:00', 'Scheduled'),
(20, 6, '2024-05-12 11:00:00', 'Scheduled');

-- Populate Medical_Records
INSERT INTO Medical_Records (patient_id, doctor_id, diagnosis, treatment, record_date) VALUES
(1, 6, 'Hypertension', 'Lisinopril 10mg', '2023-06-05'),
(1, 6, 'Follow-up Hypertension', 'Continue Medication', '2023-07-10'),
(4, 1, 'Chronic Migraine', 'Sumatriptan', '2023-09-10'),
(8, 2, 'Lung Nodule', 'Biopsy recommended', '2024-01-10'),
(12, 11, 'Osteoarthritis', 'Physical Therapy', '2024-03-05'),
(18, 1, 'General Weakness', 'Vitamin Supplements', '2024-04-25'),
(2, 2, 'Anemia', 'Iron Supplements', '2023-07-20'),
(3, 10, 'Common Cold', 'Rest and Fluids', '2023-08-25'),
(5, 7, 'Skin Rash', 'Hydrocortisone cream', '2023-10-20'),
(7, 2, 'Mild Fever', 'Paracetamol', '2023-12-10'),
(9, 6, 'Chest Pain', 'ECG conducted', '2024-01-25'),
(10, 8, 'Dizziness', 'Blood tests ordered', '2024-02-15'),
(11, 10, 'Sore Throat', 'Antibiotics', '2024-03-01'),
(13, 20, 'Headache', 'Ibuprofen', '2024-03-25'),
(14, 12, 'Nerve Pain', 'Gabapentin', '2024-04-05'),
(15, 10, 'Ear Infection', 'Ear drops', '2024-04-15'),
(16, 4, 'Back Pain', 'Muscle relaxants', '2024-04-20'),
(17, 1, 'Insomnia', 'Melatonin', '2024-05-01'),
(1, 6, 'Stable BP', 'Maintain lifestyle', '2023-08-15'),
(4, 1, 'Improved Migraine', 'Reduce dosage', '2023-10-12');

-- Populate Invoices
INSERT INTO Invoices (appointment_id, amount, payment_status) VALUES
(1, 150.00, 'Paid'),
(2, 100.00, 'Paid'),
(3, 100.00, 'Paid'),
(4, 120.00, 'Paid'),
(5, 250.00, 'Paid'),
(6, 200.00, 'Paid'),
(7, 200.00, 'Paid'),
(8, 180.00, 'Paid'),
(9, 500.00, 'Paid'),
(10, 300.00, 'Paid'),
(11, 150.00, 'Paid'),
(12, 150.00, 'Paid'),
(13, 150.00, 'Paid'),
(14, 200.00, 'Paid'),
(15, 450.00, 'Paid'),
(16, 80.00, 'Paid'),
(17, 120.00, 'Paid'),
(19, 150.00, 'Paid'),
(20, 100.00, 'Paid'),
(21, 200.00, 'Paid'),
(22, 90.00, 'Paid'),
(23, 600.00, 'Paid'),
(24, 250.00, 'Paid'),
(25, 100.00, 'Paid'),
(26, 180.00, 'Paid'),
(27, 220.00, 'Paid');

-- 3. ADVANCED SQL COMPONENTS
-- ----------------------------------------------------------

-- View: Monthly_Revenue_Report
CREATE OR REPLACE VIEW Monthly_Revenue_Report AS
SELECT 
    DATE_FORMAT(a.appointment_date, '%Y-%m') AS Month,
    d.dept_name,
    CONCAT(dr.first_name, ' ', dr.last_name) AS Doctor_Name,
    SUM(i.amount) AS Total_Revenue,
    COUNT(a.appointment_id) AS Appointment_Count
FROM Appointments a
JOIN Doctors dr ON a.doctor_id = dr.doctor_id
JOIN Departments d ON dr.dept_id = d.dept_id
JOIN Invoices i ON a.appointment_id = i.appointment_id
WHERE i.payment_status = 'Paid'
GROUP BY Month, d.dept_name, Doctor_Name;

-- Stored Procedure: GetPatientHistory
DELIMITER //
CREATE PROCEDURE GetPatientHistory(IN p_patient_id INT)
BEGIN
    SELECT 
        p.first_name, p.last_name,
        mr.record_date, mr.diagnosis, mr.treatment,
        CONCAT('Dr. ', dr.last_name) AS Doctor
    FROM Patients p
    JOIN Medical_Records mr ON p.patient_id = mr.patient_id
    JOIN Doctors dr ON mr.doctor_id = dr.doctor_id
    WHERE p.patient_id = p_patient_id
    ORDER BY mr.record_date DESC;
END //
DELIMITER ;

-- Trigger: Update InvoiceDate
DELIMITER //
CREATE TRIGGER Before_Invoice_Insert
BEFORE INSERT ON Invoices
FOR EACH ROW
BEGIN
    IF NEW.invoice_date IS NULL THEN
        SET NEW.invoice_date = CURRENT_TIMESTAMP;
    END IF;
END //
DELIMITER ;

-- 4. BUSINESS INTELLIGENCE QUERIES
-- ----------------------------------------------------------

-- Q1: Find the top 3 most profitable departments
SELECT 
    d.dept_name, 
    SUM(i.amount) AS Total_Revenue
FROM Departments d
JOIN Doctors dr ON d.dept_id = dr.dept_id
JOIN Appointments a ON dr.doctor_id = a.doctor_id
JOIN Invoices i ON a.appointment_id = i.appointment_id
GROUP BY d.dept_name
ORDER BY Total_Revenue DESC
LIMIT 3;

-- Q2: Identify 'High-Risk' patients (Age > 60 with more than 3 visits)
SELECT 
    p.patient_id, 
    CONCAT(p.first_name, ' ', p.last_name) AS Patient_Name,
    TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) AS Age,
    COUNT(a.appointment_id) AS Visit_Count
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
WHERE TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) > 60
GROUP BY p.patient_id, Patient_Name, Age
HAVING Visit_Count > 3;

-- Q3: Calculate the Month-over-Month growth in patient registrations
WITH Monthly_Reg AS (
    SELECT 
        DATE_FORMAT(registration_date, '%Y-%m') AS Reg_Month,
        COUNT(patient_id) AS New_Patients
    FROM Patients
    GROUP BY Reg_Month
)
SELECT 
    Reg_Month,
    New_Patients,
    LAG(New_Patients) OVER (ORDER BY Reg_Month) AS Prev_Month_Patients,
    ROUND(((New_Patients - LAG(New_Patients) OVER (ORDER BY Reg_Month)) / LAG(New_Patients) OVER (ORDER BY Reg_Month)) * 100, 2) AS Growth_Percentage
FROM Monthly_Reg;

-- Q4: Find doctors who have zero cancellations in their appointments
SELECT 
    dr.doctor_id, 
    CONCAT(dr.first_name, ' ', dr.last_name) AS Doctor_Name
FROM Doctors dr
WHERE dr.doctor_id NOT IN (
    SELECT DISTINCT doctor_id 
    FROM Appointments 
    WHERE status = 'Cancelled'
)
AND dr.doctor_id IN (SELECT DISTINCT doctor_id FROM Appointments); -- Ensure they have at least one appointment
