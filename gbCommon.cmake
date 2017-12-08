cmake_minimum_required(VERSION 3.0)


set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DGB_DEBUG=1")
endif()

if(WIN32)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_CRT_SECURE_NO_WARNINGS=1")
elseif(UNIX)
set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -Wall)
endif()


set(GB_DEFAULT_INSTALL_DIR)
if(WIN32)
  set(GB_DEFAULT_INSTALL_DIR "C:/Program\ Files\ (x86)")
else()
  set(GB_DEFAULT_INSTALL_DIR "/usr/local")
endif()

include_directories(SYSTEM ${GB_DEFAULT_INSTALL_DIR})
# search class_name.[h|cpp] in class_dir and add to buffer
macro(gb_add_class class_name class_dir buffer)
  
  set(src_file ${CMAKE_SOURCE_DIR}/${class_dir}/${class_name}.cpp)
  if(EXISTS ${src_file})
    set(${buffer} ${${buffer}} ${src_file})
    message(STATUS "src_file@ " ${src_file} " added")
  else()
    message("src_file@ " ${src_file} " not found")
  endif()

  set(header_file ${CMAKE_SOURCE_DIR}/${class_dir}/${class_name}.h)
  if(EXISTS ${header_file})
    set(${buffer} ${${buffer}} ${header_file})
    message(STATUS "header_file@ " ${header_file} " added")
  else()
    message("header_file@ " ${header_file} " not found")
  endif()
  
endmacro()

