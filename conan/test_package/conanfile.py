import os

from conans import ConanFile, CMake, tools


class MyRepositoryTestConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake_paths", "cmake"

    build_requires = "cmake/3.15.7"

    def build(self):
        cmake = CMake(self)
        cmake.definitions["CMAKE_PROJECT_PackageTest_INCLUDE"] = "../customconan.cmake"
        cmake.configure()
        cmake.build()

    def imports(self):
        self.copy("*.dll", dst="bin", src="bin")
        self.copy("*.dylib*", dst="bin", src="lib")
        self.copy('*.so*', dst='bin', src='lib')

    def test(self):
        if not tools.cross_building(self.settings):
            self.run(".%sexample" % os.sep)
