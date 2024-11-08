set(SOURCES
	code/main.cpp
)

add_executable(hello_world
	${SOURCES}
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
