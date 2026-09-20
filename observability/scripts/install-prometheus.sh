#!/bin/bash
set -euo pipefail

PROMETHEUS_VERSION="3.13.3"

echo "Creating Prometheus service account..."
id prometheus &>/dev/null || \
  useradd --system --no-create-home --shell /sbin/nologin prometheus

echo "Creating Prometheus directories..."
mkdir -p /etc/prometheus
mkdir -p /var/lib/prometheus

chown -R prometheus:prometheus /var/lib/prometheus

echo "Downloading Prometheus ${PROMETHEUS_VERSION}..."
cd /tmp

curl -LO \
  "https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"

tar -xzf \
  "prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz"

echo "Installing Prometheus binaries..."

install \
  -o prometheus \
  -g prometheus \
  -m 0755 \
  "prometheus-${PROMETHEUS_VERSION}.linux-amd64/prometheus" \
  /usr/local/bin/prometheus

install \
  -o prometheus \
  -g prometheus \
  -m 0755 \
  "prometheus-${PROMETHEUS_VERSION}.linux-amd64/promtool" \
  /usr/local/bin/promtool

echo "Creating Prometheus systemd service..."

cat > /etc/systemd/system/prometheus.service <<'EOF'
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple

ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.listen-address=127.0.0.1:9090

Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

echo "Prometheus binaries and service installed."
echo "Deploy /etc/prometheus/prometheus.yml before starting Prometheus."
