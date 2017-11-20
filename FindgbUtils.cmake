# find gbUtils

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

set(lib_name "gbUtils")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(lib_name "gbUtilsd")
endif()

find_library(gbUtils_lib NAMES ${lib_name} PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")

find_path(gbUtils_include_dir NAMES gbUtilsConfig.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(gbUtils DEFAULT_MSG gbUtils_lib gbUtils_include_dir)

set(gbUtils_LIBRARIES ${gbUtils_lib})
set(gbUtils_INCLUDE_DIRS ${gbUtils_include_dir})
