# find gbUtils

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(gbUtils_lib NAMES gbUtils PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")
find_library(gbUtils_lib_d NAMES gbUtilsd PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")

find_path(gbUtils_include_dir NAMES config.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")

include(FindPackageHandleStandardArgs)

set(lib_found)
if(gbUtils_lib)
  set(lib_found ${gbUtils_lib})
endif()

if(gbUtils_lib_d)
  set(lib_found ${gbUtils_lib})
endif()

find_package_handle_standard_args(gbUtils DEFAULT_MSG lib_found gbUtils_include_dir)

if(gbUtils_lib)
  set(gbUtils_LIBRARIES ${gbUtils_lib})
else()
  set(gbUtils_LIBRARIES ${gbUtils_lib_d})
endif()

if(gbUtils_lib_d)
  set(gbUtils_LIBRARIES_d ${gbUtils_lib_d})
else()
  set(gbUtils_LIBRARIES_d ${gbUtils_lib})
endif()

set(gbUtils_INCLUDE_DIRS ${gbUtils_include_dir})
