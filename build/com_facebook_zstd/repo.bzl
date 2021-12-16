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
Repository rules/macros for Zstandard.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_facebook_zstd_repo():
    if "com_facebook_zstd" not in native.existing_rules():
        http_archive(
            name = "com_facebook_zstd",
            build_file = "@com_google_riegeli//third_party:net_zstd.BUILD",
            sha256 = "b6c537b53356a3af3ca3e621457751fa9a6ba96daf3aebb3526ae0f610863532",
            strip_prefix = "zstd-1.4.5/lib",
            urls = [
                "https://mirror.bazel.build/github.com/facebook/zstd/archive/v1.4.5.zip",
                "https://github.com/facebook/zstd/archive/v1.4.5.zip",  # 2020-05-22
            ],
        )
