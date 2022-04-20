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
Repository rules/macros for Private Join & Compute.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("//build/com_github_grpc_grpc:repo.bzl", "com_github_grpc_grpc_repo")

def com_google_private_join_and_compute_repo():
    if "com_google_private_join_and_compute" not in native.existing_rules():
        commit = "505ba981d66c9e5e73e18cfa647b4685f74784cb"
        http_archive(
            name = "com_google_private_join_and_compute",
            sha256 = "f58aa307697c06e9749c18eae16c1338bb548f999c2981bed192fc85493738d1",
            strip_prefix = "private-join-and-compute-%s" % commit,
            url = "https://github.com/google/private-join-and-compute/archive/%s.zip" % commit,
        )
        com_github_grpc_grpc_repo()
