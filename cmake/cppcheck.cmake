function(list_to_string)
    cmake_parse_arguments("LIST_TO_STRING" "" "PREFIX;OUTPUT" "LIST" ${ARGN})

    #print out the arguments
    message("LIST_TO_STRING_PREFIX: ${LIST_TO_STRING_PREFIX}")
    message("LIST_TO_STRING_OUTPUT: ${LIST_TO_STRING_OUTPUT}")
    message("LIST_TO_STRING_LIST: ${LIST_TO_STRING_LIST}")

    list(TRANSFORM LIST_TO_STRING_LIST PREPEND "${LIST_TO_STRING_PREFIX}")

    set(LIST_TO_STRING_TEMP "")
    list(JOIN LIST_TO_STRING_LIST " " LIST_TO_STRING_TEMP)
    string(REPLACE "\"" "" LIST_TO_STRING_TEMP "${LIST_TO_STRING_TEMP}")

    set(${LIST_TO_STRING_OUTPUT} ${LIST_TO_STRING_TEMP} PARENT_SCOPE)
endfunction()

function(target_add_cppcheck)
    cmake_parse_arguments("TARGET_ADD_CPPCHECK" "" "TARGET;NUMBER_OF_THREADS" "SUPPRESSIONS;IGNORE_FOLDERS;DEFINES;EXTRA_COMMANDS" ${ARGN})

    #print out the arguments
    message("TARGET_ADD_CPPCHECK_TARGET: ${TARGET_ADD_CPPCHECK_TARGET}")
    message("TARGET_ADD_CPPCHECK_NUMBER_OF_THREADS: ${TARGET_ADD_CPPCHECK_NUMBER_OF_THREADS}")
    message("TARGET_ADD_CPPCHECK_SUPPRESSIONS: ${TARGET_ADD_CPPCHECK_SUPPRESSIONS}")
    message("TARGET_ADD_CPPCHECK_IGNORE_FOLDERS: ${TARGET_ADD_CPPCHECK_IGNORE_FOLDERS}")
    message("TARGET_ADD_CPPCHECK_DEFINES: ${TARGET_ADD_CPPCHECK_DEFINES}")
    message("TARGET_ADD_CPPCHECK_EXTRA_COMMANDS: ${TARGET_ADD_CPPCHECK_EXTRA_COMMANDS}")

    #create a string from the suppressions
    list_to_string(PREFIX "--suppress=" OUTPUT "TARGET_ADD_CPPCHECK_SUPPRESSIONS_STRING" LIST ${TARGET_ADD_CPPCHECK_SUPPRESSIONS})

    #create a string from the ignore folders
    list_to_string(PREFIX "-i${CMAKE_SOURCE_DIR}/" OUTPUT "TARGET_ADD_CPPCHECK_IGNORE_FOLDERS_STRING" LIST ${TARGET_ADD_CPPCHECK_IGNORE_FOLDERS})

    #create a string from the defines
    list_to_string(PREFIX "-D" OUTPUT "TARGET_ADD_CPPCHECK_DEFINES_STRING" LIST ${TARGET_ADD_CPPCHECK_DEFINES})

    #create a string from the extra commands
    list_to_string(PREFIX "" OUTPUT "TARGET_ADD_CPPCHECK_EXTRA_COMMANDS_STRING" LIST ${TARGET_ADD_CPPCHECK_EXTRA_COMMANDS})

    #Only if the generator is a Visual Studio generator
    if(CMAKE_GENERATOR MATCHES "Visual Studio")
        set(CPPCHECK_COMMAND
            "cppcheck -j${TARGET_ADD_CPPCHECK_NUMBER_OF_THREADS} --project=${CMAKE_BINARY_DIR}/${TARGET_ADD_CPPCHECK_TARGET}.sln --cppcheck-build-dir=cppcheck ${TARGET_ADD_CPPCHECK_SUPPRESSIONS_STRING} ${TARGET_ADD_CPPCHECK_IGNORE_FOLDERS_STRING} ${TARGET_ADD_CPPCHECK_DEFINES_STRING} ${TARGET_ADD_CPPCHECK_EXTRA_COMMANDS_STRING}"
        )
    else()
        set(CPPCHECK_COMMAND
            "cppcheck -j${TARGET_ADD_CPPCHECK_NUMBER_OF_THREADS} --project=compile_commands.json --cppcheck-build-dir=cppcheck ${TARGET_ADD_CPPCHECK_SUPPRESSIONS_STRING} ${TARGET_ADD_CPPCHECK_IGNORE_FOLDERS_STRING} ${TARGET_ADD_CPPCHECK_DEFINES_STRING} ${TARGET_ADD_CPPCHECK_EXTRA_COMMANDS_STRING}"
        )
    endif()

    separate_arguments(CPPCHECK_COMMAND WINDOWS_COMMAND "${CPPCHECK_COMMAND}")

    add_custom_target(
        ${TARGET_ADD_CPPCHECK_TARGET}_cppcheck
        COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/cppcheck
        COMMAND echo Running cppcheck with the following command: ${CPPCHECK_COMMAND}
        COMMAND ${CPPCHECK_COMMAND}
        VERBATIM
        USES_TERMINAL
    )

    #target to delete the build folder
    add_custom_target(
        ${TARGET_ADD_CPPCHECK_TARGET}_cppcheck_clean
        COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_BINARY_DIR}/cppcheck
        VERBATIM
    )
endfunction()
