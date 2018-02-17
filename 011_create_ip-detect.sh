
sudo mkdir -p genconf
sudo tee genconf/ip-detect <<- 'EOFip-detect'
#!/usr/bin/env bash
set -o nounset -o errexit
export PATH=/usr/sbin:/usr/bin:$PATH
echo $(ip addr show eth0 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
EOFip-detect

chmod +x genconf/ip-detect
