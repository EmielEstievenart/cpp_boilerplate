set(SOURCES
	my_maths.cpp
	../includes/my_maths/my_maths.hpp
)

add_library(my_maths
	${SOURCES}
)

target_include_directories(my_maths
	PUBLIC
	../includes
	PRIVATE
	../includes/my_maths

)