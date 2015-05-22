# -*- mode: ruby -*-
# vi: set ft=ruby :

# some of the scrips are re-used from this github project:
# https://github.com/hashicorp/puppet-bootstrap

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # enable vagrant-cachier
  # to install vagrant-cachier plugin run:
  # vagrant plugin install vagrant-cachier
  config.cache.auto_detect = true
  
  # Set hostname
  config.vm.host_name = "ros"

  # Enable SSH agent forwarding for github
  # https://coderwall.com/p/p3bj2a
  config.ssh.username = 'vagrant'
  config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
  config.ssh.forward_agent = true

  # create tmp 
  config.vm.provision :shell do |shell|
    shell.inline = "mkdir -p tmp; chmod 777 tmp"
  end

  # install essential build tools
  config.vm.provision :shell do |shell|
    shell.path = "provision/shell/install_essential.sh"
  end

  # install ruby 1.9.3 as puppet librarian requires ruby > 1.8
  # so install_ruby.sh and intstall_puppet.sh
  # install the most recent versions. Librarian-puppet.sh
  # autodects installed ruby and installs either librarian-puppet v.1 or 2
  config.vm.provision :shell do |shell|
    shell.path = "provision/shell/install_ruby.sh"
    shell.args = "2.2.1"
  end
  
  config.vm.provision :shell do |shell|
    shell.path = "provision/shell/install_puppet.sh" 
  end
  
  # install librarian-puppet and run it to install puppet common modules.
  # This has to be done before puppet provisioning so that modules are available
  # when puppet tries to parse its manifests
  # by default install librarian-puppet 1.~
  # librarian-puppet 2.~ requires ruby 1.9
  config.vm.provision :shell do |shell|
    shell.path = "provision/shell/librarian-puppet.sh"
    shell.args = "'/vagrant/provision/puppet'"
  end

  # install erlang
  config.vm.provision :shell do |shell|
    shell.path = "provision/shell/install_erlang.sh"
  end

  # # install texinfo v. 5.2 - flycheck install depends on it
  # config.vm.provision :shell do |shell|
  #   shell.path = "provision/shell/install_texinfo.sh"
  #   shell.args = "5.2"
  # end

  # # # install docker as some puppet code which builds magma needs docker
  # # config.vm.provision :shell, :path => "provision/shell/install_docker.sh"

  # run puppet
  config.vm.provision :puppet do |d|
    # d.options = "--verbose --debug"
    d.manifests_path = "provision/puppet/manifests"
    d.manifest_file = "default.pp"
    d.module_path = [ 'provision/puppet/modules' ]
  end

end



