add_library(boilerplate
	boilerplate.cpp
	private_header.hpp
)

target_add_include_directories(
	boilerplate
	PUBLIC
	../includes
)