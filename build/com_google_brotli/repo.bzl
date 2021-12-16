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
        commit = "68f1b90ad0d204907beb58304d0bd06391001a4d"
        http_archive(
            name = "org_brotli",
            sha256 = "fec5a1d26f3dd102c542548aaa704f655fecec3622a24ec6e97768dcb3c235ff",
            strip_prefix = "brotli-%s" % commit,
            urls = [
                "https://mirror.bazel.build/github.com/google/brotli/archive/%s.zip" % commit,
                "https://github.com/google/brotli/archive/%s.zip" % commit,  # 2021-08-18
            ],
        )
