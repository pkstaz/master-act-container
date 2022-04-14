#ARCHIVO PARA ELIMINAR LOS COMPONENTES CREADOS CON EL ARCHIVO 01-deploy.sh

docker container stop my-postgres-master && docker container rm my-postgres-master
docker container stop my-app-master && docker container rm my-app-master
# docker network rm my-net-master 
# docker network rm my-app-master_default
docker network rm my-app-master_my-net-master
docker volume rm my-app-master_my-app-master-volume
docker volume rm my-app-master_my-postgres-master-volume
docker image rm my-app-master_quarkus
docker image rm postgres