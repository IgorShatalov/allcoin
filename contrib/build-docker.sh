#!/bin/bash

# BUILD IN DOCKER
COIN=allcoin
cd /${COIN}/depends
make
make install
cd /${COIN}
./autogen.sh
./configure
make
strip ./${COIN}d
strip ./${COIN}-cli
mv ./${COIN}d /usr/local/bin/
mv ./${COIN}-cli /usr/local/bin/
rm -rf /${COIN}