if [ $# -lt 1 ]; then
   echo "Debe enviar el sistema operativo de parametro"
   exit 1
else
    if [$1 = debian]; then
        service network-manager stop
    else
        systemctl stop NetworkManager
    fi
    nohup hostapd configuracion.conf &
    gcc -o ejecutable proyecto.c
    ./ejecutable
fi    