#find Theron library
if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

set(lib_name "theron")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(lib_name "therond")
endif()

find_library(theron_lib NAMES ${lib_name} PATH ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "Theron")

set(theron_include_dir ${GB_DEFAULT_INSTALL_DIR}/Theron)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libtheron DEFAULT_MSG theron_lib theron_include_dir)

set(libtheron_LIBRARIES ${theron_lib})

set(libtheron_INCLUDE_DIRS ${theron_include_dir})
