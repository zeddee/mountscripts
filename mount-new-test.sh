#!/usr/bin/env sh

check_mount() {
    # 1: Check if this dir is mounted
    if [[ $(findmnt -M "$1") ]]; then
        echo "$1 is mounted.";return 1
    else
        echo "$1 is not mounted.";return 0
    fi
}

auto_mount() {
    # 1: mount source dir
    # 2: mount destination dir
    # 3: owner

    SRCDIR=$1
    DESTDIR=$2
    THISOWNER=${3:backup2}

    if [[ $(check_mount "$DESTDIR") -eq 0 ]]; then
        echo "Mounting $DESTDIR"
        umount "$DESTDIR" 2>&1 > /dev/null # safety check
        mount "$SRCDIR" "$DESTDIR"
        chown "$THISOWNER:$THISOWNER" "$DESTDIR"
    fi
}

auto_mount "/dev/sda" "/home/backup2/backupdir" "backup2"
