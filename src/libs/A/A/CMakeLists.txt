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
