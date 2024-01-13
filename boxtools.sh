#!/bin/bash
VER=1.01
DIR=$(pwd)
rm $DIR/local_packages/boxtools*.deb
mkdir -p $DIR/boxtools_amd64/opt
cp $DIR/templates/boxtools/* $DIR/boxtools_amd64/ -rf
dpkg-deb -b boxtools_amd64/ boxtools_$VER-amd64.deb
mv boxtools_$VER-amd64.deb ./local_packages
##Remove html folder for next build or it will cause errors
rm $DIR/boxtools_amd64/ -rf
exit 0