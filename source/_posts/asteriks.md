---
title: asteriks
date: 2020-05-02 00:09:44
tags: "астерикс"
---
### Установка Астерикса

Идем на страницу https://www.asterisk.org/downloads/asterisk/all-asterisk-versions 
и копируем ссылку на нужную версию. Загружаем ее на сервер.

выполняем команды
    cd ~
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
    tar xfz asterisk-16-current.tar.gz
    cd asterisk-16*/
    contrib/scripts/install_prereq install
    contrib/scripts/get_mp3_source.sh

