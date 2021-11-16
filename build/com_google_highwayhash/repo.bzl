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
Repository rules/macros for HighwayHash.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_google_highwayhash_repo():
    if "com_google_highwayhash" not in native.existing_rules():
        commit = "276dd7b4b6d330e4734b756e97ccfb1b69cc2e12"
        http_archive(
            name = "com_google_highwayhash",
            build_file = "//third_party:highwayhash.BUILD",
            sha256 = "cf891e024699c82aabce528a024adbe16e529f2b4e57f954455e0bf53efae585",
            strip_prefix = "highwayhash-%s" % commit,
            urls = [
                "https://mirror.bazel.build/github.com/google/highwayhash/archive/%s.zip" % commit,
                "https://github.com/google/highwayhash/archive/%s.zip" % commit,  # 2019-02-22
            ],
        )
