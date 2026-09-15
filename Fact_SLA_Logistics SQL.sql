-- Task 1 Order Delivery Performance

with cteD1 as (select
so.sales_order_id, customer_id, try_convert (date, order_date, 120) order_date, Try_convert (date, ship_date, 120) ship_date, shipping_status
from sales_orders so
left join shipments sh on so.sales_order_id=sh.sales_order_id
WHERE TRY_CONVERT(DATE, order_date, 120) IS NOT NULL)

select *, Datediff (day, order_date, ship_date) Delivery_days
from cted1 