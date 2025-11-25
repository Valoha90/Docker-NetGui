#####################################################################################################
################################# GUIA DE INSTALACION ###############################################
# Primero instalar docker.
apt install docker #o cualquier otra variable de apt para mas info https://docs.docker.com/engine/install/
# Segundo hacer un pull a la imagen
docker pull valoha90/netgui:0.4.10.3
# Tercero una vez descargada la imagen podes verificar con (docker images) Descargar el script netgui_in_docker.sh y modificar los permisos
chmod 744 netgui_in_docker.sh
# Cuarto ejecutar el script y verificar si la variable de $IdDocker es la misma que el tag(nombre) de la imagen con (docker images) IMPORTANTE!!! SOLO EN EL CASO DE QUE EL SCRIPT NO FUNCIONE
./netgui_in_docker.sh
#####################################################################################################
#####################################################################################################
#Solo es un docker para no andar webeando con las dependencias de netgui que son librerias de 32bits;
#El paquete esta sacado de un repo en una pagiina de una universidad de españa pero no encuentro la pagina.
#El paquete original fue creado por GSyC/MobiQuo group su pagina https://mobiquo.gsyc.urjc.es/netlab.html.
#Y aca toy Joaquin Valentin Rodriguez Flores haciendo un docker para que los nuevos admin no instalen librerias de 32 bits; pdta este docker usa ubuntu de base para mayo compatibilidad (no recomendable para S.O. principal)
#https://ubuntu.com/containers.
#En sintesis esto esta pa usarse.
#EL docker se debe ejecutal de la siguiente manera si no no funciona.

docker run -it --rm --network host --tmpfs /dev/shm:rw,nosuid,nodev,exec,mode=0777 --ipc=host -e DISPLAY=$DISPLAY netgui-original:0.4.9 bash

#Recomendacion ejecutar el script netgui_in_docker.sh (se detalla cada opcion necesaria en profundidad)para abrirlo y este script crea una carpeta en el home (NetguiLabs) en el cual podes cargar los laboratorios para abrirlos dentro de netgui y biseversa.

#Tambien esto fue echo con la ayuda de Manuel Gomes Dasilva y Fransisco Nahuel Lista.

#El docker se encuentra https://hub.docker.com/r/valoha90/netgui.

#Y el paquete .deb en https://drive.google.com/file/d/1XddgQs-Lk_OorkAJNKKRQ81CgvQ-kseS/view?usp=drive_link.

#los archivos de configuracion xterm y netkit (por default viene gnome) son necesarios para que la imagen se puedea hacer; con x-term se puede copiar y pegar con ctrl+shift+(C/V).
#La ventaja de este netgui sobre el paquete es que esta configurado con atajos y bonito para xterm
#La desbentaja es que una vez que cierres netgui no va a salir del contenedor hasta que escribas "exit"
