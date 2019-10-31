#!/usr/bin/env bash

mountthis="/home/backup2/backupdir"
mountpoint -q $mountthis
mounted=$?

if [[ $mounted -ne 0 ]]; then
	umount $mountthis 2>&1 > /dev/null
	s3fs tti-cold $mountthis -o url=https://sgp1.digitaloceanspaces.com -o passwd_file=/etc/passwd-s3fs -o allow_other -o nosuid -o nodev -o nonempty
fi
