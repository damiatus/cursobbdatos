USE metro_cdmx;



ALTER TABLE `stations`
MODIFY `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(id);

-- ADD CONSTRAINT `trains_line_id_foreign` #EJemplo de añadir una llave foranea (contraint)
-- FOREIGN KEY (`line_id`) REFERENCES `lines` (`id`);


describe stations


EJEMPLOS:

-- Escribe tu ejercicio aquí 👇
SELECT * FROM asignaturas;

ALTER TABLE `asignaturas`
DROP COLUMN `hora_de_salida`;

ALTER TABLE `asignaturas`
ADD COLUMN hora_de_entrega TIMESTAMP NOT NULL;


CREATE TABLE `estudiantes`(
  `id` INT(40),
  `nombre` VARCHAR(255),
  `asifnatura_id` INT(40),
  PRIMARY KEY(`id`),
  CONSTRAINT `estudiantes_id_asignaturas`
  FOREIGN KEY(`asifnatura_id`) REFERENCES `asignaturas` (`id`)
);