-- AP03 Ángelo León y Damián De Aguiar

-- Parte 1:

-- Personajes
insert into `personaje`(nombre_personaje, estatura, fecha_nacimiento, rango_ninja, estado, id_aldea_residencia, id_aldea_nacimiento) values
("Damián", 179, '2001-01-02', "Hokage", "muerto",1,1),
("Ángelo", 130, '2001-02-22', "Genin", "vivo",1,1),
("Darwin", 205, '2001-05-25', "Mecánico", "vivo",1,1),
("Juán Mecánico", 179, '2001-01-02', "Darwin", "muerto",1,1),
("Itachi", 170, '1990-01-02', "Ambu", "muerto",1,1), -- Me spoilearon :(
("Felipe", 170, '1980-01-02', null, "muerto",1,1),
("Michelle", 159, '2000-06-07', "Hokage", "vivo",1,1),
("Naruto", 165, '2001-12-03', "Genin", "vivo",1,1),
("Sasuke", 175, '2001-12-03', "Genin", "vivo",1,1),
("Melanie", 5, '2012-09-04', "Genin", "vivo",1,1),
("Valentina", 365, '2023-08-28', "Genin", "vivo",1,1);

-- 1 aldea
insert into `aldea`(nombre_aldea, ubicacion) values
("Konoha","Aldea De La Hoja");

-- 2 armas
insert into `arma`(id_personaje, nombre_arma) values
(5,"Cuchillo mantequilla"),
(2,"Cuchara");

-- 3 habilidades especiales
insert into `habilidad_especial`(id_personaje, nombre_habilidad_especial)  values
(10,"Saltar en un pié"),
(7,"Cocinar pantrucas"),
(4,"Usar DataGrip");

-- 4 relaciones
insert into `relacion`(id_personaje_a, id_personaje_b, descripcion_relacion) values
(8,9,"Amorosa"),
(1,2,"Amistad"),
(4,3,"Complicada"),
(10,11,"Amistad"),
(6,7,"Familia");

-- Parte 2
UPDATE `personaje`
SET estatura = 180
WHERE nombre_personaje = "Damián";

-- P3
insert into `personaje`(nombre_personaje, estatura, fecha_nacimiento, rango_ninja, estado, id_aldea_residencia, id_aldea_nacimiento) values
("Hinata", 150, '2005-01-04', "Jonin", "muerto",1,1);

insert into `relacion`(id_personaje_a, id_personaje_b, descripcion_relacion) values
(8,12,"Amorosa"),
(12,1,"Amistad"),
(12,2,"Complicada");

UPDATE `personaje`
JOIN relacion ON personaje.id_personaje = relacion.id_personaje_a OR personaje.id_personaje = relacion.id_personaje_b
SET personaje.nombre_personaje = CONCAT(nombre_personaje, "-kun")
WHERE relacion.descripcion_relacion = "Amistad" OR relacion.descripcion_relacion = "Amorosa"
AND (relacion.id_personaje_a = 12 OR relacion.id_personaje_b = 12);

-- P4: Estamos considerando al borrar que las llaves foraneas de personjae fueron
-- creadas con la propiedad ON DELETE CASCADE para poder borrar de una sola vez todos los registros
-- de un personaje

insert into `personaje`(nombre_personaje, estatura, fecha_nacimiento, rango_ninja, estado, id_aldea_residencia, id_aldea_nacimiento) values
("Hidan", 150, '2005-01-04', "Jonin", "muerto",1,1);

DELETE FROM personaje
       WHERE nombre_personaje = "Hidan";


-- P5

-- Creamos otra aldea

insert into `aldea`(nombre_aldea, ubicacion) values
("Tuerca","Aldea Oculta del mecánico");

-- Creamos otro personaje en la nueva alde
insert into `personaje`(nombre_personaje, estatura, fecha_nacimiento, rango_ninja, estado, id_aldea_residencia, id_aldea_nacimiento) values
("Juana Mecánica", 150, '2005-01-04', "Jonin", "muerto",2,2);

-- Eliminamos el personaje
DELETE FROM personaje
       WHERE id_aldea_residencia != 1;