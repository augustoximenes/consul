#!/bin/sh

set -e

echo "Configuring systemd ..."
sudo cp /vagrant/config/consul.service /etc/systemd/system/consul.service
sudo consul validate /etc/consul.d/consul.hcl
sudo systemctl enable consul
sudo systemctl start consul
