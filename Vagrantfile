# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "webserver_artemis" do |webserver_artemis|
    webserver_artemis.vm.network "private_network", ip: "192.168.33.10"
    webserver_artemis.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
    end
  end

  config.vm.define "webserver_appolon" do |webserver_appolon|
    webserver_appolon.vm.network "private_network", ip: "192.168.33.11"
    webserver_appolon.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
    end
  end

  config.vm.define "webserver_hermes" do |webserver_hermes|
    webserver_hermes.vm.network "private_network", ip: "192.168.33.12"
    webserver_hermes.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
    end
  end

  config.vm.define "database_zeus" do |database_zeus|
    database_zeus.vm.network "private_network", ip: "192.168.33.50"
    database_zeus.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
    end
  end

  config.vm.define "database_poseidon" do |database_poseidon|
    database_poseidon.vm.network "private_network", ip: "192.168.33.51"
    database_poseidon.vm.provider "virtualbox" do |vb|
      vb.memory = "512"
      vb.cpus = "1"
    end
  end
end
