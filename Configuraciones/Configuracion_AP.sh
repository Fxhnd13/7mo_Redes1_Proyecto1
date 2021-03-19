#$1 es la conexion ethernet existente
#$2 es nuestra tarjeta de red ethernet
#$3 es nuestra tarejta de red inalambrica
#$4 es nuestro sistema operativo
if [ $# -lt 3 ]; then
   echo "Enviar de parametros Tarjeta_ethernet Tarjeta_inalambrica Sistema operativo"
   exit 1
else
    echo "---------------------------------------------------------------------------------------"
    echo "Iniciando servicio network-manager (si está desactivado)."
    if [$4 = "debian"]; then
        service network-manager start
    else
        systemctl start NetworkManager
    fi
    echo "---------------------------------------------------------------------------------------"
    echo "Removiendo la dirección IP adherida a nuestra tarjeta ethernet"
    ip addr flush dev $1
    echo "---------------------------------------------------------------------------------------"
    echo "Encendiendo conexión IPv4 para nuestra conexión inalámbrica"
    iw dev $2 set 4addr on
    echo "---------------------------------------------------------------------------------------"
    echo "Creando puente br0"
    brctl addbr br0
    echo "---------------------------------------------------------------------------------------"
    echo "Agregando las interfaces a puentear"
    brctl addif br0 $1
    brctl addif br0 $2
    echo "---------------------------------------------------------------------------------------"
    echo "Levantando el nuevo puente creado como un dispositivo virtual"
    ip link set dev br0 up
    echo "---------------------------------------------------------------------------------------"
    echo "Realizando configuracion de IP,mascara de subred, router, etc"
    echo "---------------------------------------------------------------------------------------"
    dhclient br0
fi