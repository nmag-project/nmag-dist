#!/bin/sh

MAIN_PATH="$1"
LIB_PATH="$MAIN_PATH/lib"

[ -f $MAIN_PATH/config.status ] || (cd $MAIN_PATH && sh configure)
. $MAIN_PATH/config.status

cd $LIB_PATH
for LIBSUNDIALS in libsundials_*.0.0.0; do
  RENAMED_LIBSUNDIALS=`basename $LIBSUNDIALS .0.0.0`$SHLIB_SUFFIX
  [ -f $LIBSUNDIALS -a ! -e $RENAMED_LIBSUNDIALS ] && $LN_S $LIBSUNDIALS $RENAMED_LIBSUNDIALS
done
