# Copyright (c) 2019, F.S.. All rights reserved.
#!/bin/bash
pkg_name=fsCMake
pkg_files="CMakeLists.txt src_pkg.sh.in fs_proj.xml.in build.sh"

echo "******** begin packing fsCMake ********"

pkg_file_name=${pkg_name}.tar.xz
tar -cvJf ${pkg_name}.tar.xz $pkg_files

echo "******** $pkg_file_name generated ********"
echo "******** end of packing fsCMake ********"
