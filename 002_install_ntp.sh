#!/bin/sh

systemctl status ntpd | grep "Active: active (running)" && echo "ntp is already installed; exiting with success" && exit 0

# Following https://der-linux-admin.de/2014/10/centos-7-aktuelle-zeit-vom-zeitserver-abrufen-ntpd/ for Germany

sudo yum -y install ntp

sudo tee /etc/ntp.conf <<-'EOFntp.conf'
server 0.de.pool.ntp.org
server 1.de.pool.ntp.org
server 2.de.pool.ntp.org
server 3.de.pool.ntp.org
EOFntp.conf

systemctl enable ntpd
systemctl start ntpd

ntpq -p
