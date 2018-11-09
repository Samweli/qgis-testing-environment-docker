FROM qgis/qgis3-build-deps:latest
MAINTAINER Alessandro Pasotti <elpaso@itopen.it>

################################################################################
# build arguments: branch, repository, number of cores for -j build argument

ARG QGIS_BRANCH=master
# Note: do not use git but https here!
ARG QGIS_REPOSITORY=https://github.com/qgis/QGIS.git
ARG CPU_CORES=2


################################################################################
# QGIS build

# Add install script for testing environment python packages
# This is not directly related to QGIS build but the installation
# will be handled by getDeps script
ADD resources/requirements.txt /usr/local/requirements.txt

COPY scripts /build/scripts

# Install dependencies and git clone the repo and Make it
RUN /build/scripts/getDeps.sh \
   && echo "Cloning ${QGIS_BRANCH} from ${QGIS_REPOSITORY} ..." \
   && cd /build \
   && git clone --depth 1 -b ${QGIS_BRANCH} ${QGIS_REPOSITORY} \
   && /build/scripts/make.sh ${CPU_CORES}


################################################################################
# Testing environment setup

# Add QGIS test runner
ADD resources/test_runner/qgis_*.* /usr/bin/

# Make all scripts executable
RUN chmod +x /usr/bin/qgis_*

# Add supervisor service configuration script
ADD resources/supervisor/supervisord.conf /etc/supervisor/
ADD resources/supervisor/supervisor.xvfb.conf /etc/supervisor/supervisor.d/

# This paths are for
# - kartoza images (compiled)
# - deb installed
# - built from git
# needed to find PyQt wrapper provided by QGIS
ENV PYTHONPATH=/usr/share/qgis/python/:/usr/lib/python3/dist-packages/qgis:/usr/share/qgis/python/qgis

# Remove some unnecessary files
RUN /build/scripts/clean.sh ${QGIS_BRANCH}

# Run supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
