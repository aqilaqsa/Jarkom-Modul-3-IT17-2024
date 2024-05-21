echo 'nameserver 10.72.3.1' > /etc/resolv.conf
apt-get update
apt-get install apache2-utils -y
apt-get install nginx -y
apt-get install lynx -y

service nginx start

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/lb_php
mkdir /etc/nginx/supersecret
htpasswd -c /etc/nginx/supersecret/htpasswd secmart


echo ' upstream worker {
    #    hash $request_uri consistent;
    #    least_conn;
    #    ip_hash;
    server 10.72.1.1;
    server 10.72.1.2;
    server 10.72.1.3;
}

server {
    listen 80;
    server_name harkonen.IT17.com www.harkonen.IT17.com;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://worker;
        auth_basic "Restricted Content";
auth_basic_user_file /etc/nginx/supersecret/htpasswd;
    }
} ' > /etc/nginx/sites-available/lb_php

ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart

# 11
echo 'upstream worker {
    server 10.72.1.1;
    server 10.72.1.2;
    server 10.72.1.3;
}

server {
    listen 80;
    server_name harkonen.IT17.com www.harkonen.IT17.com;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        proxy_pass http://worker;
    }

    location /dune {
        proxy_pass https://www.dunemovie.com.au/;
        proxy_set_header Host www.dunemovie.com.au;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php


ln -s /etc/nginx/sites-available/lb_php /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

service nginx restart

#12 - step 2 setelah mohiam, UNTUK RUN STOP NODE START NODE DULU (DMITRI)
echo 'upstream worker {
    server 10.72.1.1;
    server 10.72.1.2;
    server 10.72.1.3;
}

server {
    listen 80;
    server_name harkonen.IT17.com www.harkonen.IT17.com;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    location / {
        allow 10.72.1.37;
        allow 10.72.1.67;
        allow 10.72.2.203;
        allow 10.72.2.207;
        deny all;
        proxy_pass http://worker;
    }

    location /dune {
        allow 10.72.1.37;
        allow 10.72.1.67;
        allow 10.72.2.203;
        allow 10.72.2.207;
        deny all;
        proxy_pass https://www.dunemovie.com.au/;
        proxy_set_header Host www.dunemovie.com.au;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}' > /etc/nginx/sites-available/lb_php

service nginx restart

# 18
echo 'upstream laravel_worker {
    server 10.72.2.1:8001; 
    server 10.72.2.2:8002;
    server 10.72.2.3:8003;
}

server {
    listen 80;
    server_name atreides.IT17.com www.atreides.IT17.com;

    location / {
        proxy_pass http://laravel_worker;
    }
}
' > /etc/nginx/sites-available/laravel-worker

ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/laravel-worker

service nginx restart

# 20
echo 'upstream laravel_worker {
    least_conn;
    server 10.72.2.1:8001;
    server 10.72.2.2:8002;
    server 10.72.2.3:8003;
}

server {
    listen 80;
    server_name atreides.IT17.com www.atreides.IT17.com;

    location / {
        proxy_pass http://laravel_worker;
    }
}
' > /etc/nginx/sites-available/laravel-worker

ln -s /etc/nginx/sites-available/laravel-worker /etc/nginx/sites-enabled/laravel-worker

service nginx restart