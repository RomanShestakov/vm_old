#!/usr/bin/env bash

if [ ! -f tmp/erlang-repos-added ]; then
	# Grab the repository package and install
    wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
    sudo dpkg -i erlang-solutions_1.0_all.deb
    #wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
    #rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
    # Note that we've been here
    mkdir -p tmp
    touch tmp/erlang-repos-added

    # Update our repository lists
    sudo apt-get update -y
    #sudo yum -y install erlang

    # Remove the package
    rm erlang-solutions_1.0_all.deb
    #rm erlang-solutions-1.0-1.noarch.rpm
fi

# # Install/update erlang
sudo apt-get install -y erlang
#sudo yum -y install erlang

