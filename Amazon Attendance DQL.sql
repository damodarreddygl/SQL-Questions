drop table if exists emp_attendance;
create table emp_attendance
(
 employee 	varchar(10),
 dates 		date,
 status 	varchar(20)
);
insert into emp_attendance values('A1', '2024-01-01', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-02', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-03', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-04', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-05', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-06', 'PRESENT');
insert into emp_attendance values('A1', '2024-01-07', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-08', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-09', 'ABSENT');
insert into emp_attendance values('A1', '2024-01-010', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-06', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-07', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-08', 'ABSENT');
insert into emp_attendance values('A2', '2024-01-09', 'PRESENT');
insert into emp_attendance values('A2', '2024-01-010', 'ABSENT');

SELECT * from emp_attendance;

WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY employee ORDER BY dates) AS rn
    FROM emp_attendance
),
CTE_PRESENT AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY employee ORDER BY dates) - rn AS grp
    FROM CTE
    WHERE status = 'PRESENT'
),
CTE_ABSENT AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY employee ORDER BY dates) - rn AS grp
    FROM CTE
    WHERE status = 'ABSENT'
)
SELECT DISTINCT 
    employee AS Employee,
    FIRST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates) AS Start_Date,
    LAST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS End_Date,
    status,
    DATEDIFF(LAST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING), FIRST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates)) + 1 AS Days
FROM CTE_PRESENT
UNION ALL
SELECT DISTINCT 
    employee AS Em,
    FIRST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates) AS Start_Date,
    LAST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS End_Date,
    status,
    DATEDIFF(LAST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING), FIRST_VALUE(dates) OVER (PARTITION BY employee, grp ORDER BY dates)) + 1 AS Days
FROM CTE_ABSENT
ORDER BY employee, Start_Date;

WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY employee ORDER BY dates) AS rn
    FROM emp_attendance
),
GroupedCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY employee, status ORDER BY dates) 
        - ROW_NUMBER() OVER (PARTITION BY employee ORDER BY dates) AS grp
    FROM CTE
),
AggregatedCTE AS (
    SELECT 
        employee,
        status,
        MIN(dates) AS Start_Date,
        MAX(dates) AS End_Date,
        COUNT(*) AS Days
    FROM GroupedCTE
    GROUP BY employee, status, grp
)
SELECT 
    employee,
    status,
    Start_Date,
    End_Date,
    Days
FROM AggregatedCTE
ORDER BY employee, Start_Date;
