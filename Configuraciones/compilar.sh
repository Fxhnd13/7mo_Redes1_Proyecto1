if [ $# -lt 1 ]; then
   echo "Debe enviar el sistema operativo de parametro"
   exit 1
else
    echo "---------------------------------------------------------------------------------------"
    echo "Iniciando access point"
    if [$1 = "debian"]; then
        service network-manager stop
    else
        systemctl stop NetworkManager
    fi
    nohup hostapd configuracion.conf &
    echo "---------------------------------------------------------------------------------------"
    echo "Iniciando auto-regulacion"
    echo "---------------------------------------------------------------------------------------"
    gcc -o ejecutable proyecto.c
    ./ejecutable
fi    