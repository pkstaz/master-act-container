#ARCHIVO PARA ELIMINAR LOS COMPONENTES CREADOS CON EL ARCHIVO 01-deploy.sh

docker container stop my-postgres-master && docker container rm my-postgres-master
docker container stop my-app-master && docker container rm my-app-master
docker network rm my-net-master