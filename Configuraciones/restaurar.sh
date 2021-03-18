systemctl start NetworkManager
nmcli conn down br0
nmcli conn down bridge-br0
nmcli conn del br0
nmcli conn del bridge-br0