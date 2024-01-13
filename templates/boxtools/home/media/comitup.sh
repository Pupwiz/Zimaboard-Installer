#!/bin/bash

wget https://davesteele.github.io/comitup/latest/davesteele-comitup-apt-source_latest.deb
dpkg -i --force-all davesteele-comitup-apt-source_latest.deb
rm davesteele-comitup-apt-source_latest.deb
apt-get update
apt-get install comitup comitup-watch -y
