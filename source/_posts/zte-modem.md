---
title: zte modem
date: 2020-08-13 23:59:13
tags:
---

Сначала зачем-то тыкнул эту команду (переводим модем в режим с COM портами и ADB интерфейсом):

<http://192.168.8.1/goform/goform_set_cmd_process?goformId=USB_MODE_SWITCH&usb_mode=6>
После ввода вот этой команды потерял связь с модемом по CGI:

<http://192.168.8.1/goform/goform_process?goformId=MODE_SWITCH&switchCmd=FACTORY>

# dmesg

[    5.663021] usb 1-1.4: new high-speed USB device number 4 using ehci-pci
[    5.797594] usb 1-1.4: New USB device found, idVendor=19d2, idProduct=0016
[    5.797597] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    5.797598] usb 1-1.4: Product: ZTE Wireless Ethernet Adapter
[    5.797599] usb 1-1.4: Manufacturer: ZTE,Incorporated
[    5.817413] usbcore: registered new interface driver usbserial
[    5.817421] usbcore: registered new interface driver usbserial_generic
[    5.817426] usbserial: USB Serial support registered for generic
[    5.822291] usbcore: registered new interface driver option
[    5.822300] usbserial: USB Serial support registered for GSM modem (1-port)
[    5.822373] option 1-1.4:1.0: GSM modem (1-port) converter detected
[    5.823265] usb 1-1.4: GSM modem (1-port) converter now attached to ttyUSB0

От этих вариантов нет эффекта:

# echo "AT+ZCDRUN=E" > /dev/ttyUSB0

# echo "AT+ZCDRUN=8" > /dev/ttyUSB0

# echo "AT+ZCDRUN=F" > /dev/ttyUSB0

Еще в окошке «Cетевые соединения» удалил соединение по Ethernet, оно же вроде само восстановится?

UPD В соседнем окошке терминала нет ответа:

sudo cat /dev/ttyUSB0

sudo rm /dev/ttyUSB*
sudo modprobe -fr option
sudo modprobe -fr usbserial
sudo modprobe usbserial vendor=0x19d2 product=0x0016
ls /dev/ttyUSB*
Теперь их три штуки:

/dev/ttyUSB0  /dev/ttyUSB1  /dev/ttyUSB2
Но minicom по прежнему не реагирует, перебрал все.

Помогло! Хотя ответов в minicom не видел, вслепую набирал AT-команды для каждого ttyUSB*

AT+ZCDRUN=8
AT+ZCDRUN=F
Потом перегрузил и случилось чудо! :)

# lsusb

Bus 002 Device 005: ID [B]19d2:1403[/B] ZTE WCDMA Technologies MSM
1403 - Modem mode. RNDIS + Mass Storage Device.

Вернулся в первоначальное состояние.
