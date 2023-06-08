#!/bin/bash
## used to install casaos after boot.
curl -fsSL get.casaos.io/install.sh | sudo bash
rm -- "$0"
exit 0
