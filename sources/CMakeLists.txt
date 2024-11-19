set(SOURCES
	code/cpp_boilerplate/main.cpp
)

set(RESOURCES
	resources/some_data.txt
)

set(INCLUDES

)

add_executable(cpp_boilerplate
	${SOURCES}
	${RESOURCES}
	${INCLUDES}
)

target_include_directories(cpp_boilerplate
	PUBLIC
	../includes
	PRIVATE
	code
)

target_link_libraries(cpp_boilerplate
	PUBLIC
	my_maths
)

set_target_properties(cpp_boilerplate
	PROPERTIES
	RESOURCE ${RESOURCES}
)

add_custom_command(
	TARGET cpp_boilerplate
	POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E make_directory
			$<TARGET_FILE_DIR:cpp_boilerplate>/resources
	COMMAND ${CMAKE_COMMAND} -E copy_directory
		${CMAKE_CURRENT_SOURCE_DIR}/resources
		$<TARGET_FILE_DIR:cpp_boilerplate>/resources
)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES} ${RESOURCES})

