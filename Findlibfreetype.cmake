# find libfreetype

if(WIN32)
  set(DEFAULT_INSTALL_DIR "C:/Program\ Files\ (x86)/")
else()
  set(DEFAULT_INSTALL_DIR "/usr/local/")
endif()

find_library(libfreetype_lib NAMES libfreetype.a PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lib")
find_library(libfreetype_lib_d NAMES libfreetyped.a PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lib")

find_path(libfreetype_include_dirs ft2build.h PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "include/freetype2")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libfreetype DEFAULT_MSG libfreetype_lib libfreetype_include_dirs)

set(libfreetype_LIBRARIES ${libfreetype_lib})
set(libfreetype_LIBRARIES_d)
if(libfreetype_lib_d)
  set(libfreetype_LIBRARIES_d ${libfreetype_Lib_d})
else()
  message(WARNING "libfreetyped not found")
  set(libfreetype_LIBRARIES_d ${libfreetype_LIBRARIES})
endif()

set(libfreetype_INCLUDE_DIRS ${libfreetype_include_dirs})
