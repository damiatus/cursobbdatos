use p2;

#p1
SELECT dob
FROM drivers
WHERE forename = 'Michael' AND surname = 'Schumacher';


#p2
SELECT year AS año, COUNT(*) AS cantidad_carreras
FROM races
GROUP BY year
ORDER BY cantidad_carreras DESC
LIMIT 1;

#p3
SELECT year as año
FROM races
WHERE year = 2005
ORDER BY year ASC
LIMIT 1;

#p4
SELECT c.country, COUNT(*) AS cantidad_carreras
FROM circuits c
JOIN races r ON c.circuitId = r.circuitId
GROUP BY c.country
ORDER BY cantidad_carreras DESC
LIMIT 1;


#p5
SELECT d.forename AS nombre_corredor, SUM(points) AS total_puntos
FROM results r
JOIN drivers d ON r.driverId = d.driverId
JOIN races r2 ON r.raceId = r2.raceId
WHERE YEAR(r2.date) = 2018
GROUP BY d.forename
ORDER BY total_puntos DESC
LIMIT 1;

#p6
# #el criterio es quien haya salido más veces número  1

SELECT d.forename AS nombre_corredor, COUNT(*) AS total_posiciones_1
FROM results r
JOIN drivers d ON r.driverId = d.driverId
JOIN races ra ON r.raceId = ra.raceId
WHERE r.positionOrder = 1
GROUP BY d.forename
ORDER BY total_posiciones_1 DESC
LIMIT 1;
