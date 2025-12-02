-- 02_Hotel_Queries.sql
USE hotel_db;

-- Q1: Last booked room (latest booking_date) per user
SELECT u.user_id, u.name, b.room_no, b.booking_date
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date) FROM bookings b2 WHERE b2.user_id = u.user_id
);

-- Q2: For bookings billed in Nov 2021, booking_id and total billing amount
SELECT bc.booking_id,
       SUM(bc.item_quantity * i.item_rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 11 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.booking_id;

-- Q3: Bills in Oct 2021 with total > 1000 (group by bill_id)
SELECT bc.bill_id,
       SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

-- Q4: Most and least ordered item per month (by quantity)
WITH monthly_totals AS (
  SELECT MONTH(bc.bill_date) AS month_no, bc.item_id, SUM(bc.item_quantity) AS total_qty
  FROM booking_commercials bc
  GROUP BY MONTH(bc.bill_date), bc.item_id
),
ranked AS (
  SELECT mt.*,
    RANK() OVER (PARTITION BY month_no ORDER BY total_qty DESC) AS rk_desc,
    RANK() OVER (PARTITION BY month_no ORDER BY total_qty ASC) AS rk_asc
  FROM monthly_totals mt
)
SELECT month_no, item_id, total_qty, 'MOST_ORDERED' AS type
FROM ranked WHERE rk_desc = 1
UNION ALL
SELECT month_no, item_id, total_qty, 'LEAST_ORDERED' AS type
FROM ranked WHERE rk_asc = 1
ORDER BY month_no, type;

-- Q5: 2nd highest bill amount per month (by bill_id)
WITH bill_totals AS (
  SELECT bc.bill_id, MONTH(bc.bill_date) AS month_no,
         SUM(bc.item_quantity * i.item_rate) AS amount
  FROM booking_commercials bc
  JOIN items i ON bc.item_id = i.item_id
  GROUP BY bc.bill_id, MONTH(bc.bill_date)
),
ranked AS (
  SELECT bt.*,
    DENSE_RANK() OVER (PARTITION BY month_no ORDER BY amount DESC) AS dr
  FROM bill_totals bt
)
SELECT month_no, bill_id, amount FROM ranked WHERE dr = 2;
