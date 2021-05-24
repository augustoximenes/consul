#!/bin/sh

set -e

echo "Configuring Client - Services ..."
sudo cp /vagrant/apps/frontend-1/consul-service.json /etc/consul.d
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul-service.json