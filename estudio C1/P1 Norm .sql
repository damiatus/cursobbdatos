#P1

CREATE DATABASE batallas;
use batallas;

-- Creación de la tabla de luchadores
CREATE TABLE `luchadores` (
    idLuchador INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL

);

CREATE TABLE `pisos` (
    idPiso INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    piso INT,
    CONSTRAINT Piso_Rango CHECK (piso >= 0 AND piso <= 251 AND piso % 10 = 0)
);

CREATE TABLE `batallas` (
    idBatalla INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idLuchadorA INT,
    puntosA INT,
    idLuchadorB INT,
    puntosB INT,
    idpiso INT,
    fecha datetime,

    FOREIGN KEY ( idpiso ) REFERENCES pisos (idPiso),
    FOREIGN KEY ( idLuchadorA ) REFERENCES luchadores (idLuchador),
    FOREIGN KEY ( idLuchadorB ) REFERENCES luchadores (idLuchador),
    CONSTRAINT Luchadores_VS CHECK (idLuchadorA =! idLuchadorB),
    CONSTRAINT Max_Puntos CHECK (puntosA <= 10 and puntosB <=10)
);
#P2

#Se crea tabla auras
CREATE TABLE `auras` (
    idAura INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    aura VARCHAR(20)
);

#Se añaden valores a tabla auras
INSERT INTO `auras` (aura) VALUES
("Intensificación"),
("Transformación"),
("Materialización"),
("Emisión"),
("Manipulación"),
("Especialización");

#Se crea tabla intermedia
CREATE TABLE `luchadores_auras` (
    idLuchadorAura INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    idLuchador int,
    idAura int,
    FOREIGN KEY ( idLuchador ) REFERENCES luchadores (idLuchador),
    FOREIGN KEY ( idAura ) REFERENCES auras (idAura)
);


# P3
# Se modifica tabla pisos para añadir amo de piso correspondiente a llave foranea de idLuchador
# Se añade restricción de que solo puede haber 1 amo por piso

ALTER TABLE `pisos`
add COLUMN amo int unique,
ADD CONSTRAINT amo_piso
FOREIGN KEY (amo)
REFERENCES luchadores (idLuchador);


