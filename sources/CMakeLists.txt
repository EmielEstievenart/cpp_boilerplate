add_library(boilerplate
	boilerplate.cpp
	private_header.hpp
)

target_include_directories(
	boilerplate
	PUBLIC
	../include
	PRIVATE
	.
)