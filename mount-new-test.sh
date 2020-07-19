#!/usr/bin/env bash

mounter() {
    # 1: mount source dir
    # 2: mount destination dir
    # 3: owner

    SRCDIR=$1
    DESTDIR=$2
    THISOWNER=$3

    if [[ $(findmnt -M "$DESTDIR") ]]; then
        echo "Mounting $DESTDIR"
        umount "$DESTDIR" 2>&1 > /dev/null # safety check
        mount "$SRCDIR" "$DESTDIR"
        chown "$THISOWNER:$THISOWNER" "$DESTDIR"
    fi
}

mounter "/dev/sda" "/home/backup2/backupdir" "backup2"
