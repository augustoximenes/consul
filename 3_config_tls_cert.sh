#!/bin/sh

set -e

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
