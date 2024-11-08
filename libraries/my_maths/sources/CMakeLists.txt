set(INCLUDES
	../includes/my_maths/my_maths.hpp
)

set(SOURCES
	my_maths.cpp
)

add_library(my_maths
	${SOURCES}
	${INCLUDES}
)

target_include_directories(my_maths
	PUBLIC
	../includes
	PRIVATE
	../includes/my_maths
)

source_group(TREE ${CMAKE_CURRENT_SOURCE_DIR} FILES ${SOURCES})
source_group(includes FILES ${INCLUDES})
