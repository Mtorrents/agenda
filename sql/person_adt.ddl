
CREATE TABLE person(
	dni         integer    PRIMARY KEY,
	name        text    NOT NULL,
	surname     text    NOT NULL,
	nationality text    NOT NULL,
	birthday    date    NOT NULL,
	gender      text    NOT NULL CHECK(gender='Masculino' OR gender='Femenino')
);
