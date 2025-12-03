-- Clinic queries


-- Q1: Revenue by sales_channel
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
GROUP BY sales_channel
ORDER BY revenue DESC;


-- Q2: (example) Monthly revenue (year-month)
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS year_month, SUM(amount) AS monthly_revenue
FROM clinic_sales
GROUP BY year_month
ORDER BY year_month;


-- Q3: Profit/Loss per month = revenue - expenses
WITH rev AS (
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS year_month, SUM(amount) AS revenue
FROM clinic_sales
GROUP BY year_month
), exp AS (
SELECT DATE_FORMAT(expense_date, '%Y-%m') AS year_month, SUM(amount) AS expenses
FROM expenses
GROUP BY year_month
)
SELECT
COALESCE(r.year_month, e.year_month) AS year_month,
COALESCE(r.revenue, 0) AS revenue,
COALESCE(e.expenses, 0) AS expenses,
(COALESCE(r.revenue,0) - COALESCE(e.expenses,0)) AS profit_loss
FROM rev r
FULL OUTER JOIN exp e ON r.year_month = e.year_month
ORDER BY year_month;
