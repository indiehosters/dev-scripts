#!/bin/sh
mkdir /data
cd /data
git clone https://github.com/indiehosters/infrastructure.git
cd infrastructure
sh scripts/setup.sh
