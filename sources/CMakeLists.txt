set(SOURCES
	code/main.cpp
)

set(RESOURCES
	resources/some_data.txt
)

set(INCLUDES

)

add_executable(hello_world
	${SOURCES}
	${RESOURCES}
	${INCLUDES}
)

target_include_directories(hello_world
	PUBLIC
	../includes
	PRIVATE
	code
)

target_link_libraries(hello_world
	PUBLIC
	my_maths
)

set_target_properties(hello_world
	PROPERTIES
	RESOURCE ${RESOURCES}
)

add_custom_command(
	TARGET hello_world
	POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E make_directory
			$<TARGET_FILE_DIR:hello_world>/resources
	COMMAND ${CMAKE_COMMAND} -E copy_directory
		${CMAKE_CURRENT_SOURCE_DIR}/resources
		$<TARGET_FILE_DIR:hello_world>/resources
)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES} ${RESOURCES})
source_group( FILES ${SOURCES} ${RESOURCES})

