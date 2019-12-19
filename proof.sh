#/bin/sh

set -e

##
## Build the demo repository
##
WORKDIR=build
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
BUILD_DIR=$(pwd)
#cmake .. -DCMAKE_CXX_STANDARD=14 -DCMAKE_VERBOSE_MAKEFILE=ON
cmake .. -DBUILD_tests=ON -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/SDK/myrepository $@
cmake --build . --target install
popd

##
## Build a downstream consumer, mocking-up a separate repository
##

# From build tree
WORKDIR=build-downstream
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
cmake ../downstream -DCMAKE_PREFIX_PATH=${BUILD_DIR} $@
cmake --build .
popd

# From install tree
WORKDIR=build-downstream-install
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
cmake ../downstream -DCMAKE_PREFIX_PATH=${BUILD_DIR}/SDK/myrepository $@
cmake --build .
popd
