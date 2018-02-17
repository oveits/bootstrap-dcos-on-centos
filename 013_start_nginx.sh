#!/bin/sh

# stop bootstrap-nginx, if it exists:
sudo docker stop bootstrap-nginx 2>&1 1>/dev/null 
sudo docker rm bootstrap-nginx 2>&1 1>/dev/null

sudo docker run -d -p 43756:80 --name bootstrap-nginx -v $PWD/genconf/serve:/usr/share/nginx/html:ro nginx
