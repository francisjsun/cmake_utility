# find lua

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

set(lib_name "lua")
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(lib_name "luad")
endif()

find_library(lua_libs NAMES ${lib_name} PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")

find_path(lua_include_dirs lua.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(lua DEFAULT_MSG lua_libs lua_include_dirs)

set(lua_LIBRARIES ${lua_libs})
set(lua_INCLUDE_DIRS ${lua_include_dirs})

