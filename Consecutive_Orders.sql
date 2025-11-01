-- Create Query

CREATE TABLE Orders (
 customer_id INT,
 order_date DATE,
 coupon_code VARCHAR(50)
);

-- Insert Query

INSERT INTO Orders VALUES (1, '2025-01-10', NULL);
INSERT INTO Orders VALUES (1, '2025-02-05', NULL);
INSERT INTO Orders VALUES (1, '2025-02-20', NULL);
INSERT INTO Orders VALUES (1, '2025-03-01', NULL);
INSERT INTO Orders VALUES (1, '2025-03-10', NULL);
INSERT INTO Orders VALUES (1, '2025-03-15', 'DISC10'); 
INSERT INTO Orders VALUES (2, '2025-02-02', NULL); 
INSERT INTO Orders VALUES (2, '2025-02-05', NULL); 
INSERT INTO Orders VALUES (2, '2025-03-05', NULL); 
INSERT INTO Orders VALUES (2, '2025-03-18', NULL);
INSERT INTO Orders VALUES (2, '2025-03-20', NULL); 
INSERT INTO Orders VALUES (2, '2025-03-22', NULL);
INSERT INTO Orders VALUES (2, '2025-04-02', NULL); 
INSERT INTO Orders VALUES (2, '2025-04-10', NULL);
INSERT INTO Orders VALUES (2, '2025-04-15', 'DISC20'); 
INSERT INTO Orders VALUES (2, '2025-04-16', NULL); 
INSERT INTO Orders VALUES (2, '2025-04-18', NULL);
INSERT INTO Orders VALUES (2, '2025-04-20', 'DISC20'); 
INSERT INTO Orders VALUES (3, '2025-03-05', NULL); 
INSERT INTO Orders VALUES (3, '2025-04-10', NULL); 
INSERT INTO Orders VALUES (3, '2025-05-15', 'DISC30');
INSERT INTO Orders VALUES (4, '2025-02-01', NULL); 
INSERT INTO Orders VALUES (4, '2025-04-05', 'DISC40'); 
INSERT INTO Orders VALUES (5, '2025-01-03', NULL); 
INSERT INTO Orders VALUES (5, '2025-02-05', NULL); 
INSERT INTO Orders VALUES (5, '2025-02-15', NULL);
INSERT INTO Orders VALUES (5, '2025-03-01', NULL); 
INSERT INTO Orders VALUES (5, '2025-03-08', 'DISC50'); 
INSERT INTO Orders VALUES (5, '2025-03-20', NULL); 
INSERT INTO Orders VALUES (6, '2025-01-05', NULL); 
INSERT INTO Orders VALUES (6, '2025-03-02', NULL); 
INSERT INTO Orders VALUES (6, '2025-03-15', NULL); 
INSERT INTO Orders VALUES (6, '2025-05-05', NULL); 
INSERT INTO Orders VALUES (6, '2025-05-10', NULL); 
INSERT INTO Orders VALUES (6, '2025-05-25', 'DISC60'); 

-- Retrireve Query

WITH Monthly AS (
SELECT 
	customer_id,
    DATE_FORMAT(order_date, '%Y-%m') AS Month,
    COUNT(*) AS order_count
FROM Orders
GROUP BY customer_id, DATE_FORMAT(order_date, '%Y-%m')
),
Ranked AS (
SELECT 
	customer_id,
    order_count,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY month) AS Month_Rank
FROM Monthly
),
First_Three AS (
SELECT 
	customer_id,
    MAX(CASE WHEN Month_Rank= 1 THEN order_count END) AS First_Month,
    MAX(CASE WHEN Month_Rank= 2 THEN order_count END) AS Second_Month,
    MAX(CASE WHEN Month_Rank= 3 THEN order_count END) AS Third_Month
FROM Ranked
GROUP BY customer_id
),
Valid_Customers AS (
SELECT 
	customer_id
FROM First_Three
WHERE Second_month = 2 * First_month
	AND Third_month = 3 * First_month
),
Last_Order_With_Coupon AS (
SELECT 
	O.customer_id
FROM Orders O
JOIN (
SELECT 
	customer_id, 
	MAX(order_date) AS last_order_date
FROM Orders
GROUP BY customer_id
) L ON O.customer_id = L.customer_id AND O.order_date = L.last_order_date
WHERE O.coupon_code IS NOT NULL
)
SELECT 
	V.customer_id AS `Customer ID`
FROM Valid_Customers V
JOIN Last_Order_With_Coupon C ON V.customer_id = C.customer_id;

+-------------+
| Customer ID |
+-------------+
|           1 |
|           2 |
|           6 |
+-------------+
3 rows in set (0.00 sec)