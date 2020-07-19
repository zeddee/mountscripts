#!/usr/bin/env bash

mounter() {
    # 1: mount source dir
    # 2: mount destination dir
    # 3: owner

    SRCDIR=$1
    DESTDIR=$2
    THISOWNER=$3

    if [[ ! $(findmnt -M "$DESTDIR") ]]; then
        echo "Mounting $DESTDIR"
        umount "$DESTDIR" 2>&1 > /dev/null # safety check
        mount "$SRCDIR" "$DESTDIR"
        chown "$THISOWNER:$THISOWNER" "$DESTDIR"
    else
        echo "$DESTDIR already mounted. Doing nothing."
    fi
}

# modified for s3fs
mounter_s3fs() {
    # 1: bucket name
    # 2: mount target dir
    # 3: s3 endpoint full url
    # 4: Location of aws credential file. File should contain creds in the format "<key>:<secret>"
    # 4: owner

    BUCKET=$1
    MOUNT_TARGET=$2
    S3_URL=$3
    PASSWORD_FILE=$4
    THISOWNER=$5

    if [[ ! $(findmnt -M "$MOUNT_TARGET") ]]; then
        echo "Mounting $MOUNT_TARGET"
        umount "$MOUNT_TARGET" 2>&1 > /dev/null # safety check
        s3fs "$BUCKET" "$MOUNT_TARGET" -o url="$S3_URL",passwd_file="$PASSWORD_FILE",use_cache="/tmp",nonempty,allow_other
        chown "$THISOWNER:$THISOWNER" "$MOUNT_TARGET"
    else
        echo "$MOUNT_TARGET already mounted. Doing nothing."
    fi
}

mounter "/dev/sda" "/home/backup2/backupdir" "backup2"
mounter_s3fs "ttibackup-block" "/home/backup2/do-block" "https://sgp1.digitaloceanspaces.com" "/etc/.do-block-keys"
