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
Repository rules/macros for Riegeli.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_google_riegeli_repo():
    if "com_google_riegeli" not in native.existing_rules():
        commit = "e932567949104816275f9f103d050b3d9f96932b"
        http_archive(
            name = "com_google_riegeli",
            sha256 = "eaea85dad79238397f9476be42b634e2b2ab6fbf90358f4e5673da1f34540381",
            strip_prefix = "riegeli-%s" % commit,
            url = "https://github.com/google/riegeli/archive/%s.zip" % commit,
            repo_mapping = {
                "@highwayhash": "@com_google_highwayhash",
                "@net_zstd": "@com_facebook_zstd",
                "@snappy": "@com_google_snappy",
            },
        )
