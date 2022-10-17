#!/bin/bash

domain='cloudgeeks.tk'
export domain

mkdir -p ${HOME}/nginx/conf.d

cat << EOF > ${HOME}/nginx/conf.d/tls.conf
server {
    listen 443 http2 ssl;
    listen [::]:443 http2 ssl;

    server_name ${domain};

     location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    ssl_certificate /etc/ssl/certs/${domain}.crt;
    ssl_certificate_key /etc/ssl/private/${domain}.key;
    
}
EOF


docker run --name nginx -p 443:443 -v ${HOME}/tls:/etc/ssl/private -v ${HOME}/tls:/etc/ssl/certs -v ${HOME}/nginx/conf.d:/etc/nginx/conf.d --restart unless-stopped -id nginx:alpine


# End