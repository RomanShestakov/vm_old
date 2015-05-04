#!/usr/bin/env bash

#set -x

source /usr/local/rvm/scripts/rvm

rvm use --install $1
rvm use $1 --default
eval $(echo -e ruby --version)

shift
if (( $# ))
then gem install $@
fi

