
[ "$BOOTSTRAP_IP" == "" ] && BOOTSTRAP_IP=$(genconf/ip-detect)
[ "$BOOTSTRAP_PORT" == "" ] && BOOTSTRAP_PORT=43756
[ "$PRIVATE_AGENT_IP" == "" ] && PRIVATE_AGENT_IP=195.201.27.175

for IP in $PRIVATE_AGENT_IP; do
   ssh $PRIVATE_AGENT_IP << EOFinstall.sh
   uname -a | awk '{print $2}'

   # working dir:
   mkdir /tmp/dcos
   cd /tmp/dcos
   
   # prerequisites:
   git --version || yum install -y git
   rm -Rf bootstrap-dcos-on-centos 2>/dev/null
   git clone https://github.com/oveits/bootstrap-dcos-on-centos
   cd bootstrap-dcos-on-centos
   ls -l

   for SCRIPT in 001_install_docker.sh 002_install_ntp.sh 005_install_compression.sh 006_configure_SELINUX.sh 007_sudoers.sh 008_disable_firewalld.sh 009_source_LANG.sh 011_create_ip-detect.sh
   do
      echo $SCRIPT
      echo "--- running \${SCRIPT} ---"
      bash \$SCRIPT
   done

   # download install script:
   curl -O http://${BOOTSTRAP_IP}:${BOOTSTRAP_PORT}/dcos_install.sh
   sudo bash dcos_install.sh slave
EOFinstall.sh
done
