#!/bin/sh

NMAG_WEBSITE_DEPS="http://nmag.soton.ac.uk/nmag/0.2/install/install_a.html"

GREP_Q_I="grep -q -i"
ECHO="echo"
STOP="exit 1"

DEBIAN_LIKE=no
ETC_ISSUE=/etc/issue
DPKG_ARCHITECTURE=dpkg-architecture

# Communicate that we are about to do some tests
$ECHO "Checking dependencies..."

# First, we check for Debian and the Multiarch problem.
PLEASE_CHECK_DEPS="A list of all the packages required in order\
 to compile Nmag is available at $NMAG_WEBSITE_DEPS. We cannot\
 detect all of them. If you want to continue\
 anyway you can try 'make anyway'."

$GREP_Q_I -i Ubuntu $ETC_ISSUE >/dev/null 2>&1 && DEBIAN_LIKE=yes
$GREP_Q_I -q -i Debian $ETC_ISSUE >/dev/null 2>&1 && DEBIAN_LIKE=yes

if test "$DEBIAN_LIKE" = "yes"; then
  echo "Debian-like system: checking multiarch settings..."
  $DPKG_ARCHITECTURE >/dev/null 2>/dev/null || \
    { $ECHO "Error: cannot find the executable dpkg-architecture, which is" \
      "necessary to compile Nmag in Debian or Ubuntu. Please, install the " \
      "package dpkg-dev with your package manager if this is a " \
      "Debian or Ubuntu system. Otherwise:" \
      "$PLEASE_CHECK_DEPS"; $STOP; }

else
  $ECHO "It looks as if this is neither Debian nor Ubuntu..."
fi

# Now we check for other requirements
$ECHO "Checking required executables..."

NOT_FOUND="not found, error! $PLEASE_CHECK_DEPS"

cc --version >/dev/null 2>/dev/null || { $ECHO "cc $NOT_FOUND"; $STOP; }
c++ --version >/dev/null 2>/dev/null || { $ECHO "c++ $NOT_FOUND"; $STOP; }
bash --version >/dev/null 2>/dev/null || { $ECHO "bash $NOT_FOUND"; $STOP; }
gawk --version >/dev/null 2>/dev/null || { $ECHO "gawk $NOT_FOUND"; $STOP; }
m4 --version >/dev/null 2>/dev/null || { $ECHO "m4 $NOT_FOUND"; $STOP; }
patch --version >/dev/null 2>/dev/null || { $ECHO "patch $NOT_FOUND"; $STOP; }

$ECHO "Preliminary checks were successfully completed."
