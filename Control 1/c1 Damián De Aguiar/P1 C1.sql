create database torneo;
use torneo;

## Creamos las entidades
# Partimos por las prendas
CREATE TABLE `cabeza` (
    idCabeza INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    prendaCabeza varchar(50)
);
CREATE TABLE `torzo` (
    idTorzo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    prendaTorzo varchar(50)
);
CREATE TABLE `pierna` (
    idPierna INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    prendaPierna varchar(50)
);
CREATE TABLE `extra` (
    idExtra INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    prendaExtra varchar(50)
);

#Luego hacemos las vestimentas que se alimenta de las prendas
# No se consideran not null las prendas ya que puede no haber alguna
CREATE TABLE `vestimenta` (
    idVestimenta INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idCabeza int,
    idTorzo int,
    idPierna int,
    idExtra int,
    FOREIGN KEY ( idCabeza ) REFERENCES cabeza (idCabeza),
    FOREIGN KEY ( idTorzo ) REFERENCES torzo (idTorzo),
    FOREIGN KEY ( idPierna ) REFERENCES pierna (idPierna),
    FOREIGN KEY ( idExtra ) REFERENCES extra (idExtra)
);


#Ahora creamos los personajes que usan vestimentas
CREATE TABLE `personajes` (
    idPersonaje INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50),
    nacionalidad VARCHAR(50),
    estatura int,
    peso int,
    idVestimenta int,
    FOREIGN KEY ( idVestimenta ) REFERENCES vestimenta (idVestimenta)
);

#Ahora hacemos los jugadores que usan personajes
CREATE TABLE `jugadores` (
    idJugador INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idPersonaje INT,
    username VARCHAR(50),
    plataforma varchar(50),
    idioma varchar(50),
    zona varchar(50),
    puntos int,
    FOREIGN KEY ( idPersonaje ) REFERENCES personajes (idPersonaje)
);

#Se crea el escenario con variable booleana de si es espacio finito o no
CREATE TABLE `escenario` (
    idEscenario INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre varchar(50),
    descripcion varchar(50),
    espacio_finito bool #Un 1 indica que es espacio finito por lo que tiene muros.
);

# Se crea la tabla de las luchas
#No se añade restricción de que los personajes sean distintos ya que cada jugador puede usar al mismo personaje
# Se presupone que si un jugador gana un round, gana un punto. Así, sólo 1 puede llegar a los 3 puntos ya que cuando llega se acaba la pelea.
CREATE TABLE `luchas` (
    idLucha INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idJugadorA INT,
    idPersonajeA INT,
    puntosA INT,
    idJugadorB INT,
    idPersonajeB INT,
    puntosB INT,

    idEscenario INT,
    fecha datetime,

    FOREIGN KEY ( idEscenario ) REFERENCES escenario (idEscenario),
    FOREIGN KEY ( idJugadorA ) REFERENCES jugadores (idJugador),
    FOREIGN KEY ( idJugadorB ) REFERENCES jugadores (idJugador),
    FOREIGN KEY ( idPersonajeA ) REFERENCES personajes (idPersonaje),
    FOREIGN KEY ( idPersonajeB ) REFERENCES personajes (idPersonaje),
    CONSTRAINT Luchadores_VS CHECK (idJugadorA =! idJugadorB), #Que no puedan jugar contra si mismos
    CONSTRAINT Max_Puntos CHECK (puntosA <= 3 and puntosB <= 3),
    CONSTRAINT No_Ambos_Con_3_Puntos CHECK (puntosA + puntosB != 6) #Solo puede haber un ganador
);

#------------
# Parte 2
# Notemos que el id del ranking correponde a la posición en el ranking
CREATE TABLE ranking (
    idRanking INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idJugador INT,
    nombreJugador VARCHAR(50),
    puntos INT,
    FOREIGN KEY (idJugador) REFERENCES jugadores(idJugador)
);

INSERT INTO ranking (idJugador, nombreJugador, puntos)
SELECT j.idJugador, j.username, SUM(l.puntosA) AS total_puntos
FROM jugadores j
LEFT JOIN luchas l ON j.idJugador = l.idJugadorA
GROUP BY j.idJugador, j.username
UNION
SELECT j.idJugador, j.username, SUM(l.puntosB) AS total_puntos
FROM jugadores j
LEFT JOIN luchas l ON j.idJugador = l.idJugadorB
GROUP BY j.idJugador, j.username;

SELECT * FROM ranking
ORDER BY puntos DESC;

#Añadimos el ranking
ALTER TABLE ranking
ADD COLUMN posicionRanking INT;

UPDATE ranking AS r
JOIN (
    SELECT idRanking, ROW_NUMBER() OVER (ORDER BY puntos DESC) AS posicion
    FROM ranking
) AS temp
ON r.idRanking = temp.idRanking
SET r.posicionRanking = temp.posicion;


