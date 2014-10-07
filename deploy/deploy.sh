#!/bin/sh
chmod -R go-w ../orchestration/deploy-keys
scp -r ../orchestration/deploy-keys root@$1:.ssh
scp ./deploy/onServer.sh root@$1:
ssh root@$1 sh ./onServer.sh
cd ../orchestration/per-server/$1/sites/
for i in * ; do
  echo "setting up site $i as `cat $i` on $1";
  ssh root@$1 mkdir -p /data/per-user/$i/
  scp ../../../TLS/approved-certs/$i.pem root@$1:/data/per-user/$i/combined.pem
  ssh root@$1 sudo sh /data/infrastructure/scripts/approve-user.sh $i `cat $i`
done
