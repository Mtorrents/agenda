
----------------------------
-- CLASE: person -> METODOS
----------------------------

---------------------------
-- CONSTRUCTORES
---------------------------
CREATE OR REPLACE FUNCTION person(
	IN p_dni         integer,
	IN p_name        text,
	IN p_surname     text,
	IN p_nationality text,
	IN p_birthday    date,
	IN p_gender      text
) RETURNS person AS
$$
	INSERT INTO person(dni ,name ,surname, nationality, birthday, gender)
		VALUES(p_dni, p_name, p_surname, p_nationality, p_birthday, p_gender)
	RETURNING *;
$$LANGUAGE sql VOLATILE STRICT;
SET search_path FROM CURRENT;
