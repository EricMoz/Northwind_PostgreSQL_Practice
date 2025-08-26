
-- Extract the number of customer orders by month from the last 2 years ('97 & '98) -- 
SELECT 
	EXTRACT(YEAR FROM o.order_date) AS order_year,
	EXTRACT(MONTH FROM o.order_date) AS order_month,
	c.company_name AS company_name,
	COUNT(o.order_id) AS num_orders
FROM 
	orders o
INNER JOIN
	customers c ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM order_date) >= 1997
GROUP BY
	order_year,
	order_month,
	company_name
HAVING
	COUNT(o.order_id) > 1
ORDER BY
	1,2,4 DESC,3;
	
