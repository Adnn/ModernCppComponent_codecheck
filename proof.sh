#/bin/sh

set -e

mkdir -p build
rm -r build/*

pushd build
#cmake .. -DCMAKE_CXX_STANDARD=14 -DCMAKE_VERBOSE_MAKEFILE=ON
cmake .. -DBUILD_tests=ON
cmake --build .
popd
