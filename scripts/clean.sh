#!/bin/bash
# Accepts:
# $1 branch

set -e

# Keep python dev and other libs we need to build psutils for reporting plugin
dpkg --purge `dpkg -l "*-dev" | egrep -v 'libexpat|python' | sed -ne 's/ii  \(.*-dev\(:amd64\)\?\) .*/\1/p'` || true

# Clean for master (Py3/Qt5)
apt-get remove -y libqt4* libgtk* libsane gfortran-5 *gnome* \
    libsane *pango* glib* *gphoto*

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /build
