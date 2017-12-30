# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
dir = File.dirname(File.expand_path(__FILE__))

require 'yaml'
configValues = YAML.load_file("#{dir}/config.yaml")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = configValues['vm']['hostname']

  config.vm.network :private_network, ip: configValues['vm']['ip'], auto_config: false

  config.vm.provision "shell",
    run: "always",
    inline: "ifconfig enp0s8 #{configValues['vm']['ip']} netmask 255.255.255.0 up"

  config.vm.network :forwarded_port, host: 8080, guest: 80
  config.vm.network :forwarded_port, host: 3306, guest: 3306

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", configValues['vm']['memory'],            # How much RAM to give the VM (in MB)
      "--cpus", configValues['vm']['cpus'],                 # Muli-core in the VM
      "--ioapic", "on",
      "--natdnshostresolver1", "on",
      "--natdnsproxy1", "on",
      "--cableconnected1", "on"
    ]
  end

  # Synced Folders
  # --------------------
  config.vm.synced_folder ".", "/vagrant/", :mount_options => [ "dmode=775", "fmode=664" ]
  config.vm.synced_folder configValues['project_dir'], "/home/ubuntu/projects/", :mount_options => [ "dmode=775", "fmode=664" ]

  # If true, agent forwarding over SSH connections is enabled
  # --------------------
  config.ssh.forward_agent = true

  # The shell to use when executing SSH commands from Vagrant
  # --------------------
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"


  # Provisioning Scripts
  # --------------------

  config.vm.provision :shell, run: 'once' do |init|
      init.path = 'init.sh'
      init.args = ["#{configValues['php']['version']}", "#{configValues['mysql']['root_password']}"]
      #init.run = "once"
  end

  config.vm.provision "shell", inline: "sudo usermod -a -G www-data ubuntu"
  config.vm.provision "shell", path: "load.sh"
  config.vm.provision "shell", inline: "sudo service nginx restart"
end
