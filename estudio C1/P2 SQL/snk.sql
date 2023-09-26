Create Database snk;
use snk;
CREATE TABLE `miembros` (
  `id_miembro` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` tinytext DEFAULT NULL,
  `apellidos` tinytext DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `rango` tinytext DEFAULT NULL,
  PRIMARY KEY (`id_miembro`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tipo_titan` (
  `id_tipo_titan` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` tinytext DEFAULT NULL,
  `altura_promedio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_titan`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `captura_titan` (
  `id_captura_titan` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_captura` datetime DEFAULT NULL,
  `id_miembro` int(11) DEFAULT NULL,
  `id_tipo_titan` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_captura_titan`),
  KEY `captura_titan_miembros_id_miembro_fk` (`id_miembro`),
  KEY `captura_titan_tipo_titan_id_tipo_titan_fk` (`id_tipo_titan`),
  CONSTRAINT `captura_titan_miembros_id_miembro_fk` FOREIGN KEY (`id_miembro`) REFERENCES `miembros` (`id_miembro`),
  CONSTRAINT `captura_titan_tipo_titan_id_tipo_titan_fk` FOREIGN KEY (`id_tipo_titan`) REFERENCES `tipo_titan` (`id_tipo_titan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tipo_accidente` (
  `id_tipo_accidente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo_accidente` tinytext DEFAULT NULL,
  `factor_mortalidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_tipo_accidente`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `registro_accidente` (
  `id_registro_accidente` int(11) NOT NULL AUTO_INCREMENT,
  `id_miembro` int(11) NOT NULL,
  `id_tipo_accidente` int(11) NOT NULL,
  `id_tipo_titan` int(11) NOT NULL,
  `fecha_accidente` datetime DEFAULT NULL,
  PRIMARY KEY (`id_registro_accidente`),
  KEY `registro_accidente_miembros_id_miembro_fk` (`id_miembro`),
  KEY `registro_accidente_tipo_accidente_id_tipo_accidente_fk` (`id_tipo_accidente`),
  KEY `registro_accidente_tipo_titan_id_tipo_titan_fk` (`id_tipo_titan`),
  CONSTRAINT `registro_accidente_miembros_id_miembro_fk` FOREIGN KEY (`id_miembro`) REFERENCES `miembros` (`id_miembro`),
  CONSTRAINT `registro_accidente_tipo_accidente_id_tipo_accidente_fk` FOREIGN KEY (`id_tipo_accidente`) REFERENCES `tipo_accidente` (`id_tipo_accidente`),
  CONSTRAINT `registro_accidente_tipo_titan_id_tipo_titan_fk` FOREIGN KEY (`id_tipo_titan`) REFERENCES `tipo_titan` (`id_tipo_titan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `miembros` (`nombres`, `apellidos`, `fecha_nacimiento`, `rango`) VALUES
('Eren', 'Jaeger', '1995-03-30', 'Cadet'),
('Mikasa', 'Ackerman', '1995-02-10', 'Cadet'),
('Armin', 'Arlert', '1995-08-12', 'Cadet'),
('Levi', 'Ackerman', '1980-12-25', 'Captain'),
('Erwin', 'Smith', '1980-08-05', 'Commander'),
('Hange', 'Zoe', '1982-06-01', 'Commander'),
('Sasha', 'Blouse', '1991-04-27', 'Cadet'),
('Jean', 'Kirschtein', '1993-09-02', 'Cadet'),
('Connie', 'Springer', '1992-07-03', 'Cadet'),
('Historia', 'Reiss', '1994-02-14', 'Cadet');

INSERT INTO `tipo_titan` (`nombre_tipo`, `altura_promedio`) VALUES
('Colosal', 60),
('Acorazado', 15),
('Bestia', 17),
('Cambiante', 15),
('Martillo de Guerra', 12),
('Titán Hembra', 14),
('Titán Mandíbula', 8),
('Titán Cuadrúpedo', 7),
('Titán de Ataque', 15),
('Titán Fundador', 20);

INSERT INTO `tipo_accidente` (`nombre_tipo_accidente`, `factor_mortalidad`) VALUES
('Ataque de Titan', 95),
('Caída desde gran altura', 80),
('Heridas en combate', 70),
('Ataque sorpresa', 85),
('Explosión', 90),
('Incendio', 75),
('Envenenamiento', 70),
('Derrumbe', 85),
('Electrocución', 80),
('Asfixia', 75);

INSERT INTO `captura_titan` (`fecha_captura`, `id_miembro`, `id_tipo_titan`) VALUES
('2023-08-15 14:30:00', 1, 1),
('2023-08-16 15:45:00', 2, 2),
('2023-08-17 10:20:00', 3, 3),
('2023-08-18 08:00:00', 4, 4),
('2023-08-19 11:10:00', 5, 1),
('2023-08-20 09:30:00', 6, 5),
('2023-08-21 14:15:00', 7, 6),
('2023-08-22 16:40:00', 8, 7),
('2023-08-23 12:25:00', 9, 8),
('2023-08-24 10:50:00', 10, 9);

INSERT INTO `registro_accidente` (`id_miembro`, `id_tipo_accidente`, `id_tipo_titan`, `fecha_accidente`) VALUES
(1, 1, 1, '2023-08-25 09:15:00'),
(2, 2, 2, '2023-08-26 16:30:00'),
(3, 3, 3, '2023-08-27 12:45:00'),
(4, 4, 4, '2023-08-28 14:20:00'),
(5, 1, 1, '2023-08-29 10:10:00'),
(6, 5, 5, '2023-08-30 11:45:00'),
(7, 6, 6, '2023-08-31 14:30:00'),
(8, 7, 7, '2023-09-01 15:20:00'),
(9, 8, 8, '2023-09-02 09:55:00'),
(10, 9, 9, '2023-09-03 10:40:00');
