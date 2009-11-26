#!/bin/sh

MAIN_PATH="$1"
LIB_PATH="$MAIN_PATH/lib"

[ -f $MAIN_PATH/config.status ] || (cd $MAIN_PATH && sh configure)
. $MAIN_PATH/config.status

cd $LIB_PATH
for LIBSUNDIALS in libsundials_*.?.?.?; do
  RENAMED_LIBSUNDIALS=`echo $LIBSUNDIALS | cut -d . -f 1`$SHLIB_SUFFIX
  [ -f $LIBSUNDIALS -a ! -e $RENAMED_LIBSUNDIALS ] && $LN_S $LIBSUNDIALS $RENAMED_LIBSUNDIALS
done

