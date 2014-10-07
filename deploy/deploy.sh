#scp -r ../hoster-data/orchestration/root.ssh root@$1:.ssh
#scp -r ./deploy/onServer.sh root@$1:
#ssh root@$1 onServer.sh
cd ../hoster-data/orchestration/per-server/$1/sites/
for i in * ; do
  echo "setting up site $i as `cat $i` on $1";
done
