##############################
#      INCONVENIENTES     #
##############################
#
# problemas con el usuario y contraseña de https://harbor.tallerdevops.com/   
# Usuario: estaygonzalez
# Contraseña: OBSestaygonzalez2022
#
# Para la solución de este problema se crean variables en este archivo en la cual se pide reemplazar por lo menos:
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
# Ejecutar el siguiente comando para ejecutar la actividad
docker-compose up