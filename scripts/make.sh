#!/bin/bash
# Accepts:
# $1 branch

set -e

mkdir /build/release
cd /build/release

CMAKE_EXTRA_ARGS=""

# Build for master (Py3/Qt5)
cmake /build/QGIS \
    -DPYTHON_VER=3 \
    -DWITH_GRASS=ON \
    -DWITH_GRASS7=ON \
    -DQWT_INCLUDE_DIR=/usr/include/qwt \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DPYTHON_LIBRARY=/usr/lib/x86_64-linux-gnu/libpython3.6m.so \
    -DQSCINTILLA_INCLUDE_DIR=/usr/include/x86_64-linux-gnu/qt5/ \
    -DQSCINTILLA_LIBRARY=/usr/lib/libqscintilla2_qt5.so \
    -DWITH_QWTPOLAR=OFF \
    -DWITH_SERVER=OFF \
    -DBUILD_TESTING=OFF \
    -DENABLE_TESTS=OFF \
    -DWITH_INTERNAL_QWTPOLAR=ON

make install -j16
ldconfig

strip `find /usr/lib/ -name "libqgis*" -type f`
strip `find  /usr/share/qgis/ -name "*.so" -type f`
