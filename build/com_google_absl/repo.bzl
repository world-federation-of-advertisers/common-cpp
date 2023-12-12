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
Repository rules/macros for Abseil.

See https://abseil.io.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_google_absl_repo():
    if "com_google_absl" not in native.existing_rules():
        http_archive(
            name = "com_google_absl",
            sha256 = "987ce98f02eefbaf930d6e38ab16aa05737234d7afbab2d5c4ea7adbe50c28ed",
            strip_prefix = "abseil-cpp-20230802.1",
            urls = [
                "https://github.com/abseil/abseil-cpp/archive/refs/tags/20230802.1.tar.gz",
            ],
        )
