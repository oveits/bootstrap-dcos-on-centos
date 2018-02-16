#!/bin/sh

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
