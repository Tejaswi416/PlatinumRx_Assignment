-- 01_Hotel_Schema_Setup.sql
-- Creates Hotel schema and sample data for testing queries (Q1-Q5)

CREATE DATABASE IF NOT EXISTS hotel_db;
USE hotel_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);

CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(20),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Sample data
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('U1','Alice','9700000001','alice@example.com','Addr A'),
('U2','Bob','9700000002','bob@example.com','Addr B'),
('U3','Carol','9700000003','carol@example.com','Addr C');

INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('B001','2021-09-23 07:36:48','R101','U1'),
('B002','2021-09-23 12:05:37','R102','U1'),
('B003','2021-10-12 14:10:00','R201','U2'),
('B004','2021-11-05 18:00:00','R301','U3'),
('B005','2021-11-20 09:30:00','R302','U2'),
('B006','2021-10-18 20:00:00','R103','U1');

INSERT INTO items (item_id, item_name, item_rate) VALUES
('I01','Tawa Paratha',18.00),
('I02','Mix Veg',89.00),
('I03','Breakfast Combo',150.00),
('I04','Dinner Buffet',400.00),
('I05','Coffee',50.00);

-- booking_commercials: include dates across Sep/Oct/Nov 2021
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('C001','B001','BL900','2021-09-23 12:03:22','I01',3),
('C002','B001','BL900','2021-09-23 12:03:22','I02',1),
('C003','B002','BL901','2021-09-23 12:05:37','I01',2),
('C004','B003','BL800','2021-10-12 14:30:00','I04',3),
('C005','B003','BL800','2021-10-12 14:30:00','I02',2),
('C006','B006','BL810','2021-10-18 20:10:00','I03',2),
('C007','B004','BL700','2021-11-05 18:20:00','I02',5),
('C008','B004','BL700','2021-11-05 18:20:00','I05',10),
('C009','B005','BL710','2021-11-20 10:00:00','I04',1),
('C010','B005','BL711','2021-11-20 10:05:00','I01',10),
('C011','B005','BL711','2021-11-20 10:05:00','I02',2),
('C012','B003','BL802','2021-10-25 09:00:00','I05',10),
('C013','B004','BL700','2021-11-05 18:20:00','I03',1);
