#! /bin/sh
# This file patches the OCaml configure script to:
# - avoid the X11 dependency;
# - adjust the compilation under Intel Mac OS X: shared libraries
#   are not built with OCaml < 3.9.3
# Matteo Franchin, 16 Mar 2007
cp configure original.configure && \
sed -e 's/otherlibraries="$otherlibraries graph"/otherlibraries="$otherlibraries"/g' \
    -e 's/powerpc-apple-darwin/*-apple-darwin/g' original.configure > configure
