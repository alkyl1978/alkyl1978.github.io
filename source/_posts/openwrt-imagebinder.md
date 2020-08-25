---
title: openwrt imagebinder
date: 2020-08-25 09:43:33
tags: openwrt
---
sudo apt update
sudo apt full-upgrade
sudo apt-get install build-essential libncurses5-dev libncursesw5-dev zlib1g-dev gawk git gettext libssl-dev xsltproc wget unzip python
sudo apt-get clean
wget https://downloads.openwrt.org/releases/18.06.5/targets/ramips/rt305x/openwrt-imagebuilder-18.06.5-ramips-rt305x.Linux-x86_64.tar.xz
tar -xf openwrt-imagebuilder-18.06.5-ramips-rt305x.Linux-x86_64.tar.xz
rm openwrt-imagebuilder-18.06.5-ramips-rt305x.Linux-x86_64.tar.xz
cd openwrt-imagebuilder-18.06.5-ramips-rt305x.Linux-x86_64
make image PROFILE=nbg-419n -j3