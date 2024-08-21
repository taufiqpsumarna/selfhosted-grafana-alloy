#!/bin/bash
ALLOY_CONFIG_FILE=/etc/alloy/config.alloy
ALLOY_SERVICE_FILE=/etc/systemd/system/alloy.service

echo "Remove existing monitoring tools"
apt remove prom* alloy*
apt autoremove -y
systemctl daemon-reload

echo "Install prerequisite package and add grafana repository"
apt-get install -y gpg unzip wget curl
mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee /etc/apt/sources.list.d/grafana.list
apt-get update

echo "Install Grafana Alloy"
apt-get install -y alloy

echo "Copy config.alloy to $ALLOY_CONFIG_DIR"
cp $ALLOY_CONFIG_DIR $ALLOY_CONFIG_DIR/config.alloy.bak
cp .client/alloy/config.alloy $ALLOY_CONFIG_DIR

echo "Enable docker integration (optional)" #You can disable this option
usermod -a -G docker alloy
sed -i 's/User=alloy/User=root/' "$ALLOY_SERVICE_FILE"
systemctl daemon-reload
systemctl restart alloy

echo "Enabling Grafana alloy"
systemctl-daemon reload
systemctl enable alloy
systemctl start alloy
systemctl status alloy