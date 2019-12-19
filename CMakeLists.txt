# CMake initialisation
cmake_minimum_required(VERSION 3.15)

# Setting the VERSION on root project() will populate CMAKE_PROJECT_VERSION
project(MyRepository
        VERSION "${BUILD_VERSION}")

# Common build settings
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

# Include components
add_subdirectory(src)

# Multi-component package
# Generate the root config and version check in the build tree
configure_file(${CMAKE_SOURCE_DIR}/cmake/ComponentPackageRootConfig.cmake.in
               ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}Config.cmake
               @ONLY)
if(PROJECT_VERSION)
    include(CMakePackageConfigHelpers)
    set(_version_file ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake)
    write_basic_package_version_file(${_version_file}
        VERSION ${CMAKE_PROJECT_VERSION}
        COMPATIBILITY AnyNewerVersion)
endif()

# Install the root config file over to the install tree
install(FILES ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}Config.cmake
              ${_version_file}
        DESTINATION lib/cmake/${CMAKE_PROJECT_NAME})
