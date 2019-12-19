# CMake initialisation
cmake_minimum_required(VERSION 3.15)

# Setting the VERSION on root project() will populate CMAKE_PROJECT_VERSION
project(Downstream
        VERSION "${BUILD_VERSION}")

# Common build settings
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

# Include components
add_subdirectory(src)
