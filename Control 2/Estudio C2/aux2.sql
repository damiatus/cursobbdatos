use snk;

-- A partir de la bbdd de snk. Encontrar al mejor miembro por rango por cantidad de capturas
-- por tipo de titán.
SELECT nombres, rango, subconsulta.nombre_tipo
from (SELECT nombres,
             rango,
             tt.nombre_tipo,
             count(*)                                                                as capturas,
             rank() over (partition by rango, tt.nombre_tipo order by count(*) desc) as orden
      FROM captura_titan
               JOIN miembros m ON captura_titan.id_miembro = m.id_miembro
               JOIN tipo_titan tt ON tt.id_tipo_titan = captura_titan.id_tipo_titan
      group by nombres, rango, tt.nombre_tipo) as subconsulta
where orden = 1;

-- El porcentaje de captura de titanes por tipo, respecto del total de titanes capturados
SELECT id_tipo_titan, capturas / sum(capturas) over ()
from (select id_tipo_titan, count(*) as capturas
      from captura_titan
      group by id_tipo_titan) as subconsulta

-- Lista de los tipos de accidentes más frecuentes, se puede repetir la posición, es decir, puede
-- haber N en cada lugar.

select id_tipo_accidente, count(*), rank() over (order by count(*) desc)
from registro_accidente
group by id_tipo_accidente;

-- Para saber quien es el mejor miembro de todos, realice una tabla de posiciones de los mejores miembros.
-- Dándole 3 puntos por cada captura.
-- 1 punto a los que participaron de un accidente del más bajo factor de mortalidad.
-- dejando descalificados (al final de la tabla), los que tuvieron un accidente fatal o F.


select miembros.id_miembro, miembros.nombres, COALESCE(capturas_puntaje, 0) + COALESCE(accidentes_puntaje, 0),
       rank() over (order by (COALESCE(capturas_puntaje, 0) + COALESCE(accidentes_puntaje, 0)) desc)
from miembros
         left join (select m.id_miembro, nombres, count(*) * 3 as capturas_puntaje
                    from captura_titan
                             join miembros m on m.id_miembro = captura_titan.id_miembro
                    where m.id_miembro not in (select id_miembro
                                               from registro_accidente
                                                        join tipo_accidente ta
                                                             on ta.id_tipo_accidente = registro_accidente.id_tipo_accidente
                                               WHERE nombre_tipo_accidente LIKE '%accidente fatal%'
                                                  or nombre_tipo_accidente LIKE '%F%')
                    group by (nombres)) as capturas on capturas.id_miembro = miembros.id_miembro
         left join (select m.id_miembro, nombres, factor_mortalidad, count(*) * 1 as accidentes_puntaje
                    from registro_accidente
                             join miembros m on m.id_miembro = registro_accidente.id_miembro
                             join tipo_accidente ta on ta.id_tipo_accidente = registro_accidente.id_tipo_accidente
                    where factor_mortalidad = (select min(factor_mortalidad) from tipo_accidente)
                      and m.id_miembro not in (select id_miembro
                                               from registro_accidente
                                                        join tipo_accidente ta
                                                             on ta.id_tipo_accidente = registro_accidente.id_tipo_accidente
                                               WHERE nombre_tipo_accidente LIKE '%accidente fatal%'
                                                  or nombre_tipo_accidente LIKE '%F%')
                    group by m.id_miembro) as accidentes on capturas.id_miembro = accidentes.id_miembro

#Datos_aux_wakatoi_2.1
use p2;
-- A partir de la bbdd de wakatoi_v2. Haga una función LIKE_CANCION(X), que dado el id de un amigo X,
-- entregue true/false si es que le ha dado like a una canción.
CREATE OR REPLACE FUNCTION LIKE_CANCION(id_amigo INT) RETURNS BOOLEAN
BEGIN
    DECLARE amigo_existe BOOLEAN;

    SELECT EXISTS(SELECT 1
                  FROM amigos
                           JOIN like_cancion lc ON amigos.id_amigo = lc.id_amigo
                  WHERE amigos.id_amigo = id_amigo)
    INTO amigo_existe;
    IF amigo_existe THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

SELECT LIKE_CANCION(1);

-- Haga una tabla conteo_likes que usará para guardar el conteo de likes de canciones por amigo(id_amigo).
-- Luego, haga un procedimiento actualizar_conteo_likes que guarde/actualice el conteo de likes por amigo.

CREATE OR REPLACE TABLE conteo_likes
(
    id_conteo_likes int auto_increment primary key,
    id_amigo        int not null,
    conteo          int not null,
    constraint volaron_alto_miembros_id_miembro_fk
        foreign key (id_amigo) references amigos (id_amigo)
);

CREATE OR REPLACE PROCEDURE actualizar_conteo_likes()
BEGIN
    TRUNCATE conteo_likes;
    INSERT INTO conteo_likes (id_amigo, conteo)
    SELECT id_amigo, COUNT(*) as conteo
    FROM like_cancion
    GROUP BY id_amigo;
END;
-- Llamar al procedimiento
CALL actualizar_conteo_likes();

use snk;
-- A partir de la bbdd de snk. Haga una vista que muestre el nombre del miembro de la patrulla de exploración, el tipo de
-- titan, y la cantidad de estos que han sido capturados.

create view capturas as
select miembros.nombres, tt.nombre_tipo, count(*) as cantidad_capturas
from miembros join captura_titan ct on miembros.id_miembro = ct.id_miembro join tipo_titan tt on tt.id_tipo_titan = ct.id_tipo_titan
group by miembros.nombres, tt.nombre_tipo;

#Datos_aux_wakatoi_2.1
use p2;
-- A partir de la bbdd de Wakatoi_v2. Haga una vista conteo_like_amigos_nendoroid que
-- cruce la tabla amigos con conteo_likes y que considere solo amigos que han recibido de
-- regalo una figurita nendoroid.

create view conteo_like_amigos_nendoroid as
    select nombre, f.nombre_figurita, count(*)
        from amigos join like_cancion lc on amigos.id_amigo = lc.id_amigo join amigos_figuritas af on amigos.id_amigo = af.id_amigo join figuritas f on af.id_figurita = f.id_figurita
where id_regalador is not null and f.nombre_figurita = 'Nendoroid'
        group by nombre, f.nombre_figurita

-- A partir de la bbdd de Wakatoi_v2. Cree un usuario Hirotaka con la contraseña que usted
-- desee, y dele permisos para que solo pueda agregar nuevas canciones y álbumes.
CREATE USER hirotaka@localhost IDENTIFIED BY 'contraseña';
GRANT INSERT ON canciones TO hirotaka@localhost;
GRANT INSERT ON album TO hirotaka@localhost;
-- A partir de la bbdd de snk. Cree un usuario de solo lectura.
CREATE USER pedrito@localhost IDENTIFIED BY 'contraseña';
GRANT select on snk.* TO pedrito@localhost;













