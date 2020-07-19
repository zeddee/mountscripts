auto_mount() {
    # 1: mount source dir
    # 2: mount destination dir
    # 3: owner
    THISOWNER=${3:backup2}
    SRCDIR=$1
    DESTDIR=$2
    if [[ ! $(findmnt -M "$DESTDIR") ]]; then
        owner?=
        umount "$DESTDIR" 2>&1 > /dev/null # safety check
        mount "$SRCDIR" "$DESTDIR"
        chown "$THISOWNER:$THISOWNER" "$DESTDIR"
    fi
}

auto_mount "/dev/sda" "/home/backup2/backupdir" "backup2"
