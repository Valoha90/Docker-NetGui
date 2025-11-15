
#Solo es un docker para no andar webeando con las dependencias de netgui que son librerias de 32bits;
#El paquete esta sacado de un repo en una pagiina de una universidad de españa pero no encuentro la pagina.
#El paquete original fue creado por GSyC/MobiQuo group su pagina https://mobiquo.gsyc.urjc.es/netlab.html.
#Y aca toy Joaquin Valentin Rodriguez Flores haciendo un docker para que los nuevos admin no instalen librerias de 32 bits; pdta este docker usa ubuntu de base para mayo compatibilidad (no recomendable para S.O. principal)
#https://ubuntu.com/containers.
#En sintesis esto esta pa usarse.
#EL docker se debe ejecutal de la siguiente manera si no no funciona.

docker run -it --rm --network host --tmpfs /dev/shm:rw,nosuid,nodev,exec,mode=0777 --ipc=host -e DISPLAY=$DISPLAY netgui-original:0.4.9 bash

#Recomendacion ejecutar el script netgui_in_docker.sh para abrirlo y este script crea una carpeta en el home (NetguiLabs) en el cual podes cargar los laboratorios para abrirlos dentro de netgui y biseversa.

#Tambien esto fue echo con la ayuda de Manuel Gomes Dasilva y Fransisco Nahuel Lista.

#El docker se encuentra https://hub.docker.com/r/valoha90/netgui.
