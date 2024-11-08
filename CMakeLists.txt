cmake_minimum_required(VERSION 3.15)
project(cpp_hello_world LANGUAGES CXX)

# GoogleTest requires at least C++14
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#This is required to use the folders in Visual Studio

add_subdirectory(sources)
add_subdirectory(libraries)

option(BP_BUILD_TESTS "Build tests" ON)
if(BP_BUILD_TESTS)
    add_subdirectory(tests)
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT hello_world)
set_target_properties(hello_world PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY $(OutDir))


set_target_properties(my_maths PROPERTIES FOLDER libraries)
