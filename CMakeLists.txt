#   Copyright (C) 2011-2013  Povilas Kanapickas <povilas@radix.lt>
#
#   Distributed under the Boost Software License, Version 1.0.
#       (See accompanying file LICENSE_1_0.txt or copy at
#           http://www.boost.org/LICENSE_1_0.txt)

cmake_minimum_required(VERSION 3.5.0)
project(libsimdpp)
include(cmake/version.cmake)

set(PKG_NAME "${CMAKE_PROJECT_NAME}")
set(PKG_FULL_NAME "${CMAKE_PROJECT_NAME}-${PROJECT_VERSION}")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
# ------------------------------------------------------------------------------
# Custom make dist target. Assumes source directory is a git repository.

# ------------------------------------------------------------------------------
# Check what instruction sets the current host supports. Use them for testing
include(SimdppMultiarch)
message(STATUS "Checking instruction set support in the compiler...")
simdpp_get_compilable_archs(COMPILABLE_ARCHS)
message(STATUS "Checking instruction sets to run tests for on this host...")
simdpp_get_runnable_archs(NATIVE_ARCHS)
# ------------------------------------------------------------------------------
add_library(simdpp INTERFACE)
target_include_directories(simdpp INTERFACE
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    $<INSTALL_INTERFACE:include>
)
list(APPEND lib_targets simdpp)
# set(SIMDPP_INCLUDEDIR "${CMAKE_INSTALL_PREFIX}/include/${PKG_NAME}-${SIMDPP_API_VERSION}")
set(SIMDPP_DOCDIR "${CMAKE_INSTALL_PREFIX}/share/doc/${PKG_NAME}")

enable_testing()
# add_subdirectory(simdpp)
include(cmake/header_tests.cmake)
add_subdirectory(test)
include(cmake/install.cmake)

