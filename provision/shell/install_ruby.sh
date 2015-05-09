#!/usr/bin/env bash

#set -x

echo Running "$0"

## to install ruby with rmv
# source /usr/local/rvm/scripts/rvm
# rvm use --install $1
# rvm use $1 --default
# eval $(echo -e ruby --version)
# shift
# if (( $# ))
# then gem install $@
# fi
##

## to install ruby from sources
# sudo apt-get install checkinstall
# wget -c http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p0.tar.gz
# tar -xzf ruby-2.0.0-p0.tar.gz
# cd ruby-2.0.0-p0
# ./configure   
# make
# sudo checkinstall -y \
#   --pkgversion 2.0.0-p0 \
#   --provides "ruby-interpreter"
##

## install ruby 1.9.3
#sudo apt-get -q -y install ruby-full
#https://leonard.io/blog/2012/05/installing-ruby-1-9-3-on-ubuntu-12-04-precise-pengolin/

if [ ! -f tmp/ruby-repo-added ]; then
    sudo apt-get update
    sudo apt-get install ruby1.9.1 ruby1.9.1-dev \
         rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
         build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

    sudo update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 \
         --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz \
         /usr/share/man/man1/ruby1.9.1.1.gz \
         --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 \
         --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 \
         --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1
    
    # choose your interpreter
    # changes symlinks for /usr/bin/ruby , /usr/bin/gem
    # /usr/bin/irb, /usr/bin/ri and man (1) ruby
    sudo update-alternatives --config ruby
    sudo update-alternatives --config gem
    
    # now try
    ruby --version

    # Note that we've been here
    mkdir -p tmp
    touch tmp/ruby-repo-added
fi

echo Finished running "$0"
