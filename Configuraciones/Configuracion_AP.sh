#$1 es la conexion ethernet existente
#$2 es nuestra tarjeta de red ethernet
#$3 es nuestra tarejta de red inalambrica
#$4 es nuestro sistema operativo
if [ $# -lt 4 ]; then
   echo "(Nombre_de_la_conexion,Tarjeta_ethernet,Tarjeta_inalambrica,Sistema operativo)"
   exit 1
else
    nmcli conn add type bridge con-name br0 ifname br0;
    nmcli conn add type ethernet slave-type bridge con-name bridge-br0 ifname $2 master br0;
    nmcli conn up br0;
    nmcli conn down $1;
    ifconfig br0 down;
    brctl delbr br0;
    ip addr flush dev $2;
    iw dev $3 set 4addr on;
    brctl addbr br0;
    brctl addif br0 $2;
    brctl addif br0 $3;
    ip link set dev br0 up;
    dhclient br0;
    if [$4 == "debian"] then
        service NetworkManager stop
    else
        systemctl stop NetworkManager
    fi
fi