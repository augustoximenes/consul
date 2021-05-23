# -*- mode: ruby -*-
# vi: set ft=ruby :

CONSUL_VERSION = "1.9.5"

cluster = {
  "consul-server-1" => { :ip => "192.168.1.11", :cpus => 1, :mem => 256 },
  "consul-server-2" => { :ip => "192.168.1.12", :cpus => 1, :mem => 256 },
  "consul-server-3" => { :ip => "192.168.1.13", :cpus => 1, :mem => 256 }
}

Vagrant.configure("2") do |config|
  cluster.each_with_index do |(hostname, info), index|

    config.vm.define hostname do |cfg|
      cfg.vm.provider :virtualbox do |vb, override|
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]

        config.vm.box = "ubuntu/bionic64"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        override.vm.provision "install_consul", type: "shell", path: "install_consul.sh", env: { "CONSUL_VERSION" => CONSUL_VERSION }
      end
    end

  end
end
