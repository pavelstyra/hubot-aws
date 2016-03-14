#!/bin/bash

apt-get -y update
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Kiev /etc/localtime

dpkg -s curl &>/dev/null || {
  apt-get -y install curl
}

dpkg -s nodejs &>/dev/null || {
  curl -sL https://deb.nodesource.com/setup_5.x | bash -
  apt-get -y install nodejs
}

command -v yo &>/dev/null || {
  cd /vagrant/myhubot && npm install -g yo generator-hubot hubot coffee-script
}

dpkg -s libexpat1-dev &>/dev/null || {
  apt-get -y install libexpat1-dev
}

# Ubuntu upstart
# cp /vagrant/upstart/myhubot.conf /etc/init/myhubot.conf
# Debian systemd
machine=$1
cp /vagrant/systemd/myhubot-$machine.service /etc/systemd/system/myhubot.service

run_as=$2
sudo -u $run_as -i sh -c 'cd /vagrant/myhubot; npm install'
systemctl daemon-reload
systemctl enable myhubot
service myhubot restart
