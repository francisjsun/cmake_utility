cmake_minimum_required(VERSION 3.0)

# search class_name.[h|cpp] in class_dir and add to buffer
macro(gb_add_class class_name class_dir buffer)
  
  set(src_file ${CMAKE_SOURCE_DIR}/${class_dir}/${class_name}.cpp)
  if(EXISTS ${src_file})
    message(STATUS "src_file@ " ${src_file} " added")
  else()
    set(buffer ${buffer} ${src_file})
    message("src_file@ " ${src_file} " not found")

  endif()

  set(header_file ${CMAKE_SOURCE_DIR}/${class_dir}/${class_name}.h)
  if(EXISTS ${header_file})
    set(buffer ${buffer} ${header_file})
    message(STATUS "header_file@ " ${header_file} " added")
  else()
    message("header_file@ " ${header_file} " not found")
  endif()

endmacro()

