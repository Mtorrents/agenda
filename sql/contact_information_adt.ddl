
CREATE TABLE contact_information(
	person_id          integer NOT NULL PRIMARY KEY REFERENCES person(dni),
	mobile_phone       text    NOT NULL,
	phone              text    NOT NULL,
	email              text    NOT NULL,
	address            text    NOT NULL
);
