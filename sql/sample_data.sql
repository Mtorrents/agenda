
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
