#!/bin/bash -e
if [ $# -eq 0 ]
then
  echo 'Usage: docker run -ti --rm -v $HOME/drive:/drive -e STAT="$(stat -c "%i %d" .)" odeke-em-drive <OPTIONS>' 1>&2
  echo '-or- Usage: docker run -ti --rm -v $HOME/drive:/drive -w <path> odeke-em-drive <OPTIONS>' 1>&2
  exit 1
fi
if [ ! -d /drive ]
then
  echo "Failed to mount /drive" 1>&2
  exit 1
fi
values=( $(stat -c '%g %u' /drive) )
XGID=${values[0]}
XUID=${values[1]}
groupadd -g $XGID g$XGID 2>>/dev/null || groupmod -g $XGID g$XGID 2>>/dev/null
export HOME=/home/u$XUID
useradd -m -d "$HOME" -u $XUID -g g$XGID u$XUID 2>>/dev/null || usermod -g g$XGID u$XUID 2>>/dev/null
values=( $STAT )
inode=${values[0]}
if [ -n "$inode" ]
then
  devicenr=${values[1]}
  if [ -n "$devicenr" ]
  then
    wd=$(find . -inum $inode -type d -printf '%D %p\n'|sed -n -e "s,^$devicenr ,,p"|head -1 2>>/dev/null)
  else 
    wd=$(find . -inum $inode -type d|head -1) 2>>/dev/null
  fi
  if [ -d "$wd" ]
  then
    echo "Relative Path: $wd"
    cd "$wd"
  fi
fi
exec sudo -E -u u$XUID "$GOPATH/bin/drive" "$@"

