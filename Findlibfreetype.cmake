# find libfreetype

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

set(lib_name "libfreetype.a")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(lib_name "libfreetyped.a")
endif()

find_library(libfreetype_lib NAMES ${lib_name} PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lib")

find_path(libfreetype_include_dirs ft2build.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "include/freetype2")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libfreetype DEFAULT_MSG libfreetype_lib libfreetype_include_dirs)

set(libfreetype_LIBRARIES ${libfreetype_lib})
set(libfreetype_INCLUDE_DIRS ${libfreetype_include_dirs})
