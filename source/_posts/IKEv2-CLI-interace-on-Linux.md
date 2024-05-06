title: IKEv2 CLI interace on Linux
author: aleks kylikov
date: 2024-05-06 22:07:42
tags:
---
The readme file for IKEv2 should be updated with the possibility to connect using CLI on a UBUNTU VPS. Here are the steps.

Step #1 Install Network manager and strongswan plugin

sudo apt update
sudo apt-get install network-manager network-manager-strongswan
Step #2 Edit the globally managed devices file and change unmanaged devices to none

nano /usr/lib/NetworkManager/conf.d/10-globally-managed-devices.conf 

Edit the file so it is like this

[keyfile]
unmanaged-devices=none

Step #3 Restart the network manager service

sudo systemctl restart NetworkManager

Step #4 Check if the devices are managed

nmcli d

Step #6 Import the .p12 certificate

openssl pkcs12 -in CERTNAMEHERE.p12 -cacerts -nokeys -out ca.cer
openssl pkcs12 -in CERTNAMEHERE.p12 -clcerts -nokeys -out client.cer
openssl pkcs12 -in CERTNAMEHERE.p12 -nocerts -nodes  -out client.key
rm CERTNAMEHERE.p12

sudo chown root:root ca.cer client.cer client.key
sudo chmod 600 ca.cer client.cer client.key
Step #7 Create a VPN connection in NetworkManager and enable it.

sudo nmcli c add type vpn ifname -- vpn-type strongswan connection.id VPN connection.autoconnect no vpn.data 'address = **YOURSERVERADDRESSHERE**, certificate = /root/ca.cer, encap = no, esp = aes128gcm16, ipcomp = no, method = key, proposal = yes, usercert = /root/client.cer, userkey = /root/client.key, virtual = yes'

nmcli c up 'Wired connection 1'
nmcli c up VPN
nmcli c