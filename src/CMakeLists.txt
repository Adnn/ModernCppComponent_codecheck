add_subdirectory(libs/alpha/alpha)
add_subdirectory(libs/beta/beta)

add_subdirectory(apps/gamma/gamma)

option(BUILD_tests "Build switch for 'tests' application")
if (BUILD_tests)
    add_subdirectory(apps/tests/tests)
endif()
