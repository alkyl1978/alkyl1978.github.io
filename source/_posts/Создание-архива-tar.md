---
title: Создание архива tar
date: 2020-06-10 22:47:17
tags: tar,debian 
---


Архиватор Tar в Linux.
Архив tar может быть сжат в gzip. Формат тогда будет выглядеть так - tar.gz

Как создать архив tar в FreeBSD:

    tar -cvf archive.tar /var/db/mysql/*

c — create - создание архива
v — verbose - выдача доп. сообщений при создании архива
f — создать файл на диске
/var/db/mysql/* - архивируемые файлы через пробел.

 Как сжать содержимое архива tar?

    tar -cvzf archive.tar.gz /var/db/mysql/*

Содержимое архива будет сжато при помощи gzip

Как извлечь содержимое архива tar в текущую папку?

    tar -xf archive.tar - извлечь обычный архив tar в текущую директорию

    tar -xzf archive.tar.gz - извлечь сжатый архив tar в текущую директорию

Как извлечь содержимое архива tar в указанную папку?

    tar -xf archive.tar -C /home/data - извлечь обычный архив tar в директорию /home/data

    tar -xzf archive.tar.gz -C /home/data - извлечь сжатый архив tar в директорию /home/data

Как исключить файл или папку при архивировании или создании архива tar?
Для исключения файлов или папки используется опция --exclude

    tar --exclude='/home/user/*' -cvzf archive.tar.gz /home/*

В этом примере архивируем всю директорию /home , но исключаем из архива папку /home/user
