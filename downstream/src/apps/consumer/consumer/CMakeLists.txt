project(consumer)

set(${PROJECT_NAME}_HEADERS
)

set(${PROJECT_NAME}_SOURCES
    main.cpp
)

# Should not have to be listed, but at this point
# alpha package does not find its own dependencies
if (CMAKE_SYSTEM_NAME MATCHES Windows)
    set(Boost_USE_STATIC_LIBS ON)
endif()
find_package(MyRepository REQUIRED COMPONENTS beta)
find_package(Boost REQUIRED COMPONENTS filesystem)

find_package(MyRepository REQUIRED COMPONENTS alpha)

add_executable(${PROJECT_NAME}
               ${${PROJECT_NAME}_HEADERS}
               ${${PROJECT_NAME}_SOURCES})

# Only build specifications, no usage requirements: it is not a library
target_include_directories(${PROJECT_NAME}
    PRIVATE
        "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/../>")

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        myrepo::alpha)
