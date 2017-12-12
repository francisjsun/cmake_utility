# find libfreetype

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(libfreetype_lib NAMES libfreetype.a PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lib")
find_library(libfreetype_lib_d NAMES libfreetyped.a PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lib")

find_path(libfreetype_include_dirs ft2build.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "include/freetype2")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libfreetype DEFAULT_MSG libfreetype_lib libfreetype_include_dirs)

set(libfreetype_LIBRARIES ${libfreetype_lib})
set(libfreetype_LIBRARIES_d ${libfreetype_lib_d})
set(libfreetype_INCLUDE_DIRS ${libfreetype_include_dirs})
