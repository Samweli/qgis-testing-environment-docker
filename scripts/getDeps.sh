#!/bin/bash

set -e

pip3 install -r /usr/local/requirements.txt

# Add OpenCL develompent files and supervisor
LC_ALL=C DEBIAN_FRONTEND=noninteractive  \
    apt-get install -y opencl-headers ocl-icd-libopencl1 ocl-icd-opencl-dev \
    supervisor expect


#chmod -R a+w /usr/lib/x86_64-linux-gnu/qt5/plugins/designer/
#chmod -R a+w /usr/lib/python3/dist-packages/PyQt5/uic/widget-plugins/
