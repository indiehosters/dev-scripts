#!/bin/sh
rsync -r root@$1:/data/per-user/* ../user-data/live/$1/
cd ../user-data
git status
git add live/$1
git commit -m"fetched live data from $1"
