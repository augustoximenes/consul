#!/bin/sh

set -e

echo "Configuring Client - Services ..."
sudo cp /vagrant/apps/web.json /etc/consul.d/web.json
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/web.json