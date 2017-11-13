# find gbUtils

if(WIN32)
  set(DEFAULT_INSTALL_DIR "C:/Program\ Files\ (x86)/")
else()
  set(DEFAULT_INSTALL_DIR "/usr/local/")
endif()

find_library(gbUtils_lib NAMES gbUtils PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils/lib")
find_library(gbUtils_lib_d NAMES gbUtilsd PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils/lib")

find_path(gbUtils_include_dir NAMES gbUtilsConfig.h PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbUtils/include")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(gbUtils DEFAULT_MSG gbUtils_lib gbUtils_include_dir)

set(gbUtils_LIBRARIES ${gbUtils_lib})
set(gbUtils_LIBRARIES_d)
if(gbUtils_lib_d)
  set(gbUtils_LIBRARIES_d ${gbUtils_lib_d})
# else()
#   unset(gbUtils_LIBRARIES_d)
endif()

set(gbUtils_INCLUDE_DIRS ${gbUtils_include_dir})
