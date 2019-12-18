project(tests)

set(${PROJECT_NAME}_HEADERS
)

set(${PROJECT_NAME}_SOURCES
    main.cpp
)

add_executable(${PROJECT_NAME}
               ${${PROJECT_NAME}_HEADERS}
               ${${PROJECT_NAME}_SOURCES})

# Only build specifications, no usage requirements: it is not a library
target_include_directories(${PROJECT_NAME}
    PRIVATE
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>")

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        myrepo::beta)
