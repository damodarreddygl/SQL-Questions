CREATE TABLE employee_visits (
emp_name VARCHAR(50) NOT NULL,
address VARCHAR(100),
floor INT,
resources VARCHAR(50)
);

INSERT INTO employee_visits (emp_name, address, floor, resources)
VALUES
('Rahul', 'Mumbai', 3, 'LAPTOP'),
('Rahul', 'Mumbai', 3, 'PRINTER'),
('Rahul', 'Mumbai', 1, 'DESK'),
('Sohan', 'Delhi', 2, 'CPU'),
('Sohan', 'Delhi', 2, 'MOUSE'),
('Sohan', 'Delhi', 1, 'KEYBOARD'),
('Mohit', 'Hyderabad', 1, 'MONITOR'),
('Mohit', 'Hyderabad', 2, 'HEADPHONES'),
('Mohit', 'Hyderabad', 3, 'MICROPHONE');

SELECT * FROM employee_visits;
+----------+-----------+-------+------------+
| emp_name | address   | floor | resources  |
+----------+-----------+-------+------------+
| Rahul    | Mumbai    |     3 | LAPTOP     |
| Rahul    | Mumbai    |     3 | PRINTER    |
| Rahul    | Mumbai    |     1 | DESK       |
| Sohan    | Delhi     |     2 | CPU        |
| Sohan    | Delhi     |     2 | MOUSE      |
| Sohan    | Delhi     |     1 | KEYBOARD   |
| Mohit    | Hyderabad |     1 | MONITOR    |
| Mohit    | Hyderabad |     2 | HEADPHONES |
| Mohit    | Hyderabad |     3 | MICROPHONE |
+----------+-----------+-------+------------+

WITH FloorCounts AS (
SELECT  emp_name, 
        address, 
        floor,
        COUNT(*) AS floor_visit_count
FROM employee_visits
GROUP BY emp_name, address, floor
),
MaxFloorCounts AS (
SELECT  emp_name,
        address,
        MAX(floor_visit_count) AS max_floor_visit_count
FROM FloorCounts
GROUP BY emp_name
),
MostVisitedFloors AS (
SELECT  fc.emp_name,
        fc.address,
        GROUP_CONCAT(DISTINCT fc.floor ORDER BY fc.floor SEPARATOR ',') AS most_visited_floor
FROM FloorCounts fc
JOIN MaxFloorCounts mfc
ON fc.emp_name = mfc.emp_name 
AND fc.floor_visit_count = mfc.max_floor_visit_count
GROUP BY fc.emp_name
)

SELECT  ev.emp_name,
        ev.address,
        COUNT(*) AS total_visits,
        COALESCE(mvf.most_visited_floor, '') AS most_visited_floor,
        GROUP_CONCAT(DISTINCT ev.resources ORDER BY ev.resources SEPARATOR ',') AS resources_used
FROM employee_visits ev
LEFT JOIN MostVisitedFloors mvf
ON ev.emp_name = mvf.emp_name
GROUP BY ev.emp_name;
+----------+-----------+--------------+--------------------+-------------------------------+
| emp_name | address   | total_visits | most_visited_floor | resources_used                |
+----------+-----------+--------------+--------------------+-------------------------------+
| Mohit    | Hyderabad |            3 | 1,2,3              | HEADPHONES,MICROPHONE,MONITOR |
| Rahul    | Mumbai    |            3 | 3                  | DESK,LAPTOP,PRINTER           |
| Sohan    | Delhi     |            3 | 2                  | CPU,KEYBOARD,MOUSE            |
+----------+-----------+--------------+--------------------+-------------------------------+

SELECT  
    emp_name,
    COUNT(*) AS total_visits,
    MAX(floor) AS most_visited_floor,
    GROUP_CONCAT(resources) AS resources_used
FROM employee_visits
GROUP BY emp_name, address;
+----------+--------------+--------------------+-------------------------------+
| emp_name | total_visits | most_visited_floor | resources_used                |
+----------+--------------+--------------------+-------------------------------+
| Mohit    |            3 |                  3 | MONITOR,HEADPHONES,MICROPHONE |
| Rahul    |            3 |                  3 | LAPTOP,PRINTER,DESK           |
| Sohan    |            3 |                  2 | CPU,MOUSE,KEYBOARD            |
+----------+--------------+--------------------+-------------------------------+


