# This file is part of c-ares project.
add_library(ares_options INTERFACE)

target_compile_options(ares_options INTERFACE
    # GCC/Clang options
    $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:
        -Wall
        -Wextra # more strict warnings
        -Wpedantic # enforce strict ISO C and ISO C++ compliance
        -fno-strict-aliasing # disable strict aliasing optimizations
    >    
)

target_compile_options(ares_options INTERFACE
    $<$<AND:$<PLATFORM_ID:Linux>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:
        # generate position-independent code
        -fPIC
)

target_link_options(ares_options INTERFACE
    $<$<AND:$<PLATFORM_ID:Linux>,$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>>:
        # open stack backtrace
        -rdynamic
    >
)

target_compile_definitions(ares_options INTERFACE
    $<$<CONFIG:Debug>:
        ARES_DEBUG>
    # to avoid the "DEBUG" used by MSVC, we use ARES_DEBUG instead of DEBUG
)

target_compile_options(ares_options INTERFACE
    $<$<CONFIG:Debug>: -O0>
    $<$<CONFIG:Debug>: -g3>
    $<$<CONFIG:Debug>: -ggdb>
)

# ===== Release/RelWithDebInfo build options =====
target_compile_options(ares_options INTERFACE
    $<$<CONFIG:Release>: -DNDEBUG>
    $<$<CONFIG:Release>: -O2>
    $<$<CONFIG:Release>: -fno-omit-frame-pointer>
    
    $<$<CONFIG:RelWithDebInfo>: -DNDEBUG>    
    $<$<CONFIG:RelWithDebInfo>: -O2>
    $<$<CONFIG:RelWithDebInfo>: -g>
    $<$<CONFIG:RelWithDebInfo>: -fno-omit-frame-pointer>
)

# coverage
option(ENABLE_COVERAGE "Enable code coverage instrumentation" OFF)
if(ENABLE_COVERAGE)
    target_compile_options(ares_options INTERFACE
        $<$<CONFIG:Debug>: --coverage>
    )
    target_link_options(ares_options INTERFACE
        $<$<CONFIG:Debug>: --coverage>
    )
endif()