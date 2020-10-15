#!/bin/bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Установим необходимые пакеты
yum update -y
yum install -y epel-release
yum install -y mc vim docker curl

# Добавим docker в автозагрузку
systemctl enable docker
systemctl start docker