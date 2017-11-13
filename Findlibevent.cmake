# find libevent
if(WIN32)
  set(DEFAULT_INSTALL_DIR "C:/Program\ Files\ (x86)/")
else()
  set(DEFAULT_INSTALL_DIR "/usr/local/")
endif()

find_library(libevent_core_lib NAMES event_core PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "libevent/lib")

find_library(libevent_extra_lib NAMES event_extra PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "libevent/lib")

find_path(libevent_include_dirs event.h PATHS ${DEFAULT_INSTALL_DIR} PATH_SUFFIXES "libevent/include")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libevent DEFAULT_MSG libevent_core_lib libevent_extra_lib libevent_include_dirs)

set(libevent_LIBRARIES ${libevent_core_lib} ${libevent_extra_lib})
set(libevent_INCLUDE_DIRS ${libevent_include_dirs})

