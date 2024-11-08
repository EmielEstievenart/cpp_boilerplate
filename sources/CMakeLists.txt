set(SOURCES
	code/boilerplate.cpp
	code/private_header.hpp
)

add_executable(boilerplate
	${SOURCES}
)

target_include_directories(boilerplate
	PUBLIC
	../includes
	PRIVATE
	code
)