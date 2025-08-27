
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
	

-- using sub-query: get the average number of orders per customer per country --
SELECT ship_country, AVG(num_orders) FROM
	(SELECT customer_id, ship_country, COUNT(*) AS num_orders
	FROM orders
	GROUP BY 1,2) sub
GROUP BY 1;



-- using CTE: get the average number of orders this year ('98) per customer per country --
WITH cte_orders AS (
	SELECT customer_id, ship_country, EXTRACT(YEAR FROM shipped_date) AS shipped_year, COUNT(*) AS num_orders
	FROM orders
	GROUP BY 1,2,3),
	
	cte_customers AS (
	SELECT customer_id, company_name
	FROM customers)


SELECT ship_country, shipped_year, AVG(num_orders)
FROM cte_orders
JOIN cte_customers USING (customer_id)
WHERE shipped_year = 1998
GROUP BY 1, 2
ORDER BY 3 DESC, 1;