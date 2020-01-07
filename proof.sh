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
cmake .. -DBUILD_tests=ON -DCMAKE_INSTALL_PREFIX=${BUILD_DIR}/SDK/myrepository -DBoost_ROOT=${BOOST_ROOT}
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
cmake ../downstream -DCMAKE_PREFIX_PATH=${BUILD_DIR} -DBoost_ROOT=${BOOST_ROOT}
cmake --build .
popd

# From install tree
WORKDIR=build-downstream-install
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
cmake ../downstream -DCMAKE_PREFIX_PATH=${BUILD_DIR}/SDK/myrepository -DBoost_ROOT=${BOOST_ROOT}
cmake --build .
popd

##
## Usage
##
# Development: satisfy upstream dependencies with Conan
WORKDIR=build-dev
mkdir -p ${WORKDIR}
rm -r ${WORKDIR}
mkdir -p ${WORKDIR}

pushd ${WORKDIR}
local_sdk_folder=$(pwd)/SDK

conan install ../conan
cmake -DCMAKE_PROJECT_MyRepository_INCLUDE=conan/customconan.cmake \
      -DCMAKE_INSTALL_PREFIX=${local_sdk_folder}/beneficialproject \
      ..
cmake --build . --target install
popd

# Development: Export the recipe, build a package and test it (with customconan.cmake)
conan create ./conan 0.0.0@user/testing
conan remove myrepository/0.0.0@user/testing -f

# Development: Export the recipe, build a package and test it (with default conanbuildinfo.cmake)
conan create ./conan 0.0.0@user/testing -tf test_package_default
# Note: recipe is removed later, it is used by a subsequent step

# Command-line usage
conan install myrepository/0.0.0@user/testing
conan install --build myrepository myrepository/0.0.0@user/testing # Should trigger rebuild

# Removal of the recipe
conan remove myrepository/0.0.0@user/testing -f
