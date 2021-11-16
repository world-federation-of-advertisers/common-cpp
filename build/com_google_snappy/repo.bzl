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
Repository rules/macros for Snappy.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_google_snappy_repo():
    if "com_google_snappy" not in native.existing_rules():
        http_archive(
            name = "com_google_snappy",
            build_file = "//third_party:snappy.BUILD",
            sha256 = "38b4aabf88eb480131ed45bfb89c19ca3e2a62daeb081bdf001cfb17ec4cd303",
            strip_prefix = "snappy-1.1.8",
            urls = [
                "https://mirror.bazel.build/github.com/google/snappy/archive/1.1.8.zip",
                "https://github.com/google/snappy/archive/1.1.8.zip",  # 2020-01-14
            ],
        )
