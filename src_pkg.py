""" Copyright (c) 2019, F.S.. All rights reserved. """

import os
import shutil
import re


def find(path, regex):
    ret = []
    if os.path.isdir(path):
        files = os.listdir(path)
        finder = re.compile(regex)
        for f in files:
            full_path = os.path.join(path, f)
            if os.path.isdir(full_path):
                print(full_path)
                ret.extend(find(full_path, regex))
            else:
                if finder.match(f):
                    ret.append(full_path)
    return ret


def ignore_func(path, files):
    ret = []
    regex = re.compile(".*\\.h$")
    for f in files:
        if os.path.isfile(os.path.join(path, f)):
            if not regex.match(f):
                ret.append(f)
                print(f)
    return ret


if __name__ == "__main__":
    # "_@FS_PKG_NAME@_pkg_"
    pkg_name_tmp_dir = "_test_pkg_"
    if os.path.isdir(pkg_name_tmp_dir):
        shutil.rmtree(pkg_name_tmp_dir)
    os.mkdir(pkg_name_tmp_dir)
    # "include/@FS_PKG_NAME@"
    header_dir = pkg_name_tmp_dir + "/include/Sun"
    # if not os.path.isdir(header_dir):
    #     os.makedirs(header_dir)
    shutil.copytree("src", header_dir,
                    ignore=ignore_func)

    # headers = find("src", ".*\\.h$")
    # for h in headers:
    #     print(h)
    #     shutil.copy(h, header_dir)
    # lib_dir = pkg_name_tmp_dir + "/lib"
    # os.mkdir("lib")
