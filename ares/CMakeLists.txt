file(GLOB_RECURSE ARES_SOURCES CONFIGURE_DEPENDS *.cpp *.c *.cc)
file(GLOB_RECURSE ARES_HEADERS CONFIGURE_DEPENDS *.h *.hpp)

add_library(ares STATIC ${ARES_SOURCES} ${ARES_HEADERS})

target_include_directories(
    ares
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(ares PUBLIC ares_options) # inherit options from ares_options library

target_compile_options(ares PRIVATE
    # more strict
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:
        -Werror
    >
)

install(TARGETS ares 
    EXPORT AresTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(FILES ${ARES_HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ares)
