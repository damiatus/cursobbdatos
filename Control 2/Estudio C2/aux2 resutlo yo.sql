use juegos_olimpicos;
DELETE FROM summer
WHERE Year = "Year";

##P1


#p1.1
Alter table summer
    add id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(id);


select * from summer where id=25;

#p1.2
SELECT
    Year,
    RANK() OVER (ORDER BY Year) AS rankAño
FROM
    summer
GROUP BY
    Year
ORDER BY
    Year;


-- Agrega la columna rankAño a la tabla summer
ALTER TABLE summer
ADD rankAño INT;

-- Actualiza la columna rankAño utilizando el resultado del SELECT
UPDATE summer
JOIN (
    SELECT
        Year,
        RANK() OVER (ORDER BY Year) AS rankAño
    FROM
        summer
    GROUP BY
        Year
    ORDER BY
        Year
) AS ranking
ON summer.Year = ranking.Year
SET summer.rankAño = ranking.rankAño;

#p1.3
WITH RankedAthletes AS (
    SELECT
        Year,
        Athlete,
        Sport,
        Country,
        DENSE_RANK() OVER (ORDER BY Year DESC, NameRank ASC, CountryRank ASC) AS OverallRank
    FROM (
        SELECt Year,Athlete,Sport, Country,
            RANK() OVER (PARTITION BY Year ORDER BY Athlete ASC) AS NameRank,
            RANK() OVER (PARTITION BY Year, Athlete ORDER BY Country ASC) AS CountryRank
        FROM summer
        WHERE Sport = 'Basketball' AND Medal = 'Gold'
    ) AS RankedData
)

SELECT
    Year,
    Athlete,
    Sport,
    Country,
    OverallRank
FROM
    RankedAthletes
ORDER BY
    Year DESC,
    OverallRank;

P1.4

-- Sintaxis básica para crear vistas:
CREATE VIEW total_medallas AS
SELECT Athlete , count(*) as total_medals
FROM summer
group by Athlete;
-- Después se puede consultar de la misma manera que con una tabla real:
SELECT athlete , total_medals,
ROW_NUMBER () OVER (ORDER BY total_medals DESC) AS Row_N
FROM total_medallas
ORDER BY total_medals DESC;


P1.5
Create view Weightlifting_Gold AS
(
SELECT Year ,
Country AS champion
FROM summer
WHERE Discipline = 'Weightlifting '
AND Event = '69KG'
AND Gender = 'Men '
AND Medal = 'Gold ');

SELECT Year ,
Champion ,
LAG(Champion) OVER
(ORDER BY Year ASC) AS Last_Champion

FROM Weightlifting_Gold
ORDER BY Year ASC ;

#p1.6
WITH Discus_Medalists AS (SELECT DISTINCT Year ,
Athlete
FROM summer
WHERE Medal = 'Gold '
AND Event = 'Basketball'
AND Gender = 'Women '
AND Year >= 2000)

SELECT Year ,
Athlete ,
LEAD(Athlete , 3) OVER (ORDER BY Year ASC) AS Future_Champion
FROM Discus_Medalists
ORDER BY Year ASC;

#p1.7
WITH All_Male_Medalists AS (SELECT DISTINCT Athlete
FROM summer
WHERE Medal = 'Gold '
AND Gender = 'Men ')

SELECT Athlete ,
FIRST_VALUE (Athlete) OVER (
ORDER BY Athlete ASC
) AS First_Athlete
FROM All_Male_Medalists ;

#P1.8:

where Hosts as( SELECT distinct Year, City
      FROM summer)

select year, city from Hosts;


CREATE VIEW Hosts AS
SELECT DISTINCT Year, City
FROM summer;

SELECT Year, City, (SELECT City FROM Hosts WHERE Year = (SELECT MAX(Year) FROM Hosts)) AS lastHost
FROM Hosts;


SELECT Year, City
FROM Hosts
WHERE Year = (SELECT MAX(Year) FROM Hosts);
