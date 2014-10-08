#!/bin/sh
if [ -e ../user-data/backup/$1 ]; then
  echo "Folder ../user-data/backup/$1 already exists! Please choose a different name."
else
  mkdir ../user-data/backup/$1
  cp -r ../user-data/live/* ../user-data/backup/$1/
  echo "Backup created!"
  du -sh ../user-data/backup/$1
fi
