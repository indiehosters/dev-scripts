#!/bin/sh
rsync -r root@$1:/data/per-user/* ../user-data/live/$1/
