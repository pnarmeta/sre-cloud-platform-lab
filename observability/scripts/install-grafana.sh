#!/bin/bash
set -euo pipefail

GRAFANA_VERSION="13.2.2"
GRAFANA_RPM="grafana_${GRAFANA_VERSION}_34846740809_linux_amd64.rpm"
GRAFANA_URL="https://dl.grafana.com/grafana/release/${GRAFANA_VERSION}/${GRAFANA_RPM}"

echo "Installing Grafana OSS ${GRAFANA_VERSION}..."

dnf install -y "${GRAFANA_URL}"

echo "Creating dashboard directory..."
mkdir -p /var/lib/grafana/dashboards

chown -R grafana:grafana /var/lib/grafana/dashboards

echo "Configuring Grafana to listen only on localhost..."

if grep -q '^;http_addr =' /etc/grafana/grafana.ini; then
  sed -i 's/^;http_addr =.*/http_addr = 127.0.0.1/' /etc/grafana/grafana.ini
elif grep -q '^http_addr =' /etc/grafana/grafana.ini; then
  sed -i 's/^http_addr =.*/http_addr = 127.0.0.1/' /etc/grafana/grafana.ini
fi

systemctl daemon-reload
systemctl enable grafana-server

echo "Grafana installation complete."
echo "Deploy provisioning files before starting Grafana."