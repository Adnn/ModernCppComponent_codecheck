add_subdirectory(libs/A/A)
add_subdirectory(libs/B/B)

add_subdirectory(apps/C/C)

option(BUILD_tests "Build switch for 'tests' application")
if (BUILD_tests)
    add_subdirectory(apps/tests/tests)
endif()
