# Usamos imagen de ubuntu
FROM ubuntu

# Actualizar repositorios
RUN apt update && apt full-upgrade -y && apt autoremove && apt clean

# Instalar servicio DHCP
RUN apt install isc-dhcp-server -y

# Definicion de volumen
VOLUME ["/etc/dhcp/"]

# Copiar configuracion por defecto del host al container
COPY ./conf/dhcpd.conf /etc/dhcp/dhcpd.conf
RUN touch /var/lib/dhcp/dhcpd.leases

# Añadimos el script al contenedor y lo hacemos ejecutable
COPY ./startUP.sh ./startUP.sh
RUN chmod +x ./startUP.sh

# Definicion entrypoint 
ENTRYPOINT ["./startUP.sh"]
CMD ["dhcpd"]
