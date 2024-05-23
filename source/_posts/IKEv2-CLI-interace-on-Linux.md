title: IKEv2 Настройка из командной строки
author: aleks kylikov
tags:
  - ipsec
  - ikev2
categories:
  - ipsec
date: 2024-05-06 22:07:00
---
The readme file for IKEv2 should be updated with the possibility to connect using CLI on a UBUNTU VPS. Here are the steps.

###### Установите зависимости
Установите Network manager и strongswan plugin
~~~bash
sudo apt update
sudo apt-get install network-manager network-manager-strongswan
~~~
###### Перезапустите network manager service
~~~bash
sudo systemctl restart NetworkManager
~~~
###### Импортируйте сертификаты
~~~bash
openssl pkcs12 -in CERTNAMEHERE.p12 -cacerts -nokeys -out ca.cer
openssl pkcs12 -in CERTNAMEHERE.p12 -clcerts -nokeys -out client.cer
openssl pkcs12 -in CERTNAMEHERE.p12 -nocerts -nodes  -out client.key
rm CERTNAMEHERE.p12

sudo chown root:root ca.cer client.cer client.key
sudo chmod 600 ca.cer client.cer client.key
~~~
###### Создайте соединение
Создайтк VPN соединение в NetworkManager и активируйте.
~~~bash 
sudo nmcli c add type vpn ifname vpn-type strongswan connection.id VPN connection.autoconnect no vpn.data address = YOURSERVERADDRESSHERE, certificate = /root/ca.cer, encap = no, esp = aes128gcm16, ipcomp = no, method = key, proposal = yes, usercert = /root/client.cer, userkey = /root/client.key, virtual = yes
~~~

###### Запустите соединение
~~~bash
nmcli c up Wired connection 1
nmcli c up VPN
nmcli c
~~~