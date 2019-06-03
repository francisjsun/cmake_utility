""" Copyright (c) 2019, F.S.. All rights reserved. """

import os
import shutil
import argparse
import subprocess
import sys
# import tarfile


def clean():
    shutil.rmtree("build")


def build(build_type="Debug"):
    if sys.platform == "win32":
        subprocess.run(["cmake", ".."])
        subprocess.run("cmake", "--build", ".", "--config", build_type)
    else:
        cmake_build_type_arg = str.format("-DCMAKE_BUILD_TYPE={0}",
                                          build_type)
        subprocess.run(["cmake", cmake_build_type_arg, ".."])
        subprocess.run(["cmake", "--build", "."])


""" def pack(): """

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-c", action="store_true", dest="c",
                        help="clean")
    parser.add_argument("-p", action="store_true", dest="p",
                        help="build both debug and release, then make a pkg")
    opt = parser.parse_args()

    if opt.c:
        clean()
    else:
        if not os.path.isdir("build"):
            os.mkdir("build")
        old_cwd = os.getcwd()
        os.chdir("build")

        if not opt.p:
            build()
        else:
            build("Debug")
            build("Release")

        os.chdir(old_cwd)
