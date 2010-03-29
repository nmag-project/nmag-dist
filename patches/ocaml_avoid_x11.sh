#! /bin/sh
cp configure original.configure && \
sed 's/otherlibraries="$otherlibraries graph"/otherlibraries="$otherlibraries"/g' original.configure > configure
