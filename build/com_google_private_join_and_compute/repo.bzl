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
        commit = "b4d3de618b6dcf1c14265f5371d3e74151faf4ee"
        http_archive(
            name = "com_google_private_join_and_compute",
            sha256 = "58cb2ac075a1722c3b31d5c1dd7a79cde92473558fb516ebe64152a6ed3f52b1",
            strip_prefix = "private-join-and-compute-%s" % commit,
            url = "https://github.com/google/private-join-and-compute/archive/%s.zip" % commit,
        )
        com_github_grpc_grpc_repo()
