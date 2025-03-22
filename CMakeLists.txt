cmake_minimum_required(VERSION 3.15)
project(cpp_boilerplate LANGUAGES CXX)

set(CMAKE_HELPER_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

list(PREPEND CMAKE_MODULE_PATH "${CMAKE_HELPER_DIRECTORY}")

# GoogleTest requires at least C++14
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

#This is required to use the folders in Visual Studio

add_subdirectory(cpp_boilerplate)
add_subdirectory(libraries)

option(USE_UNIT_TESTS "Build tests" ON)
if(USE_UNIT_TESTS)
    add_subdirectory(tests/unit_tests)
endif()

include(cppcheck REQUIRED)
target_add_cppcheck(TARGET cpp_boilerplate NUMBER_OF_THREADS 4 SUPPRESSIONS "missingIncludeSystem" EXTRA_COMMANDS "--template=gcc" "--verbose" "--inline-suppr" "--inconclusive" "--check-level=exhaustive" "--enable=all" "--inconclusive" "--force" --file-filter=*sources/code* "--checkers-report=${CMAKE_SOURCE_DIR}/tests/cppcheck/cppcheck-report.txt")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT cpp_boilerplate)
set_target_properties(cpp_boilerplate PROPERTIES VS_DEBUGGER_WORKING_DIRECTORY $(OutDir))

set_target_properties(my_maths PROPERTIES FOLDER libraries)
