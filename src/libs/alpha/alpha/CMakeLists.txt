project(alpha VERSION "${CMAKE_PROJECT_VERSION}")

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

# Hack: hardcode a value to find Boost on Windows
if (CMAKE_SYSTEM_NAME MATCHES Windows)
    set(Boost_USE_STATIC_LIBS ON)
endif()
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
        Boost::disable_autolinking
    INTERFACE
        myrepo::beta)

# Defines target properties
set_target_properties(${PROJECT_NAME}
    PROPERTIES
        VERSION "${${PROJECT_NAME}_VERSION}")
