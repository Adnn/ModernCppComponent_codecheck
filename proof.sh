#/bin/sh

set -e

##
## Prerequisite: get the path to a boost installation
##
WORKDIR=tmp_todel
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
conan install boost/1.75.0@ -g cmake_paths
BOOST_ROOT=$(cat conan_paths.cmake | sed -ne 's/set(CONAN_BOOST_ROOT "\(.*\)")/\1/p')
echo Boost installation path: ${BOOST_ROOT}
echo
popd

rm -r ${WORKDIR}

##
## Build the demo repository
##
WORKDIR=build
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
BUILD_DIR=$(pwd)
cmake .. -C ../64bit.cmake -DBUILD_tests=ON -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/SDK/myrepository -DBoost_ROOT=${BOOST_ROOT}
cmake --build . --config Release --target install
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
cmake ../downstream -C ../64bit.cmake -DCMAKE_PREFIX_PATH=${BUILD_DIR} -DBoost_ROOT=${BOOST_ROOT}
cmake --build . --config Release
popd

# From install tree
WORKDIR=build-downstream-install
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
cmake ../downstream -C ../64bit.cmake -DCMAKE_PREFIX_PATH=${BUILD_DIR}/SDK/myrepository -DBoost_ROOT=${BOOST_ROOT}
cmake --build . --config Release
popd
