title: gpg ssh key smart
author: aleks kylikov
date: 2024-11-13 01:10:47
tags:
---
Использование USB-брелоков Yubikey для ключей GPG и SSH	[исправить]
Пример, как можно использовать USB-брелок Yubikey в качестве смарткарты для
хранения GPG-ключей и ключей для аутентификации на SSH-серверах.

Использование с GPG.

Подключаем Yubikey к порту USB и проверяем, что он определился:

   gpg --card-status
   ...
   Version ..........: 2.1
   Manufacturer .....: Yubico

Для переноса GPG-ключа на брелок запускаем "gpg --edit-key идентификатор_ключа"
и выполняем в редакторе команду "keytocard" (внимание, закрытый ключ будет не
скопирован, а перенесён, т.е. удалён с локальной машины, поэтому нужно заранее
позаботиться о создании резервной копии).

Убедимся, что ключ переместился:

   gpg --card-status | grep key

   URL of public key : [...]
   Signature key ....: [...] XXXX YYYY
   Encryption key....: [...] ZZZZ VVVV
   Authentication key: [...] AAAA BBBB
   General key info..: sub  rsa4096/QQQQQQ <foobar@domain.tld>

Для проверки создадим шифрованное сообщение и расшифруем его:

   gpg --encrypt  --output /tmp/message.txt.enc -r foobar@domain.tld /tmp/message.txt
   gpg --decrypt /tmp/message.txt.enc


Настраиваем SSH-ключи.

Удостоверимся, что ключ аутентификации перенесён на Yubikey ("Authentication
key" в выводе "gpg --card-status") и выполним экспорт открытого ключа SSH из Yubikey:

   gpg --export-ssh-key 0xAAAABBBB
  
Далее, скопируем экспортированный ключ на SSH-сервер и настроим gpg-agent для
работы в роли агента SSH:

   echo 'enable-ssh-support' >> ~/.gnupg/gpg-agent.conf       

Перезапустим агенты GPG/SSH:

   killall gpg-agent
   killall ssh-agent
   gpg-agent --daemon

Поменяем путь к сокету SSH_AUTH_SOCK на GPG. В ~/.bashrc:

   export SSH_AGENT_PID=""
   export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

Проверим, виден ли ключ SSH при подключении брелока:

   ssh-add -l

   4096 SHA256:XXXX cardno:0006064XXXX (RSA)

Всё в порядке, теперь при подключении к серверу SSH будет использовать ключ с брелока Yubikey.