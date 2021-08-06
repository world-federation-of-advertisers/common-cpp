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

def com_google_private_join_and_compute_repo():
    if "com_google_private_join_and_compute" not in native.existing_rules():
        commit = "76477f8d9f0cd773e7e827ad032062ab6e2efd6c"
        http_archive(
            name = "com_google_private_join_and_compute",
            sha256 = "087311356c52f2d896698bb7495114d0469fb830e04ecba682d39fe303657399",
            strip_prefix = "private-join-and-compute-%s" % commit,
            urls = [
                "https://github.com/google/private-join-and-compute/archive/%s.zip" % commit,
            ],
        )
