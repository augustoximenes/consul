datacenter = "dc1"
data_dir = "/opt/consul"
encrypt = "P5MPhScaGhg55Vj0CYgMUnGOe0j/HqBsn1p7amKzesI="
ca_file = "/etc/consul.d/consul-agent-ca.pem"
cert_file = "/etc/consul.d/dc1-server-consul-0.pem"
key_file = "/etc/consul.d/dc1-server-consul-0-key.pem"
verify_incoming = true
verify_outgoing = true
verify_server_hostname = true
bind_addr = "{{GetInterfaceIP \"enp0s8\"}}"