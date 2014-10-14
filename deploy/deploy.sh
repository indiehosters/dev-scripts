#!/bin/sh
if [ $# -eq 2 ]; then
  BRANCH=$2
else
  BRANCH="master"
fi
echo "Infrastructure branch is $BRANCH"

chmod -R go-w ../orchestration/deploy-keys
if [ -f ../orchestration/deploy-keys/authorized_keys ]; then
  scp -r ../orchestration/deploy-keys root@$1:.ssh
fi
scp ./deploy/onServer.sh root@$1:
scp ../infrastructure/cloud-config root@$1:/var/lib/coreos-install/user_data
ssh root@$1 sh ./onServer.sh $BRANCH
cd ../orchestration/per-server/$1/sites/
for i in * ; do
  echo "setting up site $i as `cat $i` on $1";
  ssh root@$1 mkdir -p /data/per-user/$i/
  scp ../../../TLS/approved-certs/$i.pem root@$1:/data/per-user/$i/combined.pem
  ssh root@$1 sudo sh /data/infrastructure/scripts/approve-user.sh $i `cat $i`
done
