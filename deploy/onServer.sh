#!/bin/sh
echo Starting etcd:
systemctl start etcd
echo Cloning the infrastructure repo into /data/infrastructure:
mkdir /data
cd /data
git clone https://github.com/indiehosters/infrastructure.git
cd infrastructure
echo Checking out $1 branch of the IndieHosters infrastructure:
git checkout $1
echo Running the server setup script:
sh scripts/setup.sh
