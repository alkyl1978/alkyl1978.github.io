---
title: rs-local
date: 2020-07-07 23:28:56
tags:
---
В последних версиях Debian выпилили файл rc.local, который позволяет выполнять произвольные скрипты при запуске системы. Данное решение очень удобно, поэтому запилим его обратно.

Скачать скрипт устаноки rc.local в качестве сервиса

Создадим файл сервиса:

sudo nano /etc/systemd/system/rc-local.service

Со следующим содержимым: 

[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
 
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
 
[Install]
WantedBy=multi-user.target

 

Создадим сам rc.local:

sudo nano /etc/rc.local

#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
 
exit 0

Добавим права на выполнение:

sudo chmod +x /etc/rc.local

Добавим сервис в автозапуск:

sudo systemctl enable rc-local

Запускаем сервис:

sudo systemctl start rc-local

Смотрим состояние сервиса:

sudo systemctl status rc-local
