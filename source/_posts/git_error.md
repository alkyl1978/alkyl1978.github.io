---
title: устранение некоторых ошибок в git
tags: git
---

Если Выскакивает ошибка

    error: cannot lock ref 'refs/remotes/origin/master': unable to resolve reference 'refs/remotes/origin/master': reference broken
то ее можно удалить командой

    rm .git/refs/remotes/origin/master

а потом обновить реаозиторий

    git fetch
