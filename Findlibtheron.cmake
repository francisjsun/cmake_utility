#find Theron library
if(UNIX)
  set(DEFAULT_INSTALL_DIR "/usr/local/")
endif()

find_library(theron_lib NAMES theron PATH ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "Theron/Lib")
find_library(theron_lib_d NAMES therond PATH ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "Theron/Lib")

set(theron_include_dir ${DEFAULT_INSTALL_DIR}Theron/Include)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libtheron DEFAULT_MSG theron_lib theron_include_dir)

set(libtheron_LIBRARIES ${theron_lib})
set(libtheron_LIBRARIES_d)
if(theron_lib_d)
  set(libtheron_LIBRARIES_d ${theron_lib_d})
endif()

set(libtheron_INCLUDE_DIRS ${theron_include_dir})
