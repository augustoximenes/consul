# -*- mode: ruby -*-
# vi: set ft=ruby :

CONSUL_VERSION = "1.9.5"

servers = {
  "consul-server-1" => { :ip => "192.168.1.11", :cpus => 1, :mem => 256 },
  "consul-server-2" => { :ip => "192.168.1.12", :cpus => 1, :mem => 256 },
  "consul-server-3" => { :ip => "192.168.1.13", :cpus => 1, :mem => 256 }
}

clients = {
  "frontend" => { :ip => "192.168.1.21", :cpus => 1, :mem => 256 }
}

Vagrant.configure("2") do |config|

  servers.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |cfg|
      cfg.vm.provider :virtualbox do |vb, override|
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]

        config.vm.box = "ubuntu/bionic64"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        override.vm.provision "install_consul", type: "shell", path: "1_install_consul.sh", env: { "CONSUL_VERSION" => CONSUL_VERSION }
        override.vm.provision "config_server", type: "shell", path: "2_config_server.sh"
        override.vm.provision "config_tls_cert", type: "shell", path: "3_config_tls_cert.sh"
        override.vm.provision "config_systemd", type: "shell", path: "4_config_systemd.sh"
      end
    end
  end

  clients.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |cfg|
      cfg.vm.provider :virtualbox do |vb, override|
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]

        config.vm.box = "ubuntu/bionic64"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        override.vm.provision "install_consul", type: "shell", path: "1_install_consul.sh", env: { "CONSUL_VERSION" => CONSUL_VERSION }
        override.vm.provision "install_app", type: "shell", path: "apps/#{hostname}/1_install_app.sh"
        override.vm.provision "config_client", type: "shell", path: "apps/#{hostname}/2_config_client.sh"
        override.vm.provision "config_tls_cert", type: "shell", path: "3_config_tls_cert.sh"
        override.vm.provision "config_systemd", type: "shell", path: "4_config_systemd.sh"
        override.vm.provision "config_app", type: "shell", path: "apps/#{hostname}/5_config_app.sh"
      end
    end
  end

end
