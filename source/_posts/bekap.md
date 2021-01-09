---
title: бекап инкриментный
date: 2021-01-09
tags: bekap
---

Инкрементный бэкап расшаренного каталога.


Есть 2 типа админов: те, кто ещё не делают бэкапы, и те, кто уже делают :-) .

Алгоритм работы ниже приведенного скрипта примерно такой. Первого числа каждого месяца делается полный бэкап. При этом предыдущий полный бэкап и дневные бекапы переименовываются добавлением в конец .1 , а еще более старые - удаляются. В остальные дни месяца делается только бэкап изменений, т.е. инкрементный бэкап.



Скрипт бэкапа:

#!/bin/bash

# имя и расположение программы tar
TAR=/bin/tar

# Тип архиватора и расширение. Выбрать либо gzip, либо bzip2
#gzip
arch_type="--gzip"
arch_extension=gz

#bzip
#arch_type="--bzip2"
#arch_extension=bz2

# pwd - текущий рабочий каталог
SCRIPT_DIR=`pwd`

# Что бекапим
DIR_SOURCE="/home/share"

# Лог-файл
LOG="/var/log/archive.log"

# Где храним бекапы. В данном случае кидаются в монтируемую (см. ниже) расшаренную папку компьютера под виндовс.
DIR_TARGET_MONTH="/mnt/month"
DIR_TARGET_DAY="/mnt/day"

#Файлы инкримента
increment="/mnt/increment.inc"
increment_day="/mnt/increment_day.inc"

PATH=/usr/local/bin:/usr/bin:/bin
# текущее число
DOM=`date +%d`
# монтируем шару
if smbmount //192.168.2.100/backup /mnt -o username=admin,password=1234
then
if [ $DOM = "01" ]; then
# если первое число - делаем полный бэкап, предварительно переименовав предыдущий месячный бэкап, и удалив его инкремент
mv $DIR_TARGET_MONTH/full.tar.$arch_extension $DIR_TARGET_MONTH/full.tar.$arch_extension.1
rm $increment
$TAR --create --ignore-failed-read --one-file-system --recursion --preserve-permissions --sparse --listed-incremental=$increment $arch_type --verbose --file=$DIR_TARGET_MONTH/full.tar.$arch_extension $DIR_SOURCE
# переименовываем дневные инкрементные бэкапы, старые бекапы удаляем.
for i in $( find $DIR_TARGET_DAY/ -name "*tar.$arch_extension.1" ); do rm -f $i; done
for i in $( find $DIR_TARGET_DAY/ -name "*tar.$arch_extension" ); do mv $i $i.1; done

else
#если не первое число - делаем инкрементные (только изменения) дневные бекапы
cp $increment $increment_day
$TAR --create --ignore-failed-read --one-file-system --recursion --preserve-permissions --sparse --listed-incremental=$increment_day $arch_type --verbose --file $DIR_TARGET_DAY/day$DOM.tar.$arch_extension $DIR_SOURCE
fi
umount /mnt
else echo "$(date +%F_%R:%S) Ошибка монтирования шары" >> $LOG
fi

А теперь подробнее о ключах tar, с которыми делается бэкап.

--create - говорит, что мы создаем архив

--ignore-failed-read - игнорируем файлы, которые не удалось прочитать, вместо останова с ошибкой - бэкап обычно идет автоматически, и лишние сбои бэкапа нам ни к чему.

--one-file-system - запрещает бэкапу выходить за пределы файловой системы

--recursion - мы выполняем бэкап всех файлов и каталогов по указанному пути, а также всех файлов и каталогов всех подкаталогов (рекурсия).

--preserve-permissions - эта опция говорит архиватору, что мы хотим сохранить все права на сохраняемые файлы.

--sparse - файлы с наличием "пустот" сохраняем именно с указанием мест и длин пустот, а не как файлы с огромным набором нулей.

--listed-incremental=файл_метаданных Суть в следующем:

1. Если указанного файла не существует - выполняется полный бэкап, а сам файл - создается и заполняется.
2. Если указанный файл существует - выполняется инкрементальный бэкап от момента, определяемого файлом, а сам файл - обновляется.

--verbose - вывод подробной информации о процессе - если запускаете вручную, а не планировщиком cron.

--file=файл_бэкапа - этот параметр указывает путь к создаваемому файлу бэкапа.


Восстановление бэкапа.

Вот команда для развертывания бэкапа:

/bin/tar --extract --ignore-failed-read --preserve-permissions --listed-incremental=/dev/null --recursion --sparse --verbose --gzip --file=файл_бэкапа --directory=путь_для_развертывания

Сначала восстанавливается полный месячный бэкап, а уже поверх его в туже дирректорию - бэкап нужного дня.

--extract - говорит о том, что мы разворачиваем архив.

--directory=путь_для_развертывания - путь, куда восстанавливаются файлы. Допустим, мы бэкапили каталог /www/users. Можно предположить, что при восстановлении надо указать тоже /www/users. Но дело в том, что в бэкапе сохраняются полные пути без лидирующего слеша (/). Т.е. все пути сохранились, как www/users/*. Поэтому если мы укажем здесь /www/users - все развернется, как /www/users/www/users. В нашем случае достаточно просто указать / .

--listed-incremental=/dev/null - заметьте, как изменился параметр. При восстановлении файл метаданных роли не играет, однако имя файла все равно требуется. Поэтому мы указываем /dev/null .

Восстановление одной папки из архива:

/bin/tar --extract --ignore-failed-read --preserve-permissions --listed-incremental=/dev/null --recursion --sparse --verbose --gzip --file=full.tar.gz --directory=/mnt/10.10.10.22/backup/10.10.10.4/mail/ home/vmail/pskovholod.ru/zakup_vl/

/bin/tar --extract --ignore-failed-read --preserve-permissions --listed-incremental=/dev/null --recursion --sparse --verbose --gzip --file=day26.tar.gz --directory=/mnt/10.10.10.22/backup/10.10.10.4/mail/ home/vmail/pskovholod.ru/zakup_vl/

На сервачке с двухядерным процессором и 6Гб оперативной памяти полный бэкап шары в 55 Гб занимает около двух часов, примерно столько же и восстановление.
