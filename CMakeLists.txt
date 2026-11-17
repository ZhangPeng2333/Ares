# Define the minimum version of CMake required to build the project
cmake_minimum_required(VERSION 3.22)

# Set the C and C++ compilers to use GCC and G++
set(CMAKE_C_COMPILER "/usr/bin/gcc" CACHE FILEPATH "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "/usr/bin/g++" CACHE FILEPATH "C++ compiler" FORCE)

# Set the C++ standard to C++20 and enforce it
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

# Define the project name and version
project(Ares 
VERSION 1.0.0
        DESCRIPTION "Ares Project"
        LANGUAGES CXX C)

# Include the GNUInstallDirs module to handle installation directories
include(GNUInstallDirs)
# Include the CMakePackageConfigHelpers module to assist with package configuration
include(CMakePackageConfigHelpers)# find_package(Ares)...

# Define options for building examples, tests, and tools
option(ARES_BUILD_EXAMPLES  "Build examples"    ON)
option(ARES_BUILD_TESTS     "Build tests"       ON)
option(ARES_BUILD_TOOLS     "Build tools"       ON)

# Set the default build type to Debug if no configuration types or build type is specified
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
endif()
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release RelWithDebInfo MinSizeRel)
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")

# Set the default number of parallel jobs for the build process based on the number of logical CPU cores
cmake_host_system_information(RESULT CPU_NUMS QUERY NUMBER_OF_LOGICAL_CORES)
message(STATUS "CPU NUMS on current server is: ${CPU_NUMS}")
math(EXPR JOBS "${CPU_NUMS} + ${CPU_NUMS} / 2")
message(STATUS "Compiler default work jobs: ${CMAKE_BUILD_PAPALLEL_LEVEL}")

include(cmake/aresOptions.cmake)

add_subdirectory(ares)
if(ARES_BUILD_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()
if(ARES_BUILD_TOOLS)
    add_subdirectory(tools)
endif()