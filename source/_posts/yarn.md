title: yarn
tags: nodejs
date: 2020-09-13 16:07:18
---
скачиваем ключ

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    
добавляем репозитарий

    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
обновляем репозитарий

    apt-get update
устанавливаем yarn

    apt-get install yarn