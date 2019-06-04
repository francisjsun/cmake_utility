""" Copyright (c) 2019, F.S.. All rights reserved. """

import os
import shutil
import re


def find(path, regex):
    files = []
    dirs = []
    if os.path.isdir(path):
        cur_files = os.listdir(path)
        if isinstance(regex, str):
            regex = re.compile(regex)
        for f in cur_files:
            full_path = os.path.join(path, f)
            if os.path.isdir(full_path):
                dirs.append(full_path)
                sub_files, sub_dis = find(full_path, regex)
                files.extend(sub_files)
                dirs.extend(sub_dis)
            else:
                if regex.match(f):
                    files.append(full_path)
    return (files, dirs)


def copy_full_path(src_root, regex, dst_root):
    files, dirs = find(src_root, regex)
    # create dir if not exists
    for d in dirs:
        dst_dir = os.path.join(dst_root, d[len(src_root) + 1:])
        if not os.path.isdir(dst_dir):
            os.makedirs(dst_dir)

    for f in files:
        if os.path.isfile(f):
            dst_path = os.path.join(dst_root, f[len(src_root) + 1:])
            shutil.copy(f, dst_path)


if __name__ == "__main__":
    # create tmp dir
    tmp_pkg_dir = "_proj_name_"
    if os.path.isdir(tmp_pkg_dir):
        shutil.rmtree(tmp_pkg_dir)
    os.mkdir(tmp_pkg_dir)
    copy_full_path("src", ".*\\.h$", tmp_pkg_dir)
