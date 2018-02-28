# find lua

if(NOT GB_DEFAULT_INSTALL_DIR)
  message(FATAL_ERROR "GB_DEFAULT_INSTALL_DIR not set")
endif()

find_library(lua_libs NAMES lua PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")
find_library(lua_libs_d NAMES luad PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")

find_path(lua_include_dirs lua.h PATHS ${GB_DEFAULT_INSTALL_DIR} PATH_SUFFIXES "lua")

include(FindPackageHandleStandardArgs)
set(lib_found)
if(lua_libs)
  set(lib_found ${lua_libs})
endif()

if(lia_libs_d)
  set(lib_found ${lua_libs})
endif()

find_package_handle_standard_args(lua DEFAULT_MSG lib_found lua_include_dirs)

if(lua_libs)
  set(lua_LIBRARIES ${lua_libs})
else()
  set(lua_LIBRARIES ${lua_libs_d})
endif()

if(lua_libs_d)
  set(lua_LIBRARIES_d ${lua_libs_d})
else()
  set(lua_LIBRARIES_d ${lua_libs})
endif()

set(lua_INCLUDE_DIRS ${lua_include_dirs})

