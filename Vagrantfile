# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "vagrant.local"

  config.vm.network :private_network, ip: "192.168.100.101"
  config.vm.network :forwarded_port, host: 8080, guest: 80

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", 1024,            # How much RAM to give the VM (in MB)
      "--cpus", 2,                 # Muli-core in the VM
      "--ioapic", "on",
      "--natdnshostresolver1", "on",
      "--natdnsproxy1", "on"
    ]
  end

  # Synced Folders
  # --------------------
  config.vm.synced_folder ".", "/vagrant/", :mount_options => [ "dmode=777", "fmode=666" ]
  config.vm.synced_folder "../source", "/vagrant/htdocs/", :mount_options => [ "dmode=775", "fmode=644" ]

  # If true, agent forwarding over SSH connections is enabled
  # --------------------
  config.ssh.forward_agent = true

  # The shell to use when executing SSH commands from Vagrant
  # --------------------
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"


  # Provisioning Scripts
  # --------------------
  config.vm.provision "shell", path: "init.sh"
end
