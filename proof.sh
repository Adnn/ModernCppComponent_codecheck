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

pushd build
cmake .. -C ../64bit.cmake -DBUILD_tests=ON -DBoost_ROOT=${BOOST_ROOT}
cmake --build . --config Release
popd
