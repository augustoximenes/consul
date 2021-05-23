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
sudo cp /vagrant/consul.hcl /etc/consul.d/consul.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/consul.hcl

echo "Configuring Consul server ..."
sudo cp /vagrant/server.hcl /etc/consul.d/server.hcl
sudo chown --recursive consul:consul /etc/consul.d
sudo chmod 640 /etc/consul.d/server.hcl

echo "Generating TLS certificates for RPC encryption ..."
if [ $(hostname) = "consul-server-1" ]; then
  cd /etc/consul.d
  sudo consul tls ca create
  sudo consul tls cert create -server -dc dc1
  sudo consul tls cert create -client -dc dc1
  cp *.pem /vagrant/tls_certificates
else
  sudo cp /vagrant/tls_certificates/*.pem /etc/consul.d
fi

echo "Setting Consul environment variables ..."
export CONSUL_CACERT=/etc/consul.d/consul-agent-ca.pem
export CONSUL_CLIENT_CERT=/etc/consul.d/dc1-server-consul-0.pem
export CONSUL_CLIENT_KEY=/etc/consul.d/dc1-server-consul-0-key.pem

echo "Configuring systemd ..."
sudo cp /vagrant/consul.service /etc/systemd/system/consul.service
sudo consul validate /etc/consul.d/consul.hcl
sudo systemctl enable consul
sudo systemctl start consul