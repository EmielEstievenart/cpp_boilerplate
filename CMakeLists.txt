cmake_minimum_required(VERSION 3.15)
project(cpp_boilerplate LANGUAGES CXX)

# GoogleTest requires at least C++14
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#This is required to use the folders in Visual Studio
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

add_subdirectory(sources)

option(BP_BUILD_TESTS "Build tests" ON)
if(BP_BUILD_TESTS)
    add_subdirectory(tests)
endif()