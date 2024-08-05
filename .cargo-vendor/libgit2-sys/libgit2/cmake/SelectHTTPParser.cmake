# Optional external dependency: http-parser
if(USE_HTTP_PARSER STREQUAL "http-parser")
	find_package(HTTPParser)

	if(HTTP_PARSER_FOUND AND HTTP_PARSER_VERSION_MAJOR EQUAL 2)
		list(APPEND LIBGIT2_SYSTEM_INCLUDES ${HTTP_PARSER_INCLUDE_DIRS})
		list(APPEND LIBGIT2_SYSTEM_LIBS ${HTTP_PARSER_LIBRARIES})
		list(APPEND LIBGIT2_PC_LIBS "-lhttp_parser")
		set(GIT_HTTPPARSER_HTTPPARSER 1)
		add_feature_info(http-parser ON "using http-parser (system)")
	else()
		message(FATAL_ERROR "http-parser support was requested but not found")
	endif()
elseif(USE_HTTP_PARSER STREQUAL "llhttp")
	find_package(LLHTTP)

	if(LLHTTP_FOUND AND LLHTTP_VERSION_MAJOR EQUAL 9)
		list(APPEND LIBGIT2_SYSTEM_INCLUDES ${LLHTTP_INCLUDE_DIRS})
		list(APPEND LIBGIT2_SYSTEM_LIBS ${LLHTTP_LIBRARIES})
		list(APPEND LIBGIT2_PC_LIBS "-lllhttp")
		set(GIT_HTTPPARSER_LLHTTP 1)
		add_feature_info(http-parser ON "using llhttp (system)")
	else()
		message(FATAL_ERROR "llhttp support was requested but not found")
	endif()
else()
	add_subdirectory("${PROJECT_SOURCE_DIR}/deps/llhttp" "${PROJECT_BINARY_DIR}/deps/llhttp")
	list(APPEND LIBGIT2_DEPENDENCY_INCLUDES "${PROJECT_SOURCE_DIR}/deps/llhttp")
	list(APPEND LIBGIT2_DEPENDENCY_OBJECTS "$<TARGET_OBJECTS:llhttp>")
	set(GIT_HTTPPARSER_BUILTIN 1)
	add_feature_info(http-parser ON "using bundled parser")
endif()
