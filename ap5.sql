#use naruto;
-- P1
DELIMITER //

CREATE FUNCTION WordUpper2(input_text TEXT)
RETURNS TEXT
BEGIN
  DECLARE result_text TEXT;
  DECLARE current_word TEXT;
  DECLARE word_length INT;
  DECLARE i INT DEFAULT 1;

  SET result_text = '';

  WHILE i <= LENGTH(input_text) DO
    IF SUBSTRING(input_text, i, 1) = ' ' OR i = LENGTH(input_text) THEN
      IF i = LENGTH(input_text) THEN
        SET current_word = CONCAT(current_word, SUBSTRING(input_text, i, 1));
      END IF;

      SET word_length = LENGTH(current_word);

      IF word_length > 2 THEN
        SET result_text = CONCAT(result_text, UPPER(current_word));
      ELSE
        SET result_text = CONCAT(result_text, current_word);
      END IF;

      IF i < LENGTH(input_text) THEN
        SET result_text = CONCAT(result_text, ' ');
      END IF;

      SET current_word = '';
    ELSE
      SET current_word = CONCAT(current_word, SUBSTRING(input_text, i, 1));
    END IF;

    SET i = i + 1;
  END WHILE;

  RETURN result_text;
END //

DELIMITER ;

--

SELECT WordUpper2('hola el mundo'); -- Devolverá 'Hola el Mundo'


SUBSTRING('hola', 2, 1)


#-------------
DELIMITER //

CREATE FUNCTION FirstWordInitCap(input_text TEXT)
RETURNS TEXT
BEGIN
  DECLARE result_text TEXT;
  DECLARE first_word TEXT;

  SET result_text = input_text;
  SET first_word = SUBSTRING_INDEX(input_text, ' ', 1);

  IF LENGTH(first_word) > 2 THEN
    SET result_text = CONCAT(INITCAP(first_word), SUBSTRING(input_text, LENGTH(first_word) + 2));
  END IF;

  RETURN result_text;
END //

DELIMITER ;

SELECT FirstWordInitCap('hola el mundo'); -- Devolverá 'Hola el mundo'
#SELECT FirstWordInitCap('a aa aaa'); -- Devolverá 'a aa aaa' (sin cambios)
