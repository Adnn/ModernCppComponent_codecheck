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

function(local_find)
    set (REQUIRED "REQUIRED")
    set (QUIET "QUIET")
    set (find_package "find_package")
    configure_file(CMakeFinds.cmake.in CMakeFinds.cmake @ONLY)
    include(${CMAKE_CURRENT_BINARY_DIR}/CMakeFinds.cmake)
endfunction()
local_find()

set(${PROJECT_NAME}_INTERNAL_INTERFACE_DEPENDENCIES
    B)

function(config_find)
    set (find_package "find_dependency")
    configure_file(CMakeFinds.cmake.in ${CMAKE_BINARY_DIR}/${PROJECT_NAME}FindUpstream.cmake @ONLY)

    list(JOIN ${PROJECT_NAME}_INTERNAL_INTERFACE_DEPENDENCIES " " _joined_components)
    set(FIND_INTERNAL_COMPONENTS
        "find_dependency(${CMAKE_PROJECT_NAME} CONFIG COMPONENTS ${_joined_components})")
    configure_file(${CMAKE_SOURCE_DIR}/cmake/PackageConfig.cmake.in
                   ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
                   @ONLY)
endfunction()
config_find()

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

list(TRANSFORM ${PROJECT_NAME}_INTERNAL_INTERFACE_DEPENDENCIES PREPEND myrepo::)
target_link_libraries(${PROJECT_NAME}
    PUBLIC
        Boost::filesystem
    INTERFACE
        ${${PROJECT_NAME}_INTERNAL_INTERFACE_DEPENDENCIES})

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

# install tree
install(EXPORT ${PROJECT_NAME}Targets
        FILE ${PROJECT_NAME}Targets.cmake
        DESTINATION lib/cmake/${CMAKE_PROJECT_NAME}
        NAMESPACE myrepo::)
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        ${CMAKE_BINARY_DIR}/${PROJECT_NAME}FindUpstream.cmake
        DESTINATION lib/cmake/${CMAKE_PROJECT_NAME})
