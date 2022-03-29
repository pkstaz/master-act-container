#!/bin/bash

#Crear app quarkus nativa - START
quarkus create app com.cestay:my-app-master:1.0.0 
quarkus ext add quarkus-jdbc-postgresql
quarkus ext add quarkus-resteasy
quarkus ext add quarkus-resteasy-jackson
quarkus ext add container-image-docker
#Crear app quarkus nativa - END

#Compilar & Publicar Imagen - START
mvn clean package -Dquarkus.container-image.build=true -Dmaven.test.skip=true
mvn clean package -Dquarkus.container-image.push=true
#Compilar & Publicar Imagen - END


docker container inspect my-postgres-master

# Actividad semana 2

#Crear red
docker network create --driver bridge --subnet=10.10.10.0/16 my-net-master

# Descargar imagen Postgres
docker pull postgres

# Ver imagen postgres descargada en local
docker image list

# Crear contenedor desde la imagen de postgres
# POSTGRES_USER nombre del usuario que se creara en la base de datos
# POSTGRES_PASSWORD contraseña que se utilizara para para conectarse a la BD
# POSTGRES_DB Nombre de la base de datos que se creara

# Base de datos sin exponer el puerto, omitir esta linea para poder hacer pruebas de conexion a la BD
docker run --name my-postgres-master --network my-net-master -v my-postgres-master-volume:/database-data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgresdb --restart always -d postgres 

# PARA HACER PRUEBAS DE CONEXION A LA BD ES NECESARIO EXPONER LA BD Y DESDE UN CLIENTE COMO DBEAVER EJECUTAR LOS SCRIPT 01-create-table.sql y 02-insert.sql
docker run --name my-postgres-master --network my-net-master -p 5433:5432 -v my-postgres-master-volume:/database-data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgresdb --restart always -d postgres 

# Crear aplicacion java - tiene configurado por defecto el llamado a la base de datos.
docker run --name my-app-master --network my-net-master -p 8081:8080 -v my-app-master-volume:/data --restart always -d docker.io/cestay/my-app-master:1.0.0





# Limpiar
docker container stop my-postgres-master && docker container rm my-postgres-master
docker container stop my-app-master && docker container rm my-app-master
docker network rm my-net-master



# Check Actividad
docker ps && docker network list && docker volume ls

