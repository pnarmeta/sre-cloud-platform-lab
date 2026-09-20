#!/bin/bash
set -euo pipefail

NODE_EXPORTER_VERSION="1.12.1"

echo "Creating node_exporter service account..."
id node_exporter &>/dev/null || \
  useradd --system --no-create-home --shell /sbin/nologin node_exporter

echo "Downloading Node Exporter ${NODE_EXPORTER_VERSION}..."
cd /tmp

curl -LO \
  "https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

tar -xzf \
  "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz"

install \
  -o node_exporter \
  -g node_exporter \
  -m 0755 \
  "node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter" \
  /usr/local/bin/node_exporter

echo "Creating Node Exporter systemd service..."

cat > /etc/systemd/system/node_exporter.service <<'EOF'
[Unit]
Description=Prometheus Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.listen-address=127.0.0.1:9100
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now node_exporter

echo "Checking Node Exporter..."
systemctl --no-pager status node_exporter

echo "Node Exporter installation complete."