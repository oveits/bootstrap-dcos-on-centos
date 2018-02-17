
SELINUX=$(cat /etc/selinux/config | grep "^SELINUX=" | awk -F "=" '{print $2}')

if [ "$SELINUX" == enforcing ]; then
   echo "Found that SELinux is set to enforcing. We will change this to permissive."
   sudo sed -i s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config
   REBOOT=yes
fi

# check, whether groups "docker" and "nogroup" exist:
getent group docker && sudo groupadd docker
getent group nogroup && sudo groupadd nogroup

[ "$REBOOT" == "yes" ] && read -p "Need to reboot for the changes to take effect. Reboot now? Please exactly type y > " a;

[ "$a" == "y" ] && sudo reboot
   
