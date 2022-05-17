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
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

_COMMIT = "505ba981d66c9e5e73e18cfa647b4685f74784cb"
_SHA_256 = "b1a83e1bc778fe902b782ae6d06fdf590a1f74684954c05592463ddad75f8ddb"

def com_google_private_join_and_compute():
    maybe(
        http_archive,
        name = "com_google_private_join_and_compute",
        urls = [
            "https://github.com/google/private-join-and-compute/archive/{commit}.tar.gz".format(commit = _COMMIT),
        ],
        strip_prefix = "private-join-and-compute-{commit}".format(commit = _COMMIT),
        sha256 = _SHA_256,
        repo_mapping = {
            # TODO(bazelbuild/rules_proto#121): Remove this once
            # protobuf_workspace is fixed.
            "@com_google_protobuf": "@com_github_protocolbuffers_protobuf",
        },
    )
