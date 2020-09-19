---
title: platformio
date: 2020-07-02 18:14:59
tags: среда разработки arm
---
скачиваем установочный файл
    
    curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py -o get-platformio.py
запускаем установку

    python3 get-platformio.py

добавляем в PATH файл ~/.bashrc  строку

    export PATH=$PATH:~/.platformio/penv/bin
