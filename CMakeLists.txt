cmake_minimum_required(VERSION 3.15)
project(cpp_boilerplate LANGUAGES CXX)

set(CMAKE_HELPER_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

list(PREPEND CMAKE_MODULE_PATH "${CMAKE_HELPER_DIRECTORY}")

# GoogleTest requires at least C++14
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#This is required to use the folders in Visual Studio

add_subdirectory(sources)
add_subdirectory(libraries)

option(USE_UNIT_TESTS "Build tests" ON)
if(USE_UNIT_TESTS)
    add_subdirectory(tests/unit_tests)
endif()

#For some reason, Cppcheck uses relative paths to detect when to ignore stuff from buildcommands.json, but absolute paths when parsing VS projects.
if(CMAKE_GENERATOR MATCHES "Visual Studio")
    set(GOOGLETEST_IGNORE_DIR "-i${CMAKE_BINARY_DIR}/_deps")
else()
    set(GOOGLETEST_IGNORE_DIR "-i_deps")
endif()

message("GOOGLETEST_IGNORE_DIR: ${GOOGLETEST_IGNORE_DIR}" )

include(cppcheck REQUIRED)
target_add_cppcheck(TARGET cpp_boilerplate NUMBER_OF_THREADS 4 SUPPRESSIONS "missingIncludeSystem" EXTRA_COMMANDS "--template=gcc" "--verbose" "--inline-suppr" "--inconclusive" "--check-level=exhaustive" "--enable=all" "--inconclusive" "--force" ${GOOGLETEST_IGNORE_DIR} "--checkers-report=cppcheck-report.txt")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT cpp_boilerplate)
set_target_properties(cpp_boilerplate PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY $(OutDir))

set_target_properties(my_maths PROPERTIES FOLDER libraries)
