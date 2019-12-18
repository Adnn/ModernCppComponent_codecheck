#/bin/sh

set -e

##
## Build the demo repository
##
WORKDIR=build
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd build
cmake .. -DBUILD_tests=ON
cmake --build .
popd
