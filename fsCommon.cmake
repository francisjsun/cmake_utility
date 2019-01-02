cmake_minimum_required(VERSION 3.0.2)

if(CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DFS_DEBUG=1")
endif()

if(WIN32)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_CRT_SECURE_NO_WARNINGS=1")
elseif(UNIX)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif()

# Git HEAD version
find_package(Git)
if(GIT_FOUND)
  set(FS_GIT_HEAD_VERSION)
  execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    OUTPUT_VARIABLE FS_GIT_HEAD_VERSION)
  
  # remove trial '\n' of the output variable
  string(REGEX REPLACE "\n$" "" FS_GIT_HEAD_VERSION ${FS_GIT_HEAD_VERSION})
  
  message("Git HEAD version: " ${FS_GIT_HEAD_VERSION})
else()
  set(FS_GIT_HEAD_VERSION "unknown")
endif()

# search class_name.[h|cpp] in class_dir and add to buffer
macro(fs_add_class class_name class_dir buffer)
  
  set(src_file ${CMAKE_CURRENT_SOURCE_DIR}/${class_dir}/${class_name}.cpp)
  if(EXISTS ${src_file})
    set(${buffer} ${${buffer}} ${src_file})
    message(STATUS "src_file@ " ${src_file} " added")
  else()
    message("src_file@ " ${src_file} " not found")
  endif()

  set(header_file ${CMAKE_CURRENT_SOURCE_DIR}/${class_dir}/${class_name}.h)
  if(EXISTS ${header_file})
    set(${buffer} ${${buffer}} ${header_file})
    message(STATUS "header_file@ " ${header_file} " added")
  else()
    message("header_file@ " ${header_file} " not found")
  endif()
  
endmacro()

