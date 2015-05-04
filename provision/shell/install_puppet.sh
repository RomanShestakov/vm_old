#!/bin/bash

# http://garylarizza.com/blog/2013/02/01/repeatable-puppet-development-with-vagrant/
# https://github.com/hashicorp/puppet-bootstrap/blob/master/centos_6_x.sh
#set -x

REPO_URL="http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if which puppet > /dev/null 2>&1; then
  echo "Puppet is already installed."
  exit 0
fi

# Install puppet labs repo
echo "Configuring PuppetLabs repo..."
repo_path=$(mktemp)
wget --output-document="${repo_path}" "${REPO_URL}" 2>/dev/null
rpm -i "${repo_path}" >/dev/null

# Install Puppet...
echo "Installing puppet"
yum install -y puppet > /dev/null

gem install puppet

echo "Puppet installed!"
