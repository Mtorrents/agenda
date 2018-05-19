.PHONY: clean

all: agenda.sql

agenda.sql:               \
	person_adt.ddl     \
	contact_information_adt.ddl    
	
	psql -c "create database mtorrentz" postgres
	
	touch agenda.sql
	cat person_adt.ddl >> agenda.sql
	cat contact_information_adt.ddl >> agenda.sql
	cat person_mtd.sql >> agenda.sql
	cat contact_information_mtd.sql >> agenda.sql
	
	cat webapi_person.sql >> agenda.sql
	cat webapi_contact_information.sql >> agenda.sql
	
	cat sample_data.sql >> agenda.sql
	
	psql  <  agenda.sql
clean:
	$(RM) agenda.sql
	psql -c "drop database if exists mtorrentz" postgres
