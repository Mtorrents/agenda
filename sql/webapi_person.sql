
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
