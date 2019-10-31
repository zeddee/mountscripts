#!/usr/bin/env bash

mountthis="/home/backup2/backupdir"
mountthis2="/home/backup2/backupdir2"
mountpoint -q $mountthis
mounted=$?

if [[ $mounted -ne 0 ]]; then
	umount $mountthis 2>&1 > /dev/null
	mount /dev/sda $mountthis
	chown backup2:backup2 $mountthis
fi

mountpoint -q $mountthis2
mounted=$?

if [[ $mounted -ne 0 ]]; then
	umount $mountthis2 2>&1 > /dev/null
	mount /dev/sdb $mountthis2
	chown backup2:backup2 $mountthis2
fi

