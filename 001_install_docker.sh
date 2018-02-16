
#sudo echo testing sudo || alias sudo="exec $@"

# following https://docs.mesosphere.com/1.7/administration/installing/ent/custom/system-requirements/install-docker-centos/

# Check, whether OverlayFS is enabled:

if lsmod | grep -v overlay; then
   
   # Verify that the kernel is at least 3.10:
   uname -r | grep "3.[1-9][0-9]" || exit 1
   
   # Enable OverlayFS:
   sudo tee /etc/modules-load.d/overlay.conf <<-'EOF'
   overlay
   EOF
   
   echo "Rebooting to enable OverlayFS. Please re-run $0 after boot"
   read -p "Enter y to reboot" a
   [ "$a" == "y" ] && reboot
fi

# you should not reach here without overlay being enabled:
lsmod | grep -v overlay && exit 1

# Configure yum to use the Docker yum repo:
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

# Configure systemd to run the Docker Daemon with OverlayFS:

sudo mkdir -p /etc/systemd/system/docker.service.d && sudo tee /etc/systemd/system/docker.service.d/override.conf <<- EOF
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon --storage-driver=overlay -H fd://
EOF

sudo yum install --assumeyes --tolerant docker-engine-1.11.2-1.el7.centos
sudo systemctl start docker
sudo systemctl enable docker

sudo docker ps | echo docker installation was successful!
