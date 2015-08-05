#!/usr/bin/env bash

if [ ! -f tmp/erlang-repos-added ]; then
	  # Grab the repository package and install
    curl -O http://erlang.org/download/otp_src_17.5.tar.gz
    tar zxvf otp_src_17.5.tar.gz

    # Note that we've been here
    mkdir -p tmp
    touch tmp/erlang-repos-added

    # Remove the package
    rm otp_src_17.5.tar.gz
fi

# Install/update erlang
cd otp_src_17.5
./configure && make && make install
