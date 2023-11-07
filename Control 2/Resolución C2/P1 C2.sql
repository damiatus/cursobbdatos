#Damián De Aguiar

use naruto3;

## p1.1 Funcióin que wntrega 1 solo si el persojae ha dado like o superlike 1 vez.
CREATE OR REPLACE FUNCTION LIKE_PERSONAJE(personaje INT)
RETURNS BOOLEAN
BEGIN
  DECLARE like_count INT;

  -- Contar la cantidad de "like" o "superlike" dados por personaje_da
  SELECT COUNT(*) INTO like_count
  FROM interaccion
  WHERE personaje_da = personaje
    AND tipo_interaccion IN ('like', 'superlike');

  -- Si la cantidad de "like" o "superlike" es igual a 1, devuelve TRUE
  IF like_count = 1 THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END;

-- Llamamos a la función y pasamos el ID del personaje como argumento
SELECT LIKE_PERSONAJE(30) AS ha_dado_likes_superlikes;


## p1.2A Creamos la tabla para almacenar likes
CREATE TABLE conteo_likes (
    id_personaje INT PRIMARY KEY,
    total_likes INT,
    FOREIGN KEY (id_personaje) REFERENCES personaje(id_personaje)
);

## p1.2B
DELIMITER //

CREATE PROCEDURE InsertOrUpdateLikeCount2(
    IN personaje_id INT
)
BEGIN
    DECLARE like_count INT;

    -- Contar la cantidad de "like" o "superlike" dados por personaje_id
    SELECT COUNT(*) INTO like_count
    FROM interaccion
    WHERE personaje_da = personaje_id
    AND tipo_interaccion IN ('like', 'superlike');

    -- Insertar o actualizar el conteo de likes en conteo_likes
    INSERT INTO conteo_likes (id_personaje, total_likes)
    VALUES (personaje_id, like_count)
    ON DUPLICATE KEY UPDATE total_likes = like_count;
END;
//

DELIMITER ;

#Usamos el procedimiento sobre el personaje con id=24 para tener un
# personaje que ha dado solo 1 like en la parte siguietne y probar la función
CALL InsertOrUpdateLikeCount2(24);

## p1.3
CREATE or replace VIEW exito_asegurado AS
SELECT
    p.id_personaje,
    p.nombre_personaje,
    cl.total_likes
FROM
    personaje p
JOIN
    conteo_likes cl ON p.id_personaje = cl.id_personaje
WHERE
    LIKE_PERSONAJE(p.id_personaje) = 1; #consdieramos los casos verdaderso, osae 1




#p1.4
#Para este control llamé a mi base de datos "naruto3"
CREATE USER 'Michistrikis'@'localhost' IDENTIFIED BY 'ahora no';
GRANT DELETE ON naruto3.conteo_likes TO 'Michistrikis'@'localhost';
Flush PRIVILEGES ; #Hacemos efectivos los cambios

SHOW GRANTS FOR 'Michistrikis'@'localhost'; # Vemos los permisos de Michistrikis







