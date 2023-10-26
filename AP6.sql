
#P1
create database AP6;
use AP6;

CREATE TABLE test (
    id BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(10) NOT NULL,
    color VARCHAR(15) NOT NULL,
    PRIMARY KEY (id)
);

#P2

CREATE USER 'user_ap6'@'localhost' IDENTIFIED BY '123';
GRANT SELECT, INSERT ON AP6.test TO 'user_ap6'@'localhost';
flush privileges;
show grants for 'user_ap6'@'localhost';


#P3



show databases;
SELECT user, host FROM mysql.user;


#P3 pafte 2
USE naruto;


START TRANSACTION; -- Inicia la transacción

-- Realiza el UPDATE en la tabla "personajes" para los registros que cumplan con la condición
UPDATE personaje
SET nombre_personaje = concat(nombre_personaje, primera generacion)
WHERE fecha_nacimiento BETWEEN '1985-01-01' AND '1999-12-31';

-- Si estás seguro de que la actualización es correcta, puedes confirmar la transacción
COMMIT;

-- Si deseas deshacer la transacción (rollback) en caso de un error o para cancelar los cambios, usa
-- ROLLBACK;
