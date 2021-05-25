#!/bin/sh

set -e

echo "Starting Sidecar Service - web..."
sudo cp /vagrant/apps/frontend/consul-sidecar-web.service /etc/systemd/system
sudo systemctl enable consul-sidecar-web
sudo systemctl start consul-sidecar-web

echo "Starting Sidecar Service - nginx..."
sudo cp /vagrant/apps/frontend/consul-sidecar-nginx.service /etc/systemd/system
sudo systemctl enable consul-sidecar-nginx
sudo systemctl start consul-sidecar-nginx