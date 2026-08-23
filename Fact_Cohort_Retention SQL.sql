-- 1. Each Customer's first purchase date

with cteA1 as (select
customer_id, Try_convert (date, order_date, 120) single_format_order_date
from sales_orders WHERE TRY_CONVERT(DATE, order_date, 120) IS NOT NULL)

select customer_id, min (single_format_order_date) first_order_date
from cteA1 
group by customer_id
order by min (single_format_order_date);


-- 2. Each Customer's Cohort month

with cteB1 as (select
customer_id, min (Try_convert (date, order_date, 120)) first_order_date
from sales_orders
WHERE TRY_CONVERT(DATE, order_date, 120) IS NOT NULL
group by customer_id)

select
customer_id, DATETRUNC(month, first_order_date) Cohort_month
from cteB1
order by DATETRUNC(month, first_order_date);


-- 3. Month Index (0, 1, 2,...)

select 
sales_order_id,
customer_id, 
DateTrunc (month, Min (try_convert (date, order_date, 120)) over (partition by customer_id order by customer_id, try_convert (date, order_date, 120))) Cohort_month,
Datetrunc (month, try_convert (date, order_date, 120)) purchase_month,
datediff (month, DateTrunc (month, Min (try_convert (date, order_date, 120)) over (partition by customer_id order by customer_id, try_convert (date, order_date, 120))), Datetrunc (month, try_convert (date, order_date, 120))) Month_number,
total_amount
from sales_orders
WHERE TRY_CONVERT(DATE, order_date, 120) IS NOT NULL;


-- 4. Retention Matrix

with cteC1 as (select 
customer_id, 
DateTrunc (month, Min (try_convert (date, order_date, 120)) over (partition by customer_id order by customer_id, try_convert (date, order_date, 120))) Cohort_month,
Datetrunc (month, try_convert (date, order_date, 120)) purchase_month,
datediff (month, DateTrunc (month, Min (try_convert (date, order_date, 120)) over (partition by customer_id order by customer_id, try_convert (date, order_date, 120))), Datetrunc (month, try_convert (date, order_date, 120))) Month_number,
total_amount
from sales_orders
WHERE TRY_CONVERT(DATE, order_date, 120) IS NOT NULL)

select cohort_month, month_number, Round (sum (total_amount), 1) Total_revenue
from cteC1
group by cohort_month, month_number
order by cohort_month, month_number;


-- 5. Cohort Matrix View

with cteC1 as (select 
customer_id, 
DateTrunc (month, Min (try_convert (date, order_date, 120)) over (partition by customer_id order by customer_id, try_convert (date, order_date, 120))) Cohort_month,
Datetrunc (month, try_convert (date, order_date, 120)) purchase_month,
datediff (month, DateTrunc (month, Min (try_convert (date, order_date, 120)) over (partition by customer_id order by customer_id, try_convert (date, order_date, 120))), Datetrunc (month, try_convert (date, order_date, 120))) Month_number,
total_amount
from sales_orders
WHERE TRY_CONVERT(DATE, order_date, 120) IS NOT NULL),

cteC2 as (select cohort_month, month_number, Round (sum (total_amount), 1) Total_revenue
from cteC1
group by cohort_month, month_number)

select
cohort_month,
SUM(CASE WHEN month_number = 0 THEN total_revenue ELSE 0 END) AS [0],
SUM(CASE WHEN month_number = 1 THEN total_revenue ELSE 0 END) AS [1],
SUM(CASE WHEN month_number = 2 THEN total_revenue ELSE 0 END) AS [2],
SUM(CASE WHEN month_number = 3 THEN total_revenue ELSE 0 END) AS [3],
SUM(CASE WHEN month_number = 4 THEN total_revenue ELSE 0 END) AS [4],
SUM(CASE WHEN month_number = 5 THEN total_revenue ELSE 0 END) AS [5]
from cteC2
group by Cohort_month
order by Cohort_month