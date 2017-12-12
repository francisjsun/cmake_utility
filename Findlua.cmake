# find lua

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(lua_libs NAMES lua PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")
find_library(lua_libs_d NAMES luad PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")

find_path(lua_include_dirs lua.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(lua DEFAULT_MSG lua_libs lua_include_dirs)

set(lua_LIBRARIES ${lua_libs})
set(lua_LIBRARIES_d ${lua_libs_d})
set(lua_INCLUDE_DIRS ${lua_include_dirs})

