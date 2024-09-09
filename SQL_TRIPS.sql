 CREATE TABLE `Trips` (
  `id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `driver_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `request_at` varchar(50) DEFAULT NULL
);
 
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (1, 1, 10, 1, 'completed', '2013-10-01');             
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01');   
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (3, 3, 12, 6, 'completed', '2013-10-01');             
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (4, 4, 13, 6, 'cancelled_by_client', '2013-10-01');   
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (5, 1, 10, 1, 'completed', '2013-10-02');             
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (6, 2, 11, 6, 'completed', '2013-10-02');             
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (7, 3, 12, 6, 'completed', '2013-10-02');             
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (8, 2, 12, 12, 'completed', '2013-10-03');            
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (9, 3, 10, 12, 'completed', '2013-10-03');            
 INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES (10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');


-- Completed_Trips %

WITH TotalTrips AS ( 
    SELECT request_at AS Date, COUNT(*) AS Total_Trips 
    FROM Trips 
    GROUP BY request_at
),
CompletedTrips AS ( 
    SELECT request_at AS Date, COUNT(*) AS Completed_Trips 
    FROM Trips 
    WHERE status = 'completed'
    GROUP BY request_at
)
SELECT 
    TT.Date, 
    COALESCE(CT.Completed_Trips, 0) AS Completed_Trips, 
    TT.Total_Trips AS Total_Trips,
    ROUND((COALESCE(CT.Completed_Trips, 0) * 100.0) / TT.Total_Trips, 2) AS Completed_Percentage
FROM TotalTrips TT 
LEFT JOIN CompletedTrips CT 
    ON TT.Date = CT.Date 
ORDER BY TT.Date;

SELECT request_at AS Date,
       COUNT(*) AS Total_Trips,
	   SUM(CASE WHEN status Like 'completed' Then 1 else 0 end) as CompletedTrips,
	   round(COALESCE(SUM(CASE WHEN status Like 'completed' Then 1 else 0 end) * 100 / COUNT(*), 0), 2) AS '%-Completed-Trips'
FROM Trips
GROUP BY request_at;

-- Cancelled_Trips %

WITH TotalTrips AS ( 
    SELECT request_at AS Date, COUNT(1) AS Trips 
    FROM Trips 
    GROUP BY request_at 
),
CancelledTrips AS ( 
    SELECT request_at AS Date, COUNT(1) AS Cancelled_Trips 
    FROM Trips
    WHERE status LIKE 'cancel%' 
    GROUP BY request_at 
)
SELECT TT.Date, 
       TT.Trips AS TOTAL_TRIPS,
	   COALESCE(CT.Cancelled_Trips, 0) AS CANCELLED_TRIPS, 
       ROUND((COALESCE(CT.Cancelled_Trips, 0) * 100.0) / TT.Trips, 2) AS CANCELLED_TRIP_PERCENTAGE
FROM TotalTrips TT 
LEFT JOIN CancelledTrips CT 
    ON TT.Date = CT.Date 
ORDER BY TT.Date;
	   
SELECT
    request_at AS Date,
    COUNT(*) AS TRIPS,
    SUM(CASE WHEN status LIKE 'cancel%' THEN 1 ELSE 0 END) AS CancelledTrips,
    ROUND(COALESCE(SUM(CASE WHEN status LIKE 'cancel%' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 0), 2) AS '%-Cancelled-Trips'
FROM Trips
GROUP BY request_at;
