use snk;

# Queremos obtener el idPero¿sona más repetido en tabla titán
SELECT id_miembro, fecha_captura, COUNT(id_miembro) AS frecuencia
FROM captura_titan
WHERE YEAR(fecha_captura) = 2022
GROUP BY id_miembro
ORDER BY frecuencia DESC
LIMIT 1;

#p2 Considermos a su nombre completo para el calculo
SELECT CONCAT(nombres, ' ', apellidos) AS nombre_completo
FROM miembros
ORDER BY LENGTH(CONCAT(nombres, ' ', apellidos)) DESC
LIMIT 1;

#p3 Join doble
SELECT COUNT(DISTINCT m.id_miembro) AS total_personas
FROM miembros m
JOIN registro_accidente r ON m.id_miembro = r.id_miembro
JOIN tipo_accidente a ON r.id_tipo_accidente = a.id_tipo_accidente
WHERE a.nombre_tipo_accidente <> 'Ataque de Titan';

#p4

SELECT m.nombres, YEAR(ct.fecha_captura) AS ano, COUNT(ct.id_captura_titan) AS cantidad_capturas
FROM miembros m
JOIN captura_titan ct ON m.id_miembro = ct.id_miembro
WHERE YEAR(ct.fecha_captura) = 2023
GROUP BY m.nombres, ano
HAVING cantidad_capturas = (
    SELECT MAX(cantidad_capturas)
    FROM (
        SELECT m.nombres, YEAR(ct.fecha_captura) AS ano, COUNT(ct.id_captura_titan) AS cantidad_capturas
        FROM miembros m
        JOIN captura_titan ct ON m.id_miembro = ct.id_miembro
        WHERE YEAR(ct.fecha_captura) = 2023
        GROUP BY m.nombres, ano
    ) AS subquery
);

#p5
SELECT m.nombres
FROM miembros m
JOIN (
    SELECT id_miembro, COUNT(*) AS total_accidentes
    FROM registro_accidente
    GROUP BY id_miembro
    HAVING total_accidentes > 10
) AS subquery ON m.id_miembro = subquery.id_miembro;
