#!/bin/bash

sudo yum list installed | grep iptables || sudo yum install -y iptables
sudo yum list installed | grep cronie || sudo yum install -y cronie
sudo yum list installed | grep git || sudo yum install -y git

cd ~
git clone https://github.com/oveits/bootstrap-centos 2>/dev/null
cd bootstrap-centos
git pull

crontab -l | grep 7_create_iptables_entries.sh && exit 0 || echo '* * * * * /root/bootstrap-centos/7_create_iptables_entries.sh > /tmp/update-firewall.log 2>&1' | crontab -
