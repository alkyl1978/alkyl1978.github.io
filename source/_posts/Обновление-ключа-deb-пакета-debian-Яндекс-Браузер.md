title: Обновление ключа deb пакета debian Яндекс.Браузер
author: aleks kylikov
tags:
  - debian
  - yandex
categories:
  - debian
date: 2023-06-26 21:03:00
---
Если при обновлении с помощью команд
```
   sudo apt upt update
   sudo apt upgrade
```
вылезла ошибка.

Произошла ошибка при проверке подписи. Репозиторий не обновлён, и будут использованы предыдущие индексные файлы. Ошибка GPG:
```
https://repo.yandex.ru/yandex-browser/deb stable InRelease: Следующие подписи не могут быть проверены, так как недоступен открытый ключ: NO_PUBKEY 60B9CD3A083A7A9A

Не удалось получить https://repo.yandex.ru/yandex-browser/deb/dists/stable/InRelease Следующие подписи не могут быть проверены, так как недоступен открытый ключ: NO_PUBKEY 60B9CD3A083A7A9A

Некоторые индексные файлы скачать не удалось. Они были проигнорированы, или вместо них были использованы старые версии.
```

Надо обновить ключ Яндекс браузера
```
wget https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG -O- | apt-key add -
```
потом выполнить команду
```
apt update  

apt upgrade
```