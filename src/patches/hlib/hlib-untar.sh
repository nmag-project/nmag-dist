#!/bin/sh

HLIB_TARBALL_DIR="$1"
CANDIDATES="$HLIB_TARBALL_DIR/*.tar.gz"
SHOW_WELCOME=yes
for CANDIDATE in $CANDIDATES; do
  if [ ! -f $CANDIDATE ]; then
    exit 0
  fi

  if [ $SHOW_WELCOME == yes ]; then
    echo "====================================================="
    echo " It seems you want to compile Nmag with HLib support"
    echo " I'll need your confirmation in order to proceed..."
    echo "====================================================="
    SHOW_WELCOME=no
  fi

  echo "I found $CANDIDATE"
  echo -n "Is this the HLib tarball you want to use? (yes/no) "
  read ANSWER
  if [ x$ANSWER == xyes ]; then
    tar xzvf $CANDIDATE
    rm -rf hlib
    mv HLib-* hlib
    exit 0
  fi
done

exit 0

