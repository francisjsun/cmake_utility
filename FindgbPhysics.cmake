# find gbPhysics

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(gbPhysics_lib NAMES gbPhysics PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbPhysics")
find_library(gbPhysics_lib_d NAMES gbPhysicsd PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbPhysics")

find_path(gbPhysics_include_dir NAMES config.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "gbPhysics")

include(FindPackageHandleStandardArgs)

set(lib_found)

if(gbPhysics_lib)
  set(lib_found ${gbPhysics_lib})
endif()

if(gbPhysics_lib_d)
  set(lib_found ${gbPhysics_lib_d})
endif()

find_package_handle_standard_args(gbPhysics DEFAULT_MSG lib_found gbPhysics_include_dir)

if(gbPhysics_lib)
  set(gbPhysics_LIBRARIES ${gbPhysics_lib})
else()
  set(gbPhysics_LIBRARIES ${gbPhysics_lib_d})
endif()

if(gbPhysics_lib_d)
  set(gbPhysics_LIBRARIES_d ${gbPhysics_lib_d})
else()
  set(gbPhysics_LIBRARIES_d ${gbPhysics_lib})
endif()

set(gbPhysics_INCLUDE_DIRS ${gbPhysics_include_dir})
