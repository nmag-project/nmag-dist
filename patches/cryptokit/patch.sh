#!/bin/sh
ORIG=$1/Makefile
TMP=/tmp/cryptokit_Makefile
sed 's|-L$(ZLIB_LIBDIR)||g' $ORIG > $TMP && rm -f $ORIG && mv $TMP $ORIG
