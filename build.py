# Copyright (C) 2020 Francis Sun, all rights reserved.

import os
import shutil
import argparse
import subprocess
import sys


def _clean():
    if os.path.isdir("build"):
        shutil.rmtree("build")


def _build(build_type="Debug"):
    if sys.platform == "win32":
        subprocess.run(["cmake", "-S", ".", "-B", "build"])
        subprocess.run(["cmake", "--build", "build", "--config", build_type])
    else:
        cmake_build_type_arg = str.format("-DCMAKE_BUILD_TYPE={0}",
                                          build_type)
        subprocess.run(["cmake", cmake_build_type_arg,
                        "-S", ".", "-B", "build"])
        subprocess.run(["cmake", "--build", "build"])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-c", action="store_true", dest="c",
                        help="clean")
    parser.add_argument("-p", action="store_true", dest="p",
                        help="build both debug and release, then make a pkg")
    opt = parser.parse_args()

    if opt.c:
        _clean()
    else:
        if not opt.p:
            _build()
        else:
            _build("Debug")
            _build("Release")
            import vesta_pkg
            vesta_pkg.pkg()


if __name__ == "__main__":
    main()
