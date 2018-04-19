# find libfreetype

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(libfreetype_lib NAMES freetype PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "freetype")

find_library(libfreetype_lib_d NAMES freetyped PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "freetype")

find_path(libfreetype_include_dirs ft2build.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "freetype")

include(FindPackageHandleStandardArgs)

set(lib_found)
if(libfreetype_lib)
  set(lib_found ${libfreetype_lib})
endif()

if(libfreetype_lib_d)
  set(lib_found ${libfreetype_lib_d})
endif()

find_package_handle_standard_args(libfreetype DEFAULT_MSG lib_found libfreetype_include_dirs)

if(libfreetype_lib)
  set(libfreetype_LIBRARIES ${libfreetype_lib})
else()
  set(libfreetype_LIBRARIES ${libfreetype_lib_d})
endif()

if(libfreetype_lib_d)
  set(libfreetype_LIBRARIES_d ${libfreetype_lib_d})
else()
  set(libfreetype_LIBRARIES_d ${libfreetype_lib})
endif()

set(libfreetype_INCLUDE_DIRS ${libfreetype_include_dirs})
