
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
