# Copyright (C) 2020 Francis Sun, all rights reserved.

import os
import tarfile
import shutil


if __name__ == "__main__":
    pkg_files = ['CMakeLists.txt', 'config.h.in.in', 'vesta_pkg.py.in']
    pkg_name = 'vesta'

    # rm the dir pkg_name if it exists
    if os.path.isdir(pkg_name):
        shutil.rmtree(pkg_name)

    # create the dir pkg_name
    os.mkdir(pkg_name)

    # copy pkg_files into the dir pkg_name
    for pkg_file in pkg_files:
        shutil.copy(pkg_file, pkg_name)

    pkg_path = 'vesta.tar.xz'

    # rm the file if it exists
    if os.path.isfile(pkg_path):
        os.remove(pkg_path)

    # tar it
    with tarfile.open(pkg_path, 'x:xz') as f:
        f.add(pkg_name)
        f.close()
