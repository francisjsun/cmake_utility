# Copyright (C) 2021 Francis Sun, all rights reserved.

### Options
# * FS_VESTA_USE_MSVC_MD Option for whether using /MD compiler flag on MSVC

### Variables
# * FS_VESTA_BIN_NAME_SUFFIX Suffix contains infos about compiler id or x64, 
# M[DT] for MSVC 
# * FS_VESTA_PKG_(STATIC|SHARED)_LIB_FILENAME_REGEX Two REGEXs for packing 
# usage
# * FS_VESTA_GIT_HEAD_VERSION Git HEAD version

### Functions
# * fs_vesta_generate_vesta_pkg
# * fs_vesta_generate_config_h_in


cmake_minimum_required(VERSION 3.6)

set(FS_VESTA_DIR ${CMAKE_CURRENT_LIST_DIR})

# compiler flags
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wconversion -std=c++17 -pedantic -pthread")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /WX /Zc:preprocessor /std:c++17 -D_CRT_SECURE_NO_WARNINGS=1")

  # M[DT]
  option(FS_VESTA_USE_MSVC_MD "using dynamic run-time library" ON)
  if(FS_VESTA_USE_MSVC_MD)
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MD")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MDd")
  else()
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
  endif()
endif()


# predefined macro
# debug
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DFS_VESTA_DEBUG")
endif()
# os
set(FS_VESTA_OS_NAME ${CMAKE_SYSTEM_NAME})
if(UNIX)
  set(FS_VESTA_OS_PREDEFINED_MACRO "-DFS_VESTA_OS_UNIX")
if(APPLE)
  set(FS_VESTA_OS_PREDEFINED_MACRO "${FS_VESTA_OS_PREDEFINED_MACRO} -DFS_VESTA_OS_MACOS")
endif()
elseif(WIN32)
  set(FS_VESTA_OS_PREDEFINED_MACRO "-DFS_VESTA_OS_WINDOWS")
endif()

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${FS_VESTA_OS_PREDEFINED_MACRO}")


# set output directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_SOURCE_DIR}/bin)

# set output postfix for debug
set(CMAKE_DEBUG_POSTFIX d)

#set bin suffix
set(FS_VESTA_BIN_NAME_SUFFIX)
set(FS_VESTA_PKG_STATIC_LIB_FILENAME_REGEX ".*\\.a$")
set(FS_VESTA_PKG_SHARED_LIB_FILENAME_REGEX ".*\\.so$")

if(CMAKE_CXX_COMPILER_ID MATCHES ".*GNU.*")
  set(FS_VESTA_BIN_NAME_SUFFIX "_gnu")
elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang.*")
  set(FS_VESTA_BIN_NAME_SUFFIX "_clang")
  set(FS_VESTA_PKG_SHARED_LIB_FILENAME_REGEX "(.*\\.so$)|(.*\\.dylib$)")
elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*MSVC.*")
  set(FS_VESTA_BIN_NAME_SUFFIX "_msvc_${MSVC_VERSION}")
  if(CMAKE_VS_PLATFORM_NAME MATCHES ".*64.*")
    set(FS_VESTA_BIN_NAME_SUFFIX ${FS_VESTA_BIN_NAME_SUFFIX}_x64)
  endif()
  if(FS_VESTA_MSVC_MD)
    set(FS_VESTA_BIN_NAME_SUFFIX ${FS_VESTA_BIN_NAME_SUFFIX}_MD)
  else()
    set(FS_VESTA_BIN_NAME_SUFFIX ${FS_VESTA_BIN_NAME_SUFFIX}_MT)
  endif()
  set(FS_VESTA_PKG_STATIC_LIB_FILENAME_REGEX ".*\\.lib$")
  set(FS_VESTA_PKG_SHARED_LIB_FILENAME_REGEX "(.*\\.dll$)|(.*\\.lib$)")
else()
  message(FATAL_ERROR "unknown compiler id: " ${CMAKE_CXX_COMPILER_ID})
endif()


# Git HEAD version
set(FS_VESTA_GIT_UNKNOWN_VERSION "NA")
find_package(Git)
if(GIT_FOUND)
  set(FS_VESTA_GIT_HEAD_VERSION)
  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    OUTPUT_VARIABLE FS_VESTA_GIT_HEAD_VERSION
    ERROR_VARIABLE FS_VESTA_GIT_ERROR)

  if(FS_VESTA_GIT_ERROR)
    set(FS_VESTA_GIT_HEAD_VERSION ${FS_VESTA_GIT_UNKNOWN_VERSION})
  endif()
  # remove the trailing '\n' of the output variable
  string(REGEX REPLACE "\n$" "" FS_VESTA_GIT_HEAD_VERSION 
    ${FS_VESTA_GIT_HEAD_VERSION})

  message(STATUS "Git HEAD version: " ${FS_VESTA_GIT_HEAD_VERSION})
else()
  set(FS_VESTA_GIT_HEAD_VERSION ${FS_VESTA_GIT_UNKNOWN_VERSION})
endif()


# A vanilla name has a format like ${TARGET_NAME}${FS_VESTA_BIN_NAME_SUFFIX}d?
function(FS_VESTA_USE_VANILLA_OUTPUT_NAME TARGET_NAME)
  set(BIN_NAME "${TARGET_NAME}${FS_VESTA_BIN_NAME_SUFFIX}")
  set_target_properties(${TARGET_NAME}
    PROPERTIES
    OUTPUT_NAME_DEBUG ${BIN_NAME}d
    OUTPUT_NAME_RELEASE ${BIN_NAME}
    )
endfunction()


# @note all dirs and files should be full path
# @ARGV2 lib root dir
# @ARGV3 TRUE OR FALSE which indicates whether is it a static lib
function(FS_VESTA_GENERATE_VESTA_PKG PKG_NAME PKG_HEADER_ROOT_DIR)
  set(FS_VESTA_PKG_NAME ${PKG_NAME})
  set(FS_VESTA_PKG_HEADER_ROOT_DIR ${PKG_HEADER_ROOT_DIR})
  set(FS_VESTA_PKG_HEADER_REGEX "${PKG_HEADER_REGEX}")

  if(${ARGC} EQUAL 4)
    set(FS_VESTA_PKG_LIB_ROOT_DIR ${ARGV2})
    if(${ARGV3}) # if is static lib
      set(FS_VESTA_PKG_LIB_REGEX ${FS_VESTA_PKG_STATIC_LIB_FILENAME_REGEX})
    else()
      set(FS_VESTA_PKG_LIB_REGEX ${FS_VESTA_PKG_SHARED_LIB_FILENAME_REGEX})
    endif()
  elseif(NOT ${ARGC} EQUAL 2)
    message(FATAL_ERROR "wrong number of arguments for funciton: 
    FS_VESTA_GENERATE_VESTA_PKG")
  endif()

  set(FS_VESTA_PKG_FILE "vesta_pkg.py")
  configure_file(${FS_VESTA_DIR}/${FS_VESTA_PKG_FILE}.in
    ${CMAKE_SOURCE_DIR}/${FS_VESTA_PKG_FILE} @ONLY)
  message(STATUS "${CMAKE_SOURCE_DIR}/${FS_VESTA_PKG_FILE} has been generated.")
endfunction()

# Gnerate a config.h file
function(FS_VESTA_GENERATE_CONFIG_H MACRO_PREFIX)
  string(TOUPPER ${MACRO_PREFIX} MACRO_PREFIX_UPPERCASE)
  set(FS_VESTA_MACRO_PREFIX ${MACRO_PREFIX_UPPERCASE})
  set(FS_VESTA_MACRO_PREFIX_NAME "")
  if(${ARGC} EQUAL 2)
    set(FS_VESTA_MACRO_PREFIX_NAME ${ARGV1})
  endif()
  set(FS_VESTA_CONFIG_H_DST_DIR "src")
  if(${ARGC} EQUAL 3)
    set(FS_VESTA_CONFIG_H_DST_DIR ${ARGV2})
  endif()
  set(FS_VESTA_CONFIG_H "config.h")
  configure_file(${FS_VESTA_DIR}/${FS_VESTA_CONFIG_H}.in 
    ${CMAKE_SOURCE_DIR}/${FS_VESTA_CONFIG_H_DST_DIR}/${FS_VESTA_CONFIG_H} @ONLY)
endfunction()

# add prefix_name.h and prefix_name.cpp files into target sources
function(FS_VESTA_TARGET_SOURCES TARGET_NAME SCOPE_SPECIFIER PREFIX_DIR PREFIX_NAMES)
  foreach(pn ${ARGN})
    set(pn ${PREFIX_DIR}/${pn})
    if(EXISTS ${pn}.h)
      target_sources(${TARGET_NAME} ${SCOPE_SPECIFIER} ${pn}.h)
    endif()
    if(EXISTS ${pn}.cpp)
      target_sources(${TARGET_NAME} ${SCOPE_SPECIFIER} ${pn}.cpp)
    endif()
  endforeach()
endfunction()