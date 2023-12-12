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
Repository rules/macros for Brotli.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_google_brotli_repo():
    if "com_google_brotli" not in native.existing_rules():
        commit = "ed738e842d2fbdf2d6459e39267a633c4a9b2f5d"  # 2023-08-31, v1.1.0
        http_archive(
            name = "org_brotli",
            sha256 = "a68ec12a898abc9cf248f21362620562041b7aab4d623ecd736f39bedf5002a0",
            strip_prefix = "brotli-%s" % commit,
            urls = [
                "https://mirror.bazel.build/github.com/google/brotli/archive/%s.zip" % commit,
                "https://github.com/google/brotli/archive/%s.zip" % commit,
            ],
        )
