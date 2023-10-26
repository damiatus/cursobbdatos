# Ángelo León y Damián De Aguiar

use ap4;
alter view descripcion_relacion as
select personaje.nombre_personaje, r.descripcion_relacion, (select nombre_personaje
    from personaje
        where id_personaje = id_personaje_b) as nombre_personaje_2
from personaje
join naruto.relacion r on personaje.id_personaje = r.id_personaje_a
where descripcion_relacion = 'Rivales';



#P2


DELIMITER $$

DROP FUNCTION IF EXISTS `test`.`initcap`$$

CREATE FUNCTION `initcap`(x char(30)) RETURNS char(30) CHARSET utf8
READS SQL DATA
DETERMINISTIC
BEGIN
SET @str='';
SET @l_str='';
WHILE x REGEXP ' ' DO
SELECT SUBSTRING_INDEX(x, ' ', 1) INTO @l_str;
SELECT SUBSTRING(x, LOCATE(' ', x)+1) INTO x;
SELECT CONCAT(@str, ' ', CONCAT(UPPER(SUBSTRING(@l_str,1,1)),LOWER(SUBSTRING(@l_str,2)))) INTO @str;
END WHILE;
RETURN LTRIM(CONCAT(@str, ' ', CONCAT(UPPER(SUBSTRING(x,1,1)),LOWER(SUBSTRING(x,2)))));
END$$

DELIMITER ;


Usage:

#select initcap('This is test string');


DELIMITER //

CREATE FUNCTION UpperIfLongerThanTwo(input_string TEXT)
RETURNS TEXT
BEGIN
    DECLARE result TEXT;
    DECLARE temp_string TEXT;
    DECLARE word TEXT;
    DECLARE i INT;

    SET result = '';
    SET temp_string = input_string;

    -- Split the input_string into words
    WHILE LENGTH(temp_string) > 0 DO
        SET i = LOCATE(' ', temp_string);
        IF i = 0 THEN
            SET word = temp_string;
            SET temp_string = '';
        ELSE
            SET word = SUBSTRING(temp_string, 1, i - 1);
            SET temp_string = SUBSTRING(temp_string, i + 1);
        END IF;

        -- Check if the word has more than two letters
        IF LENGTH(word) > 2 THEN
            SET result = CONCAT(result, ' ', CONCAT(UPPER(LEFT(word, 1)), SUBSTRING(word, 2)));
        ELSE
            SET result = CONCAT(result, ' ', word);
        END IF;
    END WHILE;

    -- Remove leading space
    IF LENGTH(result) > 0 AND LEFT(result, 1) = ' ' THEN
        SET result = SUBSTRING(result, 2);
    END IF;

    RETURN result;
END;
//

DELIMITER ;


SELECT UpperIfLongerThanTwo('este es un ejemplo de string en sql');
