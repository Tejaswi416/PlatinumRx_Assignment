-- 04_Clinic_Queries.sql
USE clinic_db;

-- Q1: Revenue by sales channel (total revenue per channel)
SELECT sales_channel, SUM(amount) AS total_revenue
FROM clinic_sales
GROUP BY sales_channel
ORDER BY total_revenue DESC;

-- Q2: Top 10 customers by total spend (uid)
SELECT uid, SUM(amount) AS total_spent
FROM clinic_sales
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Q3: Profit/Loss per month (Revenue - Expenses)
WITH rev AS (
  SELECT MONTH(datetime) AS month_no, SUM(amount) AS revenue
  FROM clinic_sales
  GROUP BY MONTH(datetime)
),
exp AS (
  SELECT MONTH(datetime) AS month_no, SUM(amount) AS expense
  FROM expenses
  GROUP BY MONTH(datetime)
)
SELECT r.month_no,
       COALESCE(r.revenue,0) AS revenue,
       COALESCE(e.expense,0) AS expense,
       COALESCE(r.revenue,0) - COALESCE(e.expense,0) AS profit
FROM rev r
LEFT JOIN exp e ON r.month_no = e.month_no
ORDER BY r.month_no;

-- Q4: Most profitable clinic per city in September 2021
WITH profit AS (
  SELECT c.city, cs.cid, SUM(cs.amount) - COALESCE(SUM(e.amount),0) AS profit
  FROM clinics c
  JOIN clinic_sales cs ON c.cid = cs.cid AND MONTH(cs.datetime)=9 AND YEAR(cs.datetime)=2021
  LEFT JOIN expenses e ON c.cid = e.cid AND MONTH(e.datetime)=9 AND YEAR(e.datetime)=2021
  GROUP BY c.city, cs.cid
)
SELECT city, cid, profit
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY city ORDER BY profit DESC) AS rn
  FROM profit
) t WHERE rn = 1;

-- Q5: 2nd least profitable clinic per state in September 2021
WITH profit AS (
  SELECT c.state, cs.cid, SUM(cs.amount) - COALESCE(SUM(e.amount),0) AS profit
  FROM clinics c
  JOIN clinic_sales cs ON c.cid = cs.cid AND MONTH(cs.datetime)=9 AND YEAR(cs.datetime)=2021
  LEFT JOIN expenses e ON c.cid = e.cid AND MONTH(e.datetime)=9 AND YEAR(e.datetime)=2021
  GROUP BY c.state, cs.cid
)
SELECT state, cid, profit
FROM (
  SELECT *, DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
  FROM profit
) t WHERE rnk = 2;
