#!/bin/sh -eux
export DEBIAN_FRONTEND=noninteractive

echo "update the package list"
apt-get -y update

echo "upgrade all installed packages incl. kernel and kernel headers"
apt-get -y dist-upgrade -o Dpkg::Options::="--force-confnew"

reboot
