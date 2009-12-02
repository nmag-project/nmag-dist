#!/bin/bash

HLIB_TARBALL_DIR="$1"
CANDIDATES="$HLIB_TARBALL_DIR/*.tar.gz"
SHOW_WELCOME="yes"
WARN_USER="no"
for CANDIDATE in $CANDIDATES; do
  if [ ! -f $CANDIDATE ]; then
    exit 1 # this exit status means: 'do not try to configure/make HLib'
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
  if [ "x$ANSWER" == xyes -o "x$ANSWER" == xy ]; then
    tar xzvf $CANDIDATE
    rm -rf hlib
    mv HLib-* hlib
    exit 0 # this exit status means: 'OK, you can configure and make'
  elif [ "x$ANSWER" != xno -a "x$ANSWER" != xn ]; then
    echo "You typed \"$ANSWER\". You should enter either \"yes\" or \"no\"."
    echo "Assuming \"no\"."
  fi

  WARN_USER="yes"
done

if [ $WARN_USER == yes ]; then
  echo
  echo
  echo "======================================================"
  echo "HLIB SUPPORT IS NOT ENABLED!"
  echo "======================================================"
  echo "Press ENTER to continue or CTRL+C to stop here."
  read
fi

exit 1 # this exit status means 'do not try to configure/make HLib'

