#!/bin/sh -eux
DEBIAN_FRONTEND=noninteractive
#echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

echo "Make localisation DE "
apt-get update
apt-get install -y $(check-language-support) || true
locale-gen de_DE.UTF-8
sudo su -c 'export LANG=de_DE@euro LANGUAGE=de_DE@euro LC_ALL=POSIX' vagrant
update-locale LANG=de_DE.UTF-8 LANGUAGE=de_DE.UTF-8
timedatectl set-timezone Europe/Berlin

#Set bash keyboard to german
sed -i 's/XKBLAYOUT=\"\w*"/XKBLAYOUT=\"'de'\"/g' /etc/default/keyboard

#Set gnome keyboard to german
printf "\ngsettings set org.gnome.desktop.input-sources sources \"[('xkb', 'de')]\"" >> /home/vagrant/.profile

