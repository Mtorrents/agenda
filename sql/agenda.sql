
CREATE TABLE person(
	dni         integer    PRIMARY KEY,
	name        text    NOT NULL,
	surname     text    NOT NULL,
	nationality text    NOT NULL,
	birthday    date    NOT NULL,
	gender      text    NOT NULL CHECK(gender='Masculino' OR gender='Femenino')
);

CREATE TABLE contact_information(
	person_id          integer NOT NULL PRIMARY KEY REFERENCES person(dni),
	mobile_phone       text    NOT NULL,
	phone              text    NOT NULL,
	email              text    NOT NULL,
	address            text    NOT NULL
);

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

------------------------------
-- CLASE: contact_information
------------------------------

------------------------------
-- CONSTRUCTORES
------------------------------
CREATE OR REPLACE FUNCTION contact_information(
	IN p_person_id            integer,
	IN p_mobile_phone         text,
	IN p_phone                text,
	IN p_email                text,
	IN p_address              text
) RETURNS contact_information AS
$$
	INSERT INTO contact_information(person_id, mobile_phone, phone, email, address)
		VALUES(p_person_id, p_mobile_phone, p_phone, p_email, p_address)
	RETURNING *;
$$LANGUAGE sql VOLATILE STRICT;
SET search_path FROM CURRENT;

CREATE OR REPLACE FUNCTION webapi_person_create(
	IN p_person        jsonb
) RETURNS void AS $$
BEGIN
	IF NOT p_person ? 'dni'
		OR NOT p_person ? 'name'
		OR NOT p_person ? 'surname'
		OR NOT p_person ? 'nationality'
		OR NOT p_person ? 'birthday'
		OR NOT p_person ? 'gender'
	THEN
		RAISE EXCEPTION 'webapi_person_create EXCEPTION: malformed JSON object';
	END IF;
	PERFORM person((p_person ->> 'dni')::integer, p_person ->> 'name', p_person ->> 'surname', p_person ->> 'nationality', (p_person ->> 'birthday')::date, p_person ->> 'gender');
END;
$$LANGUAGE plpgsql VOLATILE STRICT;

CREATE OR REPLACE FUNCTION webapi_contact_information_create(
    IN p_contact_information                 jsonb
) RETURNS void AS $$
BEGIN
	IF NOT p_contact_information ? 'person_id'
		OR NOT p_contact_information ? 'mobile_phone'
		OR NOT p_contact_information ? 'phone'
		OR NOT p_contact_information ? 'email'
		OR NOT p_contact_information ? 'address'
	THEN
		RAISE EXCEPTION 'webapi_contact_information_create EXCEPTION: malformed JSON object';
	END IF;
	PERFORM contact_information((p_contact_information ->> 'person_id')::integer, p_contact_information ->> 'mobile_phone', p_contact_information ->> 'phone', p_contact_information ->> 'email', p_contact_information ->> 'address');
END;
$$LANGUAGE plpgsql VOLATILE STRICT;

SELECT webapi_person_create (
 '{
    "dni":39642511,
    "name":"Martin",
    "surname":"Torrents",
    "nationality":"Argentino",
    "birthday":"26/04/1996",
    "gender":"Masculino"
  }'
);

SELECT webapi_contact_information_create (
 '{
    "person_id":39642511,
    "mobile_phone":"11-5988-0377",
    "phone":"11-3980-1282",
    "email":"martin.torrents35@gmail.com",
    "address":"vidal 3424"
  }'
);
