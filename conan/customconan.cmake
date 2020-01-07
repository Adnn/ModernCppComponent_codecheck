# Made a function to avoid leaking the variables defined within conanbuildinfo.cmake
function(conan_handle_compiler_settings)
    include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)

    if(CONAN_EXPORTED)
        conan_message(STATUS "Conan: called by CMake conan helper")
    endif()

    if(CONAN_IN_LOCAL_CACHE)
        conan_message(STATUS "Conan: called inside local cache")
    endif()

    check_compiler_version()
    conan_set_std()
    conan_set_libcxx()
    conan_set_vs_runtime()
endfunction()

include(${CMAKE_BINARY_DIR}/conan_paths.cmake)
conan_handle_compiler_settings()
