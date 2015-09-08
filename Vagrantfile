# -*- mode: ruby -*-
# vi: set ft=ruby :

# some of the scrips are re-used from this github project:
# https://github.com/ANXS/erlang

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  # Every Vagrant development environment requires a box. You can search for
  config.vm.box = "ubuntu/trusty64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/20150907.0.0/providers/virtualbox.box"

  config.vm.hostname = "base.local"

  config.vm.network :private_network, ip: "192.168.111.222"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # # Enable SSH agent forwarding for github
  # # https://coderwall.com/p/p3bj2a
  # config.ssh.username = 'vagrant'
  # config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true

  config.vm.provision "ansible" do |ansible|
    # ansible.verbose = "vvv"
    ansible.playbook = 'provision/ansible/playbooks/vm.yml'
    ansible.sudo = true
    ansible.inventory_path = 'provision/ansible/playbooks/inventory'
    ansible.host_key_checking = false
  end
end
