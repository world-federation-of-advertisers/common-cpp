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
        http_archive(
            name = "com_google_private_join_and_compute",
            sha256 = "13e0414220a2709b0dbeefafe5a4d1b3f3261a541d0405c844857521d5f25f32",
            strip_prefix = "private-join-and-compute-89c8d0aae070b9c282043af419e47d7ef897f460",
            urls = [
                "https://github.com/google/private-join-and-compute/archive/89c8d0aae070b9c282043af419e47d7ef897f460.zip",
            ],
        )
