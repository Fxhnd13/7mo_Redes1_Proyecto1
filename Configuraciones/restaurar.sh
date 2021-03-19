echo "---------------------------------------------------------------------------------------"
echo "Activando el servicio network-manager"
systemctl start NetworkManager
echo "---------------------------------------------------------------------------------------"
echo "Eliminando conexiones"
nmcli conn down br0
nmcli conn del br0