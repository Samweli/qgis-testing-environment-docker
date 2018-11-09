#!/bin/bash
# Accepts:
# $1 CPU_CORES

set -e

CPU_CORES=${1:-2}

mkdir /build/release
cd /build/release

CMAKE_EXTRA_ARGS=""

# Build for master (Py3/Qt5)

cmake \
    -GNinja \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_TESTING=OFF \
    -DENABLE_TESTS=FALSE \
    -DUSE_CCACHE=OFF \
    -DWITH_QUICK=OFF \
    -DWITH_3D=ON \
    -DWITH_STAGED_PLUGINS=ON \
    -DWITH_GRASS=OFF \
    -DSUPPRESS_QT_WARNINGS=ON \
    -DWITH_QSPATIALITE=ON \
    -DWITH_QWTPOLAR=OFF \
    -DWITH_APIDOC=OFF \
    -DWITH_ASTYLE=OFF \
    -DWITH_DESKTOP=ON \
    -DWITH_BINDINGS=ON \
    -DWITH_SERVER=ON \
    -DDISABLE_DEPRECATED=ON \
    -DWERROR=TRUE \
    /build/QGIS

ninja -j ${CPU_CORES} install

ldconfig

strip `find /usr/lib/ -name "libqgis*" -type f`
strip `find  /usr/share/qgis/ -name "*.so" -type f`
