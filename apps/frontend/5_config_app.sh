#!/bin/sh

set -e

echo "Starting Sidecar Service ..."
sudo cp /vagrant/apps/frontend/consul-sidecar.service /etc/systemd/system
sudo systemctl enable consul-sidecar
sudo systemctl start consul-sidecar