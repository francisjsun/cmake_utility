# find gbPhysics

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(gbPhysics_lib NAMES gbPhysics PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbPhysics")
find_library(gbPhysics_lib_d NAMES gbPhysics PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbPhysics")

find_path(gbPhysics_include_dir NAMES gbPhysicsConfig.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbPhysics")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(gbPhysics DEFAULT_MSG gbPhysics_lib gbPhysics_include_dir)

set(gbPhysics_LIBRARIES ${gbPhysics_lib})
set(gbPhysics_LIBRARIES_d)
if(gbPhysics_lib_d)
  set(gbPhysics_LIBRARIES_d ${gbPhysics_lib_d})
else()
  message(WARNING "gbPhysicsd not found")
  set(gbPhysics_LIBRARIES_d ${gbPhysics_LIBRARIES})
endif()

set(gbPhysics_INCLUDE_DIRS ${gbPhysics_include_dir})
