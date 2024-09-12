1.
SELECT category, 
    COUNT(1) AS No_of_Bikes
FROM bike
GROUP BY category
HAVING No_of_Bikes > 2;

2.
SELECT c.name, 
    COUNT(m.membership_type_id) AS membership_count 
FROM customer c LEFT JOIN membership m 
ON c.id = m.customer_id 
GROUP BY c.name 
ORDER BY membership_count DESC;

3.
SELECT id, 
    category, 
    price_per_hour AS old_price_hour, 
    CASE WHEN category = 'electric' THEN ROUND(price_per_hour - (price_per_hour * 0.1), 2) 
        WHEN category = 'mountain bike' THEN ROUND(price_per_hour - (price_per_hour * 0.2), 2)
        ELSE ROUND(price_per_hour - (price_per_hour * 0.5), 2) 
    END AS new_price_per_hour,
    price_per_day AS old_price_per_day,
    CASE WHEN category = 'electric' THEN ROUND(price_per_day - (price_per_day * 0.2), 2)
        WHEN category = 'mountain bike' THEN ROUND(price_per_day - (price_per_day * 0.5), 2)
        ELSE ROUND(price_per_day - (price_per_day * 0.5), 2) 
    END AS new_price_per_day
FROM bike;

4.
SELECT category,
    COALESCE(CASE WHEN status = 'available' THEN COUNT(status) END, 0) AS avl,
    COALESCE(CASE WHEN status = 'rented' THEN COUNT(status) END, 0) AS ren 
FROM bike
GROUP BY category;

5.
-- Group by year and month
SELECT EXTRACT(YEAR FROM start_timestamp) AS year,
    EXTRACT(MONTH FROM start_timestamp) AS month,
    SUM(total_paid) AS revenue
FROM rental
GROUP BY EXTRACT(YEAR FROM start_timestamp), EXTRACT(MONTH FROM start_timestamp)

UNION ALL

-- Group by year only (for year totals)
SELECT EXTRACT(YEAR FROM start_timestamp) AS year,
    NULL AS month,
    SUM(total_paid) AS revenue
FROM rental
GROUP BY EXTRACT(YEAR FROM start_timestamp)

UNION ALL

-- Grand total
SELECT NULL AS year,
    NULL AS month,
    SUM(total_paid) AS revenue
FROM rental
ORDER BY year, month;

/*
SELECT EXTRACT(YEAR FROM start_timestamp) AS year,
    EXTRACT(MONTH FROM start_timestamp) AS month,
    SUM(total_paid) AS revenue
FROM rental
GROUP BY EXTRACT(YEAR FROM start_timestamp), EXTRACT(MONTH FROM start_timestamp) WITH ROLLUP
ORDER BY year, month;
*/

6.
SELECT 
    EXTRACT(YEAR FROM m.start_date) AS YR, 
    EXTRACT(MONTH FROM m.start_date) AS MNTH,
    mt.name AS name,
    SUM(m.total_paid) AS total_revenue
FROM membership m 
INNER JOIN membership_type mt ON mt.id = m.membership_type_id
GROUP BY YR, MNTH, name
ORDER BY YR, MNTH, name;

7.
-- Query for grouping by membership type and month
SELECT mt.name AS membership_type_name,
    EXTRACT(MONTH FROM start_date) AS month,
    SUM(total_paid) AS total_revenue
FROM membership m
JOIN membership_type mt 
ON m.membership_type_id = mt.id
WHERE EXTRACT(YEAR FROM start_date) = 2023
GROUP BY membership_type_name, EXTRACT(MONTH FROM start_date)

UNION ALL

-- Query for grouping only by membership type (with month as NULL)
SELECT mt.name AS membership_type_name,
    NULL AS month,
    SUM(total_paid) AS total_revenue
FROM membership m
JOIN membership_type mt 
ON m.membership_type_id = mt.id
WHERE EXTRACT(YEAR FROM start_date) = 2023
GROUP BY membership_type_name
ORDER BY membership_type_name, month;

/*
SELECT 
    mt.name AS membership_type_name,
    EXTRACT(MONTH FROM start_date) AS month,
    SUM(total_paid) AS total_revenue
FROM membership m
JOIN membership_type mt 
ON m.membership_type_id = mt.id
WHERE EXTRACT(YEAR FROM start_date) = 2023
GROUP BY membership_type_name, EXTRACT(MONTH FROM start_date) WITH ROLLUP
ORDER BY membership_type_name, month;
*/

8.
SELECT tmp.category AS Rental_Count_Category,
    COUNT(1) AS Customer_Count 
FROM (
SELECT customer_id, 
    COUNT(1),
    CASE WHEN COUNT(1) > 10 THEN 'MORE THAN 10'
        WHEN COUNT(1) BETWEEN 5 AND 10 THEN 'B/W 5 & 10'
        ELSE 'FEWER THAN 5'
    END AS category
FROM rental
GROUP BY customer_id
)tmp
GROUP BY category
ORDER BY Customer_Count;