
use lego2;
#p1
SELECT COUNT(*) FROM sets;

#p2
SELECT year, COUNT(*) AS cantidad_de_sets
FROM sets
GROUP BY year
ORDER BY cantidad_de_sets DESC
LIMIT 1;

#p3 Usamos el color rojo

#primero queremos el id del color rojo
SELECT id
FROM colors
WHERE name = 'red';

#luego contamos en inventory_parts la cantidad que coincide con color_id=4
SELECT color_id, COUNT(*) AS cantidad_de_rojos
FROM inventory_parts
where color_id=4;

#p4
select sets.name, sets.set_num, sets.num_parts, sum(inventory_parts.quantity)
from sets
         left join inventories on sets.set_num = inventories.set_num
         left join inventory_parts on inventories.id = inventory_parts.inventory_id
group by sets.name, sets.set_num, sets.num_parts
order by sets.set_num;

#p5
#queremos obteer los valores de una columna que no se encuentran en otra
SELECT part_num as partes_faltantes
FROM inventory_parts
WHERE part_num NOT IN (SELECT part_num FROM parts);

#p6 eliminamos
DELETE FROM inventory_parts
WHERE part_num NOT IN (SELECT part_num FROM parts);

#p7
select s.name, s.set_num, s.num_parts, sum(ip.quantity)
from sets s
         left join inventories i on s.set_num = i.set_num
         left join inventory_parts ip on i.id = ip.inventory_id
group by s.name, s.set_num, s.num_parts
having s.num_parts <> IFNULL(sum(ip.quantity),0)
order by s.set_num;