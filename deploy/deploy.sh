#!/bin/sh
if [ $# -ge 2 ]; then
  BRANCH=$2
else
  BRANCH="master"
fi
if [ $# -ge 3 ]; then
  USER=$3
else
  USER="core"
fi
echo "Infrastructure branch is $BRANCH"
echo "Remote user is $USER"

chmod -R go-w ../orchestration/deploy-keys
if [ -f ../orchestration/deploy-keys/authorized_keys ]; then
  scp -r ../orchestration/deploy-keys $USER@$1:.ssh
fi
scp ./deploy/onServer.sh $USER@$1:
ssh $USER@$1 sudo mkdir -p /var/lib/coreos-install/
scp ../infrastructure/cloud-config $USER@$1:/var/lib/coreos-install/user_data
ssh $USER@$1 sudo sh ./onServer.sh $BRANCH
cd ../orchestration/per-server/$1/sites/
for i in * ; do
  echo "setting up site $i as `cat $i` on $1";
  ssh $USER@$1 sudo mkdir -p /data/per-user/$i/
  scp ../../../TLS/approved-certs/$i.pem $USER@$1:/data/server-wide/haproxy/approved-certs/$i.pem
  scp -r ../../../../user-data/live/$1/$i $USER@$1:/data/per-user/$i
  ssh $USER@$1 sudo sh /data/infrastructure/scripts/activate-user.sh $i `cat $i`
done
