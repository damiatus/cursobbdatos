-- Crear las tablas

USE metro_cdmx;

CREATE TABLE `lines`
(
    
    `id` BIGINT
(20) UNSIGNED NOT NULL AUTO_INCREMENT,

    `name` VARCHAR
(10) NOT NULL,
    `color` VARCHAR
(15) NOT NULL,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY
(`id`)

)
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


CREATE TABLE 'trains'
(
    
    'line_id' BIGINT
(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    'type' TINYINT
(4) NOT NULL,
    'year' INT
(4) NOT NULL,
    'created_at' TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    'updated_at' TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY 'serial_number' VARCHAR
(10) NOT NULL

)
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE 'stations'
(
    
    'station_id' BIGINT
(20) UNSIGNED NOT NULL AUTO_INCREMENT,
    'line' BIGINT
(20) UNSIGNED NOT NULL,
    'name' VARCHAR
(10) NOT NULL,
    'created_at' TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    'updated_at' TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY 'serial_number' VARCHAR
(10) NOT NULL

)
DEFAULT CHARSET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


