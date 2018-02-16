
SELINUX=$(cat /etc/selinux/config | grep "^SELINUX=" | awk -F "=" '{print $2}')

if [ "$SELINUX" == enforcing ]; then
   echo "Found that SELinux is set to enforcing. We will change this to permissive."
   sudo sed -i s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config
fi

# check, whether groups "docker" and "nogroup" exist:
DOCKERGRP=$(getent group docker)
NOGRP=$(getent group nogroup)

[ "$DOCKERGRP" == "" ] && sudo groupadd docker && REBOOT=yes
[ "$NOGRP" == "" ] && sudo groupadd nogroup && REBOOT=yes

[ "$REBOOT" == "yes" ] && read -p "Need to reboot for the changes to take effect. Reboot now? Please exactly type y > " a;

[ "$a" == "y" ] && sudo reboot
   
