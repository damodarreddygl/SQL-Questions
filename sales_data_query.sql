1.

SELECT
    CASE
        WHEN start_date = end_date THEN
             DATE_FORMAT(start_date, '%Y-%m-%d')
        ELSE CONCAT(DATE_FORMAT(start_date, '%Y-%m-%d'), ' - ', DATE_FORMAT(end_date, '%Y-%m-%d'))
    END AS group_date,
    total_sales
FROM (
SELECT
    start_date, end_date, total_sales
FROM (
SELECT MIN(date) AS start_date,
       MAX(date) AS end_date,
       SUM(sales) AS total_sales
FROM (
SELECT date, sales,
       SUM(is_new_group) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_num
FROM (
SELECT date, sales,
        CASE
            WHEN LAG(sales) OVER (ORDER BY date) IS NULL THEN 1
            WHEN sales >= LAG(sales) OVER (ORDER BY date) THEN 0
            ELSE 1
        END AS is_new_group
FROM sales_data
) AS GroupMarkers
) AS GroupNumbers
    GROUP BY group_num
) AS GroupTotals
) AS FormattedGroups
ORDER BY group_date;

2.

WITH SalesDiff AS (
    SELECT date,sales,
        LAG(sales) OVER (ORDER BY date) AS prev_sales
    FROM sales_data
),
GroupMarkers AS (
    SELECT date, sales,
        CASE
            WHEN prev_sales IS NULL THEN 1
            WHEN sales >= prev_sales THEN 0
            ELSE 1
        END AS is_new_group
    FROM SalesDiff
),
GroupNumbers AS (
    SELECT date, sales,
        SUM(is_new_group) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_num
    FROM GroupMarkers
),
GroupTotals AS (
    SELECT  MIN(date) AS start_date,
            MAX(date) AS end_date,
            SUM(sales) AS total_sales
    FROM GroupNumbers
    GROUP BY group_num
),
FormattedGroups AS (
    SELECT
        CASE
            WHEN start_date = end_date THEN
                DATE_FORMAT(start_date, '%Y-%m-%d')
            ELSE
                CONCAT(DATE_FORMAT(start_date, '%Y-%m-%d'), ' - ', DATE_FORMAT(end_date, '%Y-%m-%d'))
        END AS group_date,
        total_sales
    FROM GroupTotals
)
SELECT group_date, total_sales
FROM FormattedGroups
ORDER BY group_date;
