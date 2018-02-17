


sudo mkdir -p genconf

[ ! -x genconf/ip-detect ] && echo "genconf/ip-detect not found; exiting..." && exit 1
BOOTSTRAP_IP=$(genconf/ip-detect)

sudo tee genconf/config.yaml <<- EOFconfig.yaml
---
bootstrap_url: http://${BOOTSTRAP_IP}
cluster_name: cluster_1
exhibitor_storage_backend: static
master_discovery: static
ip_detect_public_filename: genconf/ip-detect
master_list:
- 94.130.187.229
resolvers:
- 8.8.4.4
- 8.8.8.8
use_proxy: 'false'
http_proxy: http://<proxy_host>:<http_proxy_port>
https_proxy: https://<proxy_host>:<https_proxy_port>
no_proxy:
- 'foo.bar.com'
- '.baz.com'
EOFconfig.yaml

