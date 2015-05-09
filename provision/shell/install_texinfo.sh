#!/bin/sh

## install texinfo to allow build info files for emacs
## http://www.linuxfromscratch.org/lfs/view/development/chapter06/texinfo.html

VERSION="$1"

if [ ! -f tmp/texinfo-repo-added ]; then
    #sudo apt-get uninstall texinfo
    wget http://ftp.gnu.org/gnu/texinfo/texinfo-${VERSION}.tar.gz
    gzip -dc < texinfo-${VERSION}.tar.gz | tar -xf -
    cd texinfo-${VERSION}
    sudo ./configure --prefix=/usr
    make TEXMF=/usr/share/texmf install-tex
    make install
    cd ..
    
    ## clean up
    echo Cleaning up texinfo
    sudo rm texinfo-${VERSION}.tar.*
    sudo rm -rf texinfo-${VERSION}
    
    # Note that we've been here
    mkdir -p tmp
    touch tmp/texinfo-repo-added
fi

echo Finished running "$0"
