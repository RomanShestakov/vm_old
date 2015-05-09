#!/bin/bash

# http://garylarizza.com/blog/2013/02/01/repeatable-puppet-development-with-vagrant/
# https://github.com/hashicorp/puppet-bootstrap/blob/master/centos_6_x.sh
#set -x

# REPO_URL="http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"

# if [ "$EUID" -ne "0" ]; then
#   echo "This script must be run as root." >&2
#   exit 1
# fi

# if which puppet > /dev/null 2>&1; then
#   echo "Puppet is already installed."
#   exit 0
# fi

# # Install puppet labs repo
# echo "Configuring PuppetLabs repo..."
# repo_path=$(mktemp)
# wget --output-document="${repo_path}" "${REPO_URL}" 2>/dev/null
# rpm -i "${repo_path}" >/dev/null

# # Install Puppet...
# echo "Installing puppet"
# yum install -y puppet > /dev/null

# gem install puppet

if [ ! -f tmp/puppet-repo-added ]; then
    #http://blog.doismellburning.co.uk/2013/01/19/upgrading-puppet-in-vagrant-boxes/
    apt-get install --yes lsb-release
    DISTRIB_CODENAME=$(lsb_release --codename --short)
    DEB="puppetlabs-release-${DISTRIB_CODENAME}.deb"
    # Assume that this file's existence means we have the Puppet Labs repo added
    DEB_PROVIDES="/etc/apt/sources.list.d/puppetlabs.list" 
    
    if [ ! -e $DEB_PROVIDES ]
    then
        # Print statement useful for debugging, but automated runs of this will interpret any output as an error
        # print "Could not find $DEB_PROVIDES - fetching and installing $DEB"
        wget -q http://apt.puppetlabs.com/$DEB
        sudo dpkg -i $DEB
    fi
    sudo apt-get update
    sudo apt-get install --yes puppet

    # Note that we've been here
    mkdir -p tmp
    touch tmp/puppet-repo-added
fi
    
echo "Puppet version: $(puppet --version) installed!"


