##############################
#      INCONVENIENTES     #
##############################
#
# problemas con el usuario y contraseña de https://harbor.tallerdevops.com/   
# Usuario: estaygonzalez
# Contraseña: OBSestaygonzalez2022
#
# Para la solución de este problema se crean variables en este archo en la cual se pide reemplazar por lo menos:
# REGISTRY_USER --> Usuario con el que se inicia sesion
# REGISTRY_SERVER --> Registry endpoint. Ejemplo docker.io o https://harbor.tallerdevops.com/
#
#
# Dockerfile no utiliza ENTRYPOINT ya que por el tipo de lenguaje utilizado provoca una falla en la ejecucion del contenedor
# No se modifica el lenguaje, ya que, segun entendi se esperaba que la aplicacion utilizada anteriormente fuera la que se publicara. 
#
##############################
# INSTRUCCIONES DE ACTIVIDAD #
##############################
#
#
##############################
#      COMPILAR IMAGEN       #
##############################
#
# Nombre de la imagen
export IMAGE_NAME=my-app-master
#
# Version de la imagen
export IMAGE_VERSION=0.0.7
#
# Se establece el usuario del repositorio de imagenes habilitado
export REGISTRY_USER=cestay
#
# Se establece la url base del repositorio
export REGISTRY_SERVER=docker.io
#
# Inicio de sesion en el repositorio
docker login $REGISTRY_SERVER -u $REGISTRY_USER 
#
# Aplicacion quarkus requiere compilar para crear el .jar en local se requiere tener instalado Maven
mvn package -Dmaven.test.skip=true
#
# Construccion de la imagen uzando archivo Dockerfile
docker build -f src/main/docker/Dockerfile.jvm -t $REGISTRY_SERVER/$REGISTRY_USER/$IMAGE_NAME:$IMAGE_VERSION .
docker build -f src/main/docker/Dockerfile.jvm -t quarkus/my-app-master-jvm .
#
# Se comprueba que la imagen esta creada
docker image list
#
# Se publica imagen 
docker push $REGISTRY_SERVER/$REGISTRY_USER/$IMAGE_NAME:$IMAGE_VERSION
#
#
##############################
#    EJECUTAR APLICACION     #
##############################
#
#Crear red
docker network create --driver bridge --subnet=10.10.10.0/16 my-net-master
#
# Descargar imagen Postgres
docker pull postgres
#
# Ver imagen postgres descargada en local
docker image list
#
# Crear contenedor desde la imagen de postgres
# POSTGRES_USER nombre del usuario que se creara en la base de datos
# POSTGRES_PASSWORD contraseña que se utilizara para para conectarse a la BD
# POSTGRES_DB Nombre de la base de datos que se creara
#
# Base de datos sin exponer el puerto.
docker run --name my-postgres-master --network my-net-master -v my-postgres-master-volume:/database-data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgresdb --restart always -d postgres 
#
# PARA HACER PRUEBAS DE CONEXION A LA BD ES NECESARIO EXPONER LA BD Y DESDE UN CLIENTE COMO DBEAVER EJECUTAR LOS SCRIPT 01-create-table.sql y 02-insert.sql
docker run --name my-postgres-master --network my-net-master -p 5433:5432 -v my-postgres-master-volume:/database-data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=postgresdb --restart always -d postgres 
#
# Crear aplicacion java - tiene configurado por defecto el llamado a la base de datos.
docker run --name my-app-master --network my-net-master -p 8081:8080 -v my-app-master-volume:/data --restart always -d $REGISTRY_SERVER/$REGISTRY_USER/$IMAGE_NAME:$IMAGE_VERSION 