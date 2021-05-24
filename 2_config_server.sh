#!/bin/sh

set -e

echo "Configuring Consul server ..."
sudo cp /vagrant/config/server.hcl /etc/consul.d/server.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/server.hcl
