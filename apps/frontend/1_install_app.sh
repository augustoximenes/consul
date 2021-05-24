#!/bin/sh

set -e

echo "Installing dependencies ..."
sudo apt-get install -y nginx
sudo cp /vagrant/apps/frontend/default /etc/nginx/sites-enabled
sudo service nginx reload