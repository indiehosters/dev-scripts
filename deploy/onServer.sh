#!/bin/sh
mkdir /data
cd /data
git clone https://github.com/indiehosters/infrastructure.git
cd infrastructure
git checkout dev
sh scripts/setup.sh
