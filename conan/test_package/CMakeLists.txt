cmake_minimum_required(VERSION 2.8.12)
project(PackageTest CXX)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY $<1:${CMAKE_CURRENT_BINARY_DIR}>)

find_package(MyRepository REQUIRED COMPONENTS A)

add_executable(example example.cpp)
target_link_libraries(example myrepo::A)
