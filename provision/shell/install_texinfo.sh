#!/bin/sh

## install texinfo to allow build info files for emacs
## http://www.linuxfromscratch.org/lfs/view/development/chapter06/texinfo.html

VERSION="$1"

#sudo apt-get uninstall texinfo
wget http://ftp.gnu.org/gnu/texinfo/texinfo-${VERSION}.tar.gz
gzip -dc < texinfo-${VERSION}.tar.gz | tar -xf -
cd texinfo-${VERSION}
sudo ./configure --prefix=/usr
make TEXMF=/usr/share/texmf install-tex
make install

echo Finished running "$0"
