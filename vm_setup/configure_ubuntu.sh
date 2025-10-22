#!/bin/bash

# Configure bash history
sudo echo 'export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"' >> /etc/bashrc
sudo echo 'export HISTSIZE=10000' >> /etc/bashrc
sudo echo 'export HISTFILESIZE=10000' >> /etc/bashrc

### DEPENDENCIES

sudo apt install -y git python3 python3-dev python3-venv libaugeas-dev gcc nginx

# Enable nginx
sudo systemctl enable --now nginx

# Configure Nginx
cat <<EOF | sudo tee /etc/nginx/conf.d/gc2026.gocongress.org.conf > /dev/null
server {
    listen 80;
    server_name gc2026.gocongress.org;

    location / {
        proxy_pass http://localhost:11434;
        proxy_http_version 1.1;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header Connection "";
        proxy_connect_timeout       60;
        proxy_send_timeout          3600;
        proxy_read_timeout          3600;
        send_timeout                3600;
    }
}
EOF
sudo nginx -t && sudo systemctl reload nginx

# Setup certbot:
if ! command -v certbot &>/dev/null; then
    sudo python3 -m venv /opt/certbot/
    sudo /opt/certbot/bin/pip install --upgrade pip
    sudo /opt/certbot/bin/pip install certbot certbot-nginx
    sudo ln -s /opt/certbot/bin/certbot /usr/bin/certbot
    sudo certbot --nginx --non-interactive --agree-tos \
      -d gc2026.gocongress.org \
      -m admin@eradeo.com # TODO change to webmaster@gocongress.org once redirect to current webmaster is complete
    # job to automatically renew cert and trigger nginx reload when renewed:
    echo "0 0,12 * * * root /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && sudo certbot renew -q --deploy-hook 'systemctl reload nginx'" | sudo tee -a /etc/crontab > /dev/null
    # job to once a month upgrade certbot:
    echo "0 3 1 * * root /opt/certbot/bin/pip install --upgrade certbot certbot-nginx > /var/log/certbot_update.log 2>&1" | sudo tee -a /etc/crontab > /dev/null
fi

# Install/configure Docker
if ! command -v docker &>/dev/null; then
    sudo apt install -f -y docker.io docker-compose-v2
    sudo usermod -aG docker $USER
    sudo newgrp docker
    test -d /etc/docker || sudo mkdir -pv /etc/docker
    # configure docker logging to ensure logs do not growth without bound
    test -f /etc/docker/daemon.json || cat <<'EOF' | sudo tee /etc/docker/daemon.json
{
  "debug": false,
  "experimental": false,
  "exec-opts": ["native.cgroupdriver=systemd"],
  "userland-proxy": false,
  "live-restore": true,
  "log-level": "warn",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}
EOF
    # ensure service is enabled just in case:
    sudo systemctl enable --now docker.service
fi

# configure the firewall
sudo ufw enable
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443