#!/bin/bash

COIN=allcoin
PLATFORMS="linux win osx"
XOUT=~/${COIN}-build
XSRC=`pwd`/../
GITIAN=~/gitian-builder

echo "STEP 1: PULL FROM REPOSITORY"
cd ${XSRC}
git pull

mkdir -p ${XOUT}
rm -rf ${XOUT}/*
cd ${GITIAN}
echo "STEP 2: BUILDING"
echo '----- BUILD -----' > ${XOUT}/build.log
for [[ XPFM in $PLATFORMS ]]
do
    echo "BUILD: ${XPFM}"
    ./bin/gbuild -j 10 -m 10000 --commit ${COIN}=master ${XSRC}/contrib/gitian-descriptors/gitian-${XPFM}.yml
    echo "---> Platform: ${XPFM}\n" >> ${XOUT}/build.log
    cat var/build.log >> ${XOUT}/build.log
    cp -rf build/out/* ${XOUT}
    rm -rf ${XOUT}/*debug*
done

echo "STEP 3: CREATE ARCHIVE"
rm -rf ${XOUT}.tar.gz
tar -cvzf ${XOUT}.tar.gz ${XOUT}

echo "DONE"