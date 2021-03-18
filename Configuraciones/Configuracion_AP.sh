#$1 es la conexion ethernet existente
#$2 es nuestra tarjeta de red ethernet
#$3 es nuestra tarejta de red inalambrica
#$4 es nuestro sistema operativo
if [ $# -lt 3 ]; then
   echo "(Nombre_de_la_conexion,Tarjeta_ethernet,Tarjeta_inalambrica,Sistema operativo)"
   exit 1
else
    if [$4 = "debian"]; then
        service network-manager start
    else
        systemctl start NetworkManager
    fi
    nmcli conn add type bridge con-name br0 ifname br0
    nmcli conn add type ethernet slave-type bridge con-name bridge-br0 ifname $1 master br0
    nmcli conn up br0
    ifconfig br0 down
    brctl delbr br0
    ip addr flush dev $1
    iw dev $2 set 4addr on
    brctl addbr br0
    brctl addif br0 $1
    brctl addif br0 $2
    ip link set dev br0 up
    dhclient br0
fi