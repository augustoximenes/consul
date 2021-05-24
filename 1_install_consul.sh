#!/bin/sh

set -e

if [ -z "${CONSUL_VERSION}" ]; then
  echo "Error: environment variable CONSUL_VERSION is not set"
  exit 1
fi

echo "Installing dependencies ..."
sudo apt-get update
sudo apt-get install -y unzip curl dnsutils

echo "Fetching Consul version ${CONSUL_VERSION} ..."
curl -s https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip -o consul.zip

echo "Installing Consul version ${CONSUL_VERSION} ..."
unzip consul.zip
sudo chown root:root consul
sudo mv consul /usr/bin/

echo "Creating a unique, non-privileged system user to run Consul and its data directory. ..."
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir --parents /opt/consul
sudo chown --recursive consul:consul /opt/consul

echo "Configuring Consul agents ..."
sudo mkdir --parents /etc/consul.d
sudo cp /vagrant/config/consul.hcl /etc/consul.d/consul.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul.hcl
