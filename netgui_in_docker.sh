#/bin/bash
#Este es un script para inicio rapido ya que las opciones de docker son laaaargas
#Crea un directorio donde podran poner los laboratios y cargarlos al docker al igual que podran editarlos
DirNetguiLabs=$HOME/NetguiLabs
mkdir $DirNetguiLabs 2> /dev/null
#es una variable que guarda la id del docker
IdDocker=valoha90/netgui:0.4.10.3
#configura x11 para el apartado grafico 
xhost +local:docker > /dev/null 2>&1
#Esta linea de comando es necesaria para ejecutar el docker de netgui y que funcione todo es vital se muestra una terminal y para ejecuar netgui es ngxterm.sh
docker run -it --rm --network host --tmpfs /dev/shm:rw,nosuid,nodev,exec,mode=0777 --ipc=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:rw  -v $DirNetguiLabs:/root/LabsNetgui  $IdDocker
#-it   -i: Modo interactivo (mantiene STDIN abierto)   -t: Asigna una pseudo-terminal (TTY)
#--network host Usa la stack de red del host directamente (sin aislamiento de red) el contenedor comparte la interfaz de red con el host pq netgui lo necesita(sin esto no ejecuta o puede que tenga limitaciones si lo restringes).
#Combinados permiten la interacción con el contenedor como si fuera una terminal normal
#( --rm ) Elimina automáticamente el contenedor cuando se detiene
#( --network host )Usa la stack de red del host directamente (sin aislamiento de red) el contenedor comparte la interfaz de red con el host
#( --tmpfs /dev/shm:rw,nosuid,nodev,exec,mode=0777 ) Monta un sistema de archivos temporal en /dev/shm
#Opciones:
#rw: Lectura/escritura
#nosuid: No permite suid bits
#nodev: No interpreta dispositivos especiales
#exec: Permite ejecutar binarios
#mode=0777: Permisos completos para todos los usuarios
#--ipc=host
#Comparte el espacio de nombres IPC (Inter-Process Communication) con el host
#-e DISPLAY=$DISPLAY
#Configura la variable de entorno DISPLAY para aplicaciones gráficas com tambien permite mostrar ventanas en el host
#-v /tmp/.X11-unix:/tmp/.X11-unix:rw
#hace factible la copia y pega de comandos etc
#-v $DirNetguiLabs:/root
#Monta el directorio local $DirNetguiLabs en /root del contenedor
#$DirNetguiLabs es una variable de entorno

#netgui-final:0.4.10
#Es la imagen y versión que se ejecutará

