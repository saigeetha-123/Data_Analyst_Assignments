-- Q1: Last booked room (room number) — latest booked_at
SELECT r.room_number, b.booked_at
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
ORDER BY b.booked_at DESC
LIMIT 1;


-- Q2: Billing in Nov 2021 (sum of quantity * rate for bookings whose booked_at in Nov 2021)
SELECT SUM(bc.quantity * i.rate) AS total_billing_nov2021
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
WHERE b.booked_at >= '2021-11-01' AND b.booked_at < '2021-12-01';


-- Q3: Bookings with bills > 1000 (total bill per booking)
SELECT b.booking_id, g.guest_name, SUM(bc.quantity * i.rate) AS bill_total
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
JOIN guests g ON b.guest_id = g.guest_id
GROUP BY b.booking_id, g.guest_name
HAVING SUM(bc.quantity * i.rate) > 1000;


-- Q4: Most and least ordered item per month
-- We'll aggregate by month and item, then use window functions to find top/bottom per month


WITH month_item AS (
SELECT
DATE_FORMAT(b.booked_at, '%Y-%m') AS year_month,
i.item_name,
SUM(bc.quantity) AS qty
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
GROUP BY 1,2
)
, ranked AS (
SELECT
year_month,
item_name,
qty,
RANK() OVER (PARTITION BY year_month ORDER BY qty DESC) AS r_desc,
RANK() OVER (PARTITION BY year_month ORDER BY qty ASC) AS r_asc
FROM month_item
)
SELECT 'most' AS which, year_month, item_name, qty
FROM ranked WHERE r_desc = 1
UNION ALL
SELECT 'least' AS which, year_month, item_name, qty
FROM ranked WHERE r_asc = 1
ORDER BY year_month, which;


-- Q5: 2nd highest bill (booking-wise)
WITH booking_totals AS (
SELECT
b.booking_id,
g.guest_name,
SUM(bc.quantity * i.rate) AS total_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
JOIN bookings b ON bc.booking_id = b.booking_id
JOIN guests g ON b.guest_id = g.guest_id
GROUP BY b.booking_id, g.guest_name
)
SELECT booking_id, guest_name, total_amount
FROM (
SELECT *, DENSE_RANK() OVER (ORDER BY total_amount DESC) as rk
FROM booking_totals
) t
WHERE rk = 2;