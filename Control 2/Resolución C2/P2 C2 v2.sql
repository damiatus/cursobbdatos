#Damián De Aguiar

use naruto3;

# p2.1 Si tenemos 2 personajes con mismo ranking mostramos ammbos perosnajes en ese ranking
SELECT personaje_recibe, total_likes, ranking
FROM (
    SELECT
        personaje_recibe,
        SUM(CASE WHEN tipo_interaccion IN ('like', 'superlike') THEN 1 ELSE 0 END) AS total_likes, #sumamos 1 tanto para caso like y superlike
        DENSE_RANK() OVER (ORDER BY SUM(CASE WHEN tipo_interaccion IN ('like', 'superlike') THEN 1 ELSE 0 END) DESC) AS ranking
    FROM
        interaccion
    GROUP BY
        personaje_recibe
) AS ranked_data
WHERE ranking BETWEEN 1 AND 3 #Notamos que para el caso específico tenemos los 4 personajes de la bb de datos con rankings entre 1 y 3 así que se muestran todos ya que empatan en likes
ORDER BY ranking;

#P2.2
SELECT
    *,
    DENSE_RANK() OVER (ORDER BY total_likes DESC) AS ranking_likes
FROM (
    SELECT
        t.*,
        DENSE_RANK() OVER (ORDER BY total_likes DESC) AS ranking_likes
    FROM (
        SELECT
            personaje_recibe,
            SUM(CASE
                WHEN tipo_interaccion = 'superlike' AND personaje_recibe NOT IN (
                    SELECT personaje_recibe FROM interaccion WHERE tipo_interaccion = 'dislike'
                ) THEN 10
                ELSE 0
            END) AS puntaje,
            SUM(CASE WHEN tipo_interaccion IN ('like', 'superlike') THEN 1 ELSE 0 END) AS total_likes
        FROM interaccion
        GROUP BY personaje_recibe
        HAVING puntaje >= 0
    ) AS t
) AS ranked_data
WHERE ranking_likes BETWEEN 1 AND 3 #Notamos que para el caso específico tenemos los 4 personajes de la bb de datos con rankings entre 1 y 3 así que se muestran todos ya que empatan en likes
ORDER BY ranking_likes;








#p2.3
WITH LikesSuperlikesRanked AS (
    SELECT
        p.id_aldea_residencia,
        i.personaje_recibe,
        i.tipo_interaccion,
        ROW_NUMBER() OVER (PARTITION BY p.id_aldea_residencia ORDER BY
        SUM(CASE WHEN i.tipo_interaccion IN ('like', 'superlike') THEN 1 ELSE 0 END) DESC) AS ranking
    FROM
        personaje p
    INNER JOIN
        interaccion i ON p.id_personaje = i.personaje_recibe
    GROUP BY
        p.id_aldea_residencia, i.personaje_recibe, i.tipo_interaccion
)
SELECT
    lsr.id_aldea_residencia,
    p.nombre_personaje,
    lsr.tipo_interaccion,
    lsr.ranking
FROM
    LikesSuperlikesRanked lsr
INNER JOIN
    personaje p ON lsr.personaje_recibe = p.id_personaje
WHERE
    lsr.ranking <= 5;
;
