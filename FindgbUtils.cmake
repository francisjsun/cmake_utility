# find gbUtils

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(gbUtils_lib NAMES gbUtils PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")
find_library(gbUtils_lib_d NAMES gbUtilsd PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")

find_path(gbUtils_include_dir NAMES config.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(gbUtils DEFAULT_MSG gbUtils_lib gbUtils_include_dir)

set(gbUtils_LIBRARIES ${gbUtils_lib})
set(gbUtils_LIBRARIES_d ${gbUtils_lib_d})
set(gbUtils_INCLUDE_DIRS ${gbUtils_include_dir})
