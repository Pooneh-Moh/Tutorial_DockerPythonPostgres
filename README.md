# Tutorial_DockerPythonPostgres
The docker is forfed from the git repo indicated here. I added the parts related to the question. This way the whole process will be faster. 

Here is available the code of the Medium tutorial here: [link](https://stefanopassador.medium.com/docker-compose-with-python-and-posgresql-45c4c5174299)

## Create db table

Commands to create the db table:

> docker ps 

Used to identify the CONTAINER ID of postgres

> docker exec -it <CONTAINER_ID> bash

> psql postgres://username:secret@localhost:5432/database
