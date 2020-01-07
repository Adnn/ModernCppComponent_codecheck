from conans import ConanFile, CMake, tools

from os import path


class MyRepositoryConan(ConanFile):
    # Recipe meta-information
    name = "myrepository"
    license = "MIT"
    url = "https://github.com/Adnn/ModernCppComponent_codecheck"
    description = "A Conan recipe for {Sonat} code-check repository"
    topics = ("demonstration")

    # Which generators are run when obtaining the code dependencies
    generators = "cmake_paths", "cmake"

    # The default "hash" mode would result in different recipe revisions for Linux and Windows
    # because of difference in line endings
    revision_mode = "scm"

    # (overridable) defaults for consumers
    build_policy = "missing"

    # Package variability:
    # Changing those values will result in distinct packages for the same recipe
    settings = "os", "compiler", "build_type", "arch"
    options = {
        "shared": [True, False],
        "build_tests": [True, False],
    }
    default_options = {
        "shared": False,
        "build_tests": False,
    }

    # Code dependencies
    requires = "boost/1.70.0",

    # Build dependencies
    #   CMake will not need to be installed system-wide to build the project
    #   And if it was installed in a non-compatible version, this line will take precedence
    build_requires = "cmake/3.15.7"


    # Build procedure: code retrieval
    #   Git's repository origin remote and its current revision are captured by recipe export
    scm = {
        "type": "git",
        "url": "auto",
        "revision": "auto",
        "submodule": "recursive",
    }


    # shared CMake configuration
    def _configure_cmake(self):
        cmake = CMake(self)
        cmake.definitions["CMAKE_PROJECT_MyRepository_INCLUDE"] = \
            path.join(self.source_folder, "conan", "customconan.cmake")
        cmake.definitions["BUILD_tests"] = self.options.build_tests
        cmake.configure()
        return cmake


    # Build procedure: actual build
    def build(self):
        cmake = self._configure_cmake()
        cmake.build()


    # Packaging procedure
    def package(self):
        cmake = self._configure_cmake()
        cmake.install()


    # Package-consumer instructions
    def package_info(self):
        self.cpp_info.libs = tools.collect_libs(self)
        self.cpp_info.includedirs = ["include/alpha", "include/beta",]
