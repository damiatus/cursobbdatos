use metro_cdmx;

-- Sleeccionar todo
select * from `lines`;


-- Filtrar por columnas
select id, name, color from `lines`;

-- Con AS podemos renomrbar la columna del resultado
select(2+3) as resultado;

-- Calcular promedio de ñais de trnes

SELECT AVG(year) AS year_avg FROM `trains`;

-- juntar tablas: Traemos todos los serial_number y la linea a la que pertenecen cada train

select
    `lines`.`name`, -- seleccionamos la coumna name de tabla lines
    `trains`.`serial_number` -- seleccionamos la coumna serial_number de tabla trains
FROM `lines`
INNER JOIN `trains` -- está buscando dentro de la unión de lines y trains
ON `lines`.`id` = `trains`.`line_id` -- On junta según las llave indicadas. Lines _id es la llave foranea de trains


