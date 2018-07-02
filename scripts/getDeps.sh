#!/bin/bash
# Accepts:
# $1 branch

set -e
apt-get -y update
apt-get install -y software-properties-common
#add-apt-repository ppa:ubuntugis/ubuntugis-unstable
apt-get -y update

# Deps for master (Py3/Qt5)
LC_ALL=C DEBIAN_FRONTEND=noninteractive  \
    apt-get install -y git cmake flex bison libproj-dev libgeos-dev \
    libexpat1-dev libfcgi-dev libgsl0-dev libpq-dev libqca2-dev libqca2-plugins \
    pyqt5-dev qttools5-dev qtpositioning5-dev libqt5svg5-dev libqt5webkit5-dev \
    python3-pyqt5.qtwebkit python3-pyqt5.qtsvg qt5keychain-dev \
    libqt5gui5 libqt5scripttools5 qtscript5-dev libqca-qt5-2-dev grass-dev \
    libgeos-dev libgdal-dev libqt5xmlpatterns5-dev libqt5scintilla2-dev python3-gdal python3-yaml \
    pyqt5.qsci-dev python3-pyqt5.qsci libgsl-dev txt2tags libproj-dev libqwt-qt5-dev \
    libspatialindex-dev pyqt5-dev-tools qttools5-dev-tools qt5-default python3-future \
    python3-pyqt5.qtsql python3-psycopg2 lighttpd locales pkg-config poppler-utils python3-dev \
    python3-pyqt5 pyqt5.qsci-dev python3-pyqt5.qtsql spawn-fcgi xauth xfonts-100dpi \
    xfonts-75dpi xfonts-base xfonts-scalable xvfb vim supervisor expect python3-setuptools \
    python3-dev python3-owslib libzip-dev python3-pip python3-dev \
    libqt5serialport5 libqt5serialport5-dev


    pip3 install -r /usr/local/requirements.txt

    chmod -R a+w /usr/lib/x86_64-linux-gnu/qt5/plugins/designer/
    chmod -R a+w /usr/lib/python3/dist-packages/PyQt5/uic/widget-plugins/
