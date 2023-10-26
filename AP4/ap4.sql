# Ángelo León y Damián De Aguiar

use ap4;


#P1: LISTA

SELECT YEAR(NOW()) AS aniohoy, YEAR(fecha_nacimiento) AS anio, nombre_personaje
FROM personaje
WHERE YEAR(NOW())-YEAR(fecha_nacimiento) >= 30;

#P2: LISTO
SELECT YEAR(NOW()) AS aniohoy, YEAR(fecha_nacimiento) AS anio, nombre_personaje, rango_ninja
FROM personaje
WHERE (YEAR(NOW()) - YEAR(fecha_nacimiento) >= 30) AND rango_ninja LIKE '%Kage%';

#P3 LISTA
SELECT nombre_personaje, fecha_nacimiento
FROM personaje
JOIN naruto.color_cabello cc on personaje.id_personaje = cc.id_personaje
WHERE (YEAR(fecha_nacimiento) = 1990) AND color_cabello = 'Rosado';

#P4 LISTO
SELECT
    nombre_personaje,
    (YEAR(NOW()) - YEAR(fecha_nacimiento)) AS edad,
    EXP(YEAR(NOW()) - YEAR(fecha_nacimiento)) AS exponencial_edad
FROM
    personaje
ORDER BY
    edad DESC;

#P5 LISTA
SELECT
    personaje.nombre_personaje,
    personaje.id_aldea_nacimiento,
    COUNT(*) AS cantidad_amigos
FROM
    personaje
INNER JOIN
    relacion ON personaje.id_personaje = relacion.id_personaje_a
WHERE
    personaje.id_aldea_nacimiento = 1
    AND relacion.descripcion_relacion LIKE '%Amigos%'
GROUP BY
    personaje.nombre_personaje, personaje.id_aldea_nacimiento
HAVING
    COUNT(*) = (
        SELECT MAX(cantidad_amigos)
        FROM (
            SELECT
                personaje.id_personaje,
                COUNT(*) AS cantidad_amigos
            FROM
                personaje
            INNER JOIN
                relacion ON personaje.id_personaje = relacion.id_personaje_a
            WHERE
                personaje.id_aldea_nacimiento = 1
                AND relacion.descripcion_relacion LIKE '%Amigos%'
            GROUP BY
                personaje.id_personaje
        ) AS subconsulta
    );

#6 LISTA
UPDATE personaje p
SET nombre_personaje = CONCAT(
    (select nombre_aldea from aldea join personaje p2 on aldea.id_aldea = p2.id_aldea_nacimiento),
    '-kage - - ',
    p.nombre_personaje
)
WHERE p.id_personaje IN (
    SELECT p.id_personaje
    FROM personaje p
    LEFT JOIN jutsu j ON p.id_personaje = j.id_personaje
    LEFT JOIN habilidad_especial h ON p.id_personaje = h.id_personaje
    LEFT JOIN arma ar ON p.id_personaje = ar.id_personaje
    LEFT JOIN aldea a on p.id_aldea_nacimiento = a.id_aldea
    WHERE
        (SELECT COUNT(*) FROM jutsu WHERE id_personaje = p.id_personaje) >= 5
        AND (SELECT COUNT(*) FROM habilidad_especial WHERE id_personaje = p.id_personaje) >= 4
        AND (SELECT COUNT(*) FROM arma WHERE id_personaje = p.id_personaje) >= 1
);
