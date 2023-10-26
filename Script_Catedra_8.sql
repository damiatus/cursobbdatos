# Creación de 200000 capturas al azar.

create table captura(
    id int,
    fechaCaptura datetime
);

# Finalmente, este es el método para poder insertar muchos registros a la vez.
# Se utilizó la sentencia REPEAT, que es una forma de simular un FOR
# En mi computador, 200 mil registros se insertaron en 3 minutos aprox.

   SET @x = 0;
    REPEAT
        insert into captura values
(
     round(rand()*1015) ,

adddate(now(),INTERVAL -round(rand()*1800) DAY));

        SET @x = @x + 1;
    UNTIL @x <= 200000 END REPEAT;

select count(*) from captura;


# Consultas para analizar el trabajo posterior con las funciones de ventana.

select t.tipo, p.nombre, c.fechaCaptura from captura c
inner join pkmn_tipo pt on c.id = pt.id_pkmn
inner join tipo t on pt.id_tipo = t.id_tipo
inner join pokemon p on pt.id_pkmn = p.id
order by tipo, c.id;

select t.tipo, p.nombre, count(*) capturas from captura c
inner join pkmn_tipo pt on c.id = pt.id_pkmn
inner join tipo t on pt.id_tipo = t.id_tipo
inner join pokemon p on pt.id_pkmn = p.id
group by p.nombre, t.tipo
order by tipo, capturas desc;

select p.id, nombre, count(*) capturas from captura c
inner join pokemon p on c.id = p.id
group by nombre
order by capturas desc;

select t.tipo, count(distinct p.id), count(*) capturas from captura c
inner join pokemon p on c.id = p.id
inner join pkmn_tipo pt on c.id = pt.id_pkmn
inner join tipo t on t.id_tipo = pt.id_tipo
group by t.tipo
order by capturas desc;

# Consultas con funciones de ventana

select t.tipo,p.nombre, count(*) captura,
       count(*) over (partition by t.tipo) capturas_tipo,
       rank() over (partition by t.tipo order by count(*) desc) ranking_tipo,
       rank() over (order by count(*) desc) ranking_global,
       dense_rank() over (partition by t.tipo order by count(*) desc) ranking2,
       row_number() over (partition by t.tipo order by count(*) desc) ranking3
# Vean aquí que tanto el tipo, nombre y el concepto de count(*) son inputs para la función de ventana
from captura c
join pokemon p on c.id = p.id
join pkmn_tipo pt on c.id = pt.id_pkmn
join tipo t on t.id_tipo = pt.id_tipo
group by t.tipo,p.nombre
# Noten que el group by actúa sobre tipo y nombre, pero en el ranking lo considera solamente por el order by
order by captura desc;


# Esta es la consulta que estaba buscando en clases, dejaré la que usamos igual, para que consideren esa opción.

select t.tipo,p.nombre, count(*) captura, rank() over (partition by t.tipo order by count(*) desc) ranking
# Vean aquí que tanto el tipo, nombre y el concepto de count(*) son inputs para la función de ventana
from captura c
join pokemon p on c.id = p.id
join pkmn_tipo pt on c.id = pt.id_pkmn
join tipo t on t.id_tipo = pt.id_tipo
group by t.tipo,p.nombre
# Noten que el group by actúa sobre tipo y nombre, pero en el ranking lo considera solamente por el order by
order by tipo, captura desc;

# Veamos los diferentes tipos de ranking

select t.tipo,p.nombre, count(*) captura,
       row_number() over (partition by t.tipo order by count(*) desc) rownum,
       rank() over (partition by t.tipo order by count(*) desc) ranking,
       dense_rank() over (partition by t.tipo order by count(*) desc) dense_ranking
# Vean aquí que tanto el tipo, nombre y el concepto de count(*) son inputs para la función de ventana
from captura c
join pokemon p on c.id = p.id
join pkmn_tipo pt on c.id = pt.id_pkmn
join tipo t on t.id_tipo = pt.id_tipo
group by t.tipo,p.nombre
# Noten que el group by actúa sobre tipo y nombre, pero en el ranking lo considera solamente por el order by
order by tipo, captura desc;

#TRATANDO DE EXTRAER UN TOP 5 (usaremos ROW_NUMBER)

# QUERY ERRONEA 1: usar el WHERE

select t.tipo,p.nombre, count(*) captura,
       row_number() over (partition by t.tipo order by count(*) desc) rownum,
       rank() over (partition by t.tipo order by count(*) desc) ranking,
       dense_rank() over (partition by t.tipo order by count(*) desc) dense_ranking
from captura c
join pokemon p on c.id = p.id
join pkmn_tipo pt on c.id = pt.id_pkmn
join tipo t on t.id_tipo = pt.id_tipo
where rownum <= 5 # No reconoce la columna, porque existe después del cálculo en la consulta
group by t.tipo,p.nombre
order by tipo, captura desc;

select t.tipo,p.nombre, count(*) captura,
       row_number() over (partition by t.tipo order by count(*) desc) rownum,
       rank() over (partition by t.tipo order by count(*) desc) ranking,
       dense_rank() over (partition by t.tipo order by count(*) desc) dense_ranking
from captura c
join pokemon p on c.id = p.id
join pkmn_tipo pt on c.id = pt.id_pkmn
join tipo t on t.id_tipo = pt.id_tipo
where row_number() over (partition by t.tipo order by count(*) desc) <= 5
# Tampoco reconoce la función como cálculo directo en el where
group by t.tipo,p.nombre
order by tipo, captura desc;

# QUERY ERRONEA 2: usar HAVING

select t.tipo,p.nombre, count(*) captura,
       row_number() over (partition by t.tipo order by count(*) desc) rownum,
       rank() over (partition by t.tipo order by count(*) desc) ranking,
       dense_rank() over (partition by t.tipo order by count(*) desc) dense_ranking
from captura c
join pokemon p on c.id = p.id
join pkmn_tipo pt on c.id = pt.id_pkmn
join tipo t on t.id_tipo = pt.id_tipo
group by t.tipo,p.nombre
HAVING row_number() over (partition by t.tipo order by count(*) desc) <= 5
# Si lo ejecutan les dirá que sólo se puede usar en SELECT u ORDER BY
order by tipo, captura desc;

# QUERY CORRECTA: función de ventana en sub consulta

Select *
from (select t.tipo,
             p.nombre,
             count(*)                                                       captura,
             row_number() over (partition by t.tipo order by count(*) desc) rownum,
             rank() over (partition by t.tipo order by count(*) desc)       ranking,
             dense_rank() over (partition by t.tipo order by count(*) desc) dense_ranking
      from captura c
               join pokemon p on c.id = p.id
               join pkmn_tipo pt on c.id = pt.id_pkmn
               join tipo t on t.id_tipo = pt.id_tipo
      group by t.tipo, p.nombre
         # Se debe adaptar, porque en la subconsulta no se permite order by, deberá quedar fuera
     ) A
where rownum <=5
order by tipo, rownum;

# Acá se usó el rownum, pero pueden usar lo que quieran.

# Version extendida (innecesaria pero funcional).

select  ranking,tipo, nombre, capturas
from
(select nombre, tipo, capturas,
       row_number() over (partition by tipo order by capturas desc) rownum
       ,rank() over (partition by tipo order by capturas desc) ranking
        ,dense_rank() over (partition by tipo order by capturas desc) denserank
from (select p.nombre, t.tipo, count(*) capturas from captura c
inner join pkmn_tipo pt on c.id = pt.id_pkmn
inner join tipo t on pt.id_tipo = t.id_tipo
inner join pokemon p on pt.id_pkmn = p.id
group by p.nombre, t.tipo
order by tipo, capturas desc) resumen_capturas) A
where ranking <= 5
order by tipo, ranking;
# En este caso se usó rank, por lo que en caso de empates, mostrará una ubicación menor a la 5

# La siguiente consulta realiza otros cálculos, jugando con las particiones.
# Traten de ver que representan. Hagan otras consultas para comparar y entender que está calculando

select tipo, count(*) from captura c inner join pokemon_tipo pt on c.id = pt.id group by  tipo;

select tipo, id, nombre,
       count(*) over (partition by tipo) cantidad_capturada, #Fijarse lo que está calculando según la partición
       count(*) over () total_capturado, # Revisar lo que está contando esta columnar
       round(100*(count(*) over (partition by tipo) / count(*) over () ),2) porcentaje #Revisen que representa este cálculo
       from
(select t.tipo, c.id, p.nombre
from tipo t
join pkmn_tipo pt on t.id_tipo = pt.id_tipo
join captura c on  c.id = pt.id_pkmn
    join pokemon p on c.id = p.id) A;

# Esta consulta no tiene sentido, pero les puede servir para ver que se pueden hacer operaciones entre las funciones
select tipo, nombre, special_attack,
       rank() over (partition by tipo order by special_attack desc),count(*) over (partition by tipo),
       rank() over (partition by tipo order by special_attack desc)/count(*) over (partition by tipo),  rank() over (partition by tipo order by attack desc) attack_ratio
       from pokemon_tipo
order by tipo, attack_ratio desc;