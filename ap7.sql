# Damián De Aguiar y Angelo León

use naruto2;

#p1

SELECT nombre_personaje, TIMESTAMPDIFF(YEAR, fecha_nacimiento, NOW()) AS edad
FROM (
  SELECT nombre_personaje, fecha_nacimiento,
         ROW_NUMBER() OVER (ORDER BY TIMESTAMPDIFF(YEAR, fecha_nacimiento, NOW()) DESC) AS ranking
  FROM personaje
) ranked_characters
WHERE ranking = 1;

#p2


#2 Usando funciones de ventana

SELECT nombre_personaje, numero_armas
FROM (
  SELECT
    p.nombre_personaje,
    COUNT(a.id_arma) AS numero_armas,
    RANK() OVER (ORDER BY COUNT(a.id_arma) DESC) AS ranking
  FROM personaje p
  JOIN arma a ON p.id_personaje = a.id_personaje
  GROUP BY p.id_personaje, p.nombre_personaje
) ranked_characters
WHERE ranking = 1;


#p3
## Con ventana
WITH CantidadRivales AS (
    SELECT
        personaje.id_personaje,
        COUNT(*) AS cantidad_rivales
    FROM
        personaje
    INNER JOIN
        relacion ON personaje.id_personaje = relacion.id_personaje_a OR personaje.id_personaje = relacion.id_personaje_b
    WHERE
        relacion.descripcion_relacion LIKE '%Rivales'
    GROUP BY
        personaje.id_personaje
)

SELECT
    personaje.nombre_personaje,
    CR.cantidad_rivales AS cantidad_rivales,
    RANK() OVER (ORDER BY CR.cantidad_rivales DESC) AS ranking
FROM
    personaje
INNER JOIN
    relacion ON personaje.id_personaje = relacion.id_personaje_a OR personaje.id_personaje = relacion.id_personaje_b
INNER JOIN
    CantidadRivales CR ON personaje.id_personaje = CR.id_personaje
WHERE
    relacion.descripcion_relacion LIKE '%Rivales'
GROUP BY
    personaje.id_personaje, personaje.nombre_personaje
HAVING
    CR.cantidad_rivales = (
        SELECT MAX(cantidad_rivales)
        FROM CantidadRivales
    );


#P4

-- Crear la tabla de posiciones
CREATE TABLE tabla_posiciones (
    id_personaje INT,
    nombre_personaje VARCHAR(255),
    puntaje INT
);

-- Insertar los datos calculados en la tabla de posiciones
INSERT INTO tabla_posiciones (id_personaje, nombre_personaje, puntaje)
SELECT id_personaje, nombre_personaje, SUM(puntos) AS puntaje
FROM (
    SELECT
        p.id_personaje,
        p.nombre_personaje,
        IFNULL(COUNT(r.id_personaje_a), 0) + IFNULL(COUNT(r.id_personaje_b), 0) AS puntos
    FROM personaje p
    LEFT JOIN relacion r ON p.id_personaje = r.id_personaje_a OR p.id_personaje = r.id_personaje_b
    WHERE r.descripcion_relacion IS NOT NULL
    GROUP BY p.id_personaje, p.nombre_personaje

    UNION ALL

    SELECT
        p.id_personaje,
        p.nombre_personaje,
        2 * (IFNULL(COUNT(r.id_personaje_a), 0) + IFNULL(COUNT(r.id_personaje_b), 0)) AS puntos
    FROM personaje p
    LEFT JOIN relacion r ON p.id_personaje = r.id_personaje_a OR p.id_personaje = r.id_personaje_b
    WHERE r.descripcion_relacion LIKE '%Amigo'
    GROUP BY p.id_personaje, p.nombre_personaje

    UNION ALL

    SELECT
        p.id_personaje,
        p.nombre_personaje,
        3 * (IFNULL(COUNT(r.id_personaje_a), 0) + IFNULL(COUNT(r.id_personaje_b), 0)) AS puntos
    FROM personaje p
    LEFT JOIN relacion r ON p.id_personaje = r.id_personaje_a OR p.id_personaje = r.id_personaje_b
    WHERE r.descripcion_relacion LIKE '%Maestro' OR r.descripcion_relacion LIKE '%estudiante'
    GROUP BY p.id_personaje, p.nombre_personaje
) AS PuntosA
GROUP BY id_personaje, nombre_personaje
ORDER BY puntaje DESC;

drop table tabla_posiciones;
-- Crear la tabla de posiciones
CREATE TABLE tabla_posiciones (
    id_personaje INT,
    nombre_personaje VARCHAR(255),
    puntaje INT
);

-- Insertar los datos calculados en la tabla de posiciones
INSERT INTO tabla_posiciones (id_personaje, nombre_personaje, puntaje)
SELECT p.id_personaje, p.nombre_personaje, COALESCE(SUM(puntos), 0) AS puntaje
FROM personaje p
LEFT JOIN (
    SELECT id_personaje_a AS id_personaje, 1 AS puntos
    FROM relacion
    UNION ALL
    SELECT id_personaje_b AS id_personaje, 1 AS puntos
    FROM relacion
    UNION ALL
    SELECT id_personaje AS id_personaje, 2 AS puntos
    FROM relacion
    WHERE descripcion_relacion LIKE '%Amigo%'
    UNION ALL
    SELECT id_personaje AS id_personaje, 3 AS puntos
    FROM relacion
    WHERE descripcion_relacion LIKE '%Maestro%' OR descripcion_relacion LIKE '%estudiante%'
) puntaje_por_relacion
ON p.id_personaje = puntaje_por_relacion.id_personaje
GROUP BY p.id_personaje, p.nombre_personaje
ORDER BY puntaje DESC;

