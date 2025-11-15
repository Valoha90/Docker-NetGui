FROM ubuntu:24.04

#Habiita el frontend no interactivo(se pueden ejecutar los comando sin entrar en una terminal)
ENV DEBIAN_FRONTEND=noninteractive

# Habilita arquitectura i386
RUN dpkg --add-architecture i386

# Instala dependencias COMPLETAS para NetGUI y UML
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    vim \
    xterm \
    xwit \
    telnetd \
    wireshark \
    pv \
    libc6-i386 \
    xorg \
    libgtk-3-0 \
    default-jre \
    fonts-liberation \
    fonts-dejavu \
    lsof \
    procps \
    net-tools \
    iproute2 \
    iptables \
    uml-utilities \
    bridge-utils \
    # Dependencias adicionales para X11 y UML\
    xauth \
    dbus-x11 \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    e2fsprogs \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Copia el paquete .deb de NetGUI 0.4.10
COPY netgui_0.4.10-2~ubuntu2404_amd64.deb /tmp/netgui.deb

# Instala netgui desde el .deb
RUN apt-get update && \
    apt-get install -y /tmp/netgui.deb && \
    rm /tmp/netgui.deb && \
    apt-get clean

# Configura environment variables
ENV NETKIT_HOME=/usr/local/netkit
ENV PATH=/usr/local/netkit/bin:$PATH
ENV MANPATH=:/usr/local/netkit/man

# Verifica instalación de Netkit
RUN cd /usr/local/netkit && \
    ./check_configuration.sh

# Configurar permisos para UML
RUN echo "netgui-user ALL=(ALL) NOPASSWD: /usr/local/netkit/bin/*" >> /etc/sudoers && \
    echo "netgui-user ALL=(ALL) NOPASSWD: /bin/mount" >> /etc/sudoers && \
    echo "netgui-user ALL=(ALL) NOPASSWD: /bin/umount" >> /etc/sudoers

# Configura tunctl para usuario normal
RUN chmod u+s /usr/bin/tunctl

# Configura herramientas UML
RUN chmod u+s /usr/local/netkit/bin/uml_mkcow && \
    chmod u+s /usr/local/netkit/bin/uml_switch && \
    chmod u+s /usr/local/netkit/bin/uml_net

# Crea los directorios necesarios
RUN mkdir -p /var/lib/netkit && \
    chmod 777 /var/lib/netkit

# Configura xterm para copiar/pegar con Ctrl+Shift
RUN mkdir -p /root/.config/xterm
COPY xterm-config /root/.config/xterm/

# Configura DBUS para X11(interfaz grafica)
RUN mkdir -p /var/run/dbus && \
    chmod 755 /var/run/dbus

# Crea usuario netgui-user
RUN useradd -m -s /bin/bash netgui-user && \
    usermod -a -G sudo netgui-user

# Copia el archivo de configuracion de netkit
COPY netkit.conf /usr/local/netkit/netkit.conf

# Elije el directorio donde trabajara el docker
WORKDIR /root

# Ejecuta netgui
CMD ["/usr/local/bin/netgui.sh"]
