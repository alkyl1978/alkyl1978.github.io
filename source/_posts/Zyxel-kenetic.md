---
title: Zyxel kenetic
date: 2020-08-15 00:44:17
tags: router
---
Положите в папку установленного tftp-сервера 
(в папку программы-сервера) 
микропрограмму первого поколения V1.00(XXX.X)D0,
предназначенную именно для вашего интернет-центра:


Для восстановления работоспособности Keenetic 4G ревизии А (Rev.A) скачайте архив с микропрограммой: https://help.keenetic.net/hc/article_attachments/209440529/Keenetic-4G-V1.00%5BBWO.4.4%5DD0.zip
Для восстановления работоспособности Keenetic 4G ревизии B (Rev.B) скачайте архив с микропрограммой: https://help.keenetic.net/hc/article_attachments/209440749/Keenetic-4G-V1.00%5BAABV.1.2%5DD0.zip
Отличия интернет-центров Keenetic 4G ревизии A (Rev.A) и Keenetic 4G ревизии B (Rev.B) представлены в статье: «Отличия интернет-центров Keenetic Lite/4G ревизии A (Rev.A) от ревизии B (Rev.B)»
Распакуйте его и переименуйте bin-файл из архива в файл с именем rt305x_firmware.bin.
Подключите компьютер кабелем Ethernet к одному из LAN-портов Keenetic. На сетевом адаптере компьютера установите вручную IP-адрес 192.168.99.8 с маской подсети 255.255.255.0.

3. Удерживая кнопку RESET в нажатом состоянии, включите питание интернет-центра.

4. Через 5 секунд после включения отпустите кнопку RESET. Keenetic должен получить с tftp-сервера файл с именем rt305x_firmware.bin и записать его в энергонезависимую память.