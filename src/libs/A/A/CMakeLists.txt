project(A VERSION "${CMAKE_PROJECT_VERSION}")

set(${PROJECT_NAME}_HEADERS
    accumulate.h
    FooBar.h
    is_directory.h
    sum.h
)

set(${PROJECT_NAME}_SOURCES
    accumulate.cpp
    sum.cpp
)

find_package(Boost REQUIRED COMPONENTS filesystem)

# Creates the library target
add_library(${PROJECT_NAME}
            ${${PROJECT_NAME}_HEADERS}
            ${${PROJECT_NAME}_SOURCES})

add_library(myrepo::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Defines target requirements
target_include_directories(${PROJECT_NAME}
    PUBLIC
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>"
    INTERFACE
        "$<INSTALL_INTERFACE:include/${PROJECT_NAME}>")

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        Boost::filesystem
    INTERFACE
        myrepo::B)

# Defines target properties
set_target_properties(${PROJECT_NAME}
    PROPERTIES
        VERSION "${${PROJECT_NAME}_VERSION}")

install(TARGETS ${PROJECT_NAME} EXPORT ${PROJECT_NAME}Targets)
install(FILES ${${PROJECT_NAME}_HEADERS}
        DESTINATION include/${PROJECT_NAME}/${PROJECT_NAME})

# build tree
export(EXPORT ${PROJECT_NAME}Targets
       FILE ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Targets.cmake
       NAMESPACE myrepo::)
configure_file(${CMAKE_SOURCE_DIR}/cmake/PackageConfig.cmake.in
               ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
               @ONLY)
if(PROJECT_VERSION)
    include(CMakePackageConfigHelpers)
    set(_version_file ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake)
    write_basic_package_version_file(${_version_file}
        VERSION ${PROJECT_VERSION}
        COMPATIBILITY AnyNewerVersion)
endif()

# install tree
install(EXPORT ${PROJECT_NAME}Targets
        FILE ${PROJECT_NAME}Targets.cmake
        DESTINATION lib/cmake/${PROJECT_NAME}
        NAMESPACE myrepo::)
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
              ${_version_file}
        DESTINATION lib/cmake/${PROJECT_NAME})
