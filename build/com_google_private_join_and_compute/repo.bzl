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
    """Installs deps inclusing transitive deps for panel_exchange_client."""
    if "com_google_private_join_and_compute" not in native.existing_rules():
        commit = "8bc01b3f0b41a8ee80acee9ad5ae2c45bbdaef88"
        http_archive(
            name = "com_google_private_join_and_compute",
            sha256 = "ea5e060f76c58787c4c7b71a8e1354ff04b117af6bbcdc5e466328657d497e06",
            strip_prefix = "private-join-and-compute-%s" % commit,
            urls = [
                "https://github.com/google/private-join-and-compute/archive/%s.zip" % commit,
            ],
        )
    if "com_github_glog_glog" not in native.existing_rules():
        http_archive(
            name = "com_github_glog_glog",
            sha256 = "21bc744fb7f2fa701ee8db339ded7dce4f975d0d55837a97be7d46e8382dea5a",
            strip_prefix = "glog-0.5.0",
            url = "https://github.com/google/glog/archive/v0.5.0.zip",
        )
