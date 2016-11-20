#!/bin/zsh

cd /tmp
git clone https://github.com/htacg/tidy-html5.git
cd tidy-html5
cd build/cmake
cmake ../.. -DCMAKE_INSTALL_PREFIX=$HOME/local/html5tidy/
make install
mkdir -p $HOME/local/bin
ln -s $HOME/local/html5tidy/bin/tidy $HOME/local/bin/
