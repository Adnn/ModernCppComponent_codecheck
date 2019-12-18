project(B VERSION "${CMAKE_PROJECT_VERSION}")

set(${PROJECT_NAME}_HEADERS
    multiply.h
)

# Creates the library target
add_library(${PROJECT_NAME} INTERFACE)

add_library(myrepo::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

# Custom target to show source files in IDEs
add_custom_target(${PROJECT_NAME}_ide
                  SOURCES ${${PROJECT_NAME}_HEADERS})

# Defines target requirements
target_include_directories(${PROJECT_NAME}
    INTERFACE
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>"
        "$<INSTALL_INTERFACE:include/${PROJECT_NAME}>")
