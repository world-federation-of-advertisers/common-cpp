# Copyright 2021 The Cross-Media Measurement Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""
Repository rules/macros for farmhash library.

See https://github.com/google/farmhash.
"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

_BUILD_FILE = """
package(default_visibility = ["//visibility:public"])
cc_library(
    name = "farmhash",
    hdrs = ["src/farmhash.h"],
    srcs = ["src/farmhash.cc"],
)
"""

def farmhash_repo():
    if "farmhash" not in native.existing_rules():
        new_git_repository(
            name = "farmhash",
            build_file_content = _BUILD_FILE,
            commit = "2f0e005b81e296fa6963e395626137cf729b710c",
            remote = "https://github.com/google/farmhash.git",
            shallow_since = "1509400690 -0700",
        )
