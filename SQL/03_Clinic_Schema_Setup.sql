-- 03_Clinic_Schema_Setup.sql
-- Clinic schema and sample data for Part B

CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS clinics;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100)
);

CREATE TABLE clinic_sales (
    sale_id VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    uid VARCHAR(50), -- customer id
    sales_channel VARCHAR(50), -- e.g., online, walkin, corporate
    amount DECIMAL(12,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
    expense_id VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    amount DECIMAL(12,2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- sample clinics
INSERT INTO clinics VALUES
('C100','City Health A','Mumbai','Maharashtra'),
('C200','CarePlus B','Pune','Maharashtra'),
('C300','Wellness C','Bengaluru','Karnataka');

-- sample sales across months and channels
INSERT INTO clinic_sales VALUES
('S1','C100','U100','online',500.00,'2021-09-05 10:00:00'),
('S2','C100','U101','walkin',1500.00,'2021-09-10 11:00:00'),
('S3','C200','U102','corporate',2000.00,'2021-09-12 15:00:00'),
('S4','C200','U103','online',800.00,'2021-10-05 09:00:00'),
('S5','C300','U104','walkin',1200.00,'2021-10-06 10:00:00'),
('S6','C100','U105','online',700.00,'2021-11-02 14:00:00'),
('S7','C200','U106','walkin',300.00,'2021-11-03 16:00:00'),
('S8','C300','U107','corporate',2500.00,'2021-09-20 13:00:00'),
('S9','C100','U108','offline',400.00,'2021-09-25 12:00:00'),
('S10','C300','U109','online',600.00,'2021-09-30 09:00:00');

-- sample expenses
INSERT INTO expenses VALUES
('E1','C100',400.00,'2021-09-15 08:00:00'),
('E2','C200',500.00,'2021-09-20 09:00:00'),
('E3','C300',700.00,'2021-09-21 10:00:00'),
('E4','C100',200.00,'2021-10-10 12:00:00'),
('E5','C200',300.00,'2021-10-12 11:00:00'),
('E6','C300',400.00,'2021-10-13 15:00:00'),
('E7','C100',350.00,'2021-11-05 10:00:00'),
('E8','C200',150.00,'2021-11-06 11:00:00'),
('E9','C300',250.00,'2021-11-07 12:00:00');
