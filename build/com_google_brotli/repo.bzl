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
        version = "1.1.0"  # 2023-08-31
        http_archive(
            name = "org_brotli",
            sha256 = "9d7ec775e67cdb3d0328f63f314b381d57f0f985499bbf2e55b15138a3621b19",
            strip_prefix = "brotli-1.1.0",
            urls = [
                "https://github.com/google/brotli/archive/refs/tags/v%s.zip" % version,
            ],
        )
