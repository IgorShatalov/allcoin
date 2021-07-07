#!/bin/bash

# BUILD IN DOCKER
COIN=allcoin
# cd /${COIN}/depends
# make
# make install
cd /${COIN}
./autogen.sh
./configure
make
strip /${COIN}/src/${COIN}d
strip /${COIN}/src/${COIN}-cli
cp /${COIN}/src/${COIN}d /usr/local/bin/
cp /${COIN}/src/${COIN}-cli /usr/local/bin/