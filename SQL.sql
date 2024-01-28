-- Question 3. Count records
SELECT COUNT(1) FROM yellow_taxi_trips
WHERE DATE(lpep_pickup_datetime) = '2019-09-18' AND DATE(lpep_dropoff_datetime) = '2019-09-18';

-- Question 4. Largest trip for each day
SELECT *, lpep_dropoff_datetime - lpep_pickup_datetime AS distance FROM yellow_taxi_trips
ORDER BY distance DESC LIMIT 1

-- Question 5. Three biggest pick up Boroughs
SELECT COUNT(1) AS Amt, z."Borough"
FROM yellow_taxi_trips t
INNER JOIN zones z ON t."PULocationID" = z."LocationID"
GROUP BY z."Borough" ORDER BY Amt DESC LIMIT 3

-- Question 6. Largest tip
SELECT SUM(t.tip_amount) AS total_tip_amount,z_PU."Zone", z_DO."Zone"
FROM yellow_taxi_trips t
INNER JOIN zones z_PU ON t."PULocationID" = z_PU."LocationID"
INNER JOIN zones z_DO ON t."DOLocationID" = z_DO."LocationID"
WHERE DATE(t.lpep_pickup_datetime) BETWEEN '2019-09-01 00:00:00' AND '2019-09-30 23:59:59'
AND z_PU."Zone" = 'Astoria'
GROUP BY z_DO."Zone", z_PU."Zone"
ORDER BY total_tip_amount DESC