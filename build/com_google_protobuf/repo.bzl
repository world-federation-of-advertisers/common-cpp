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
Repository rules/macros for Protobuf.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def com_google_protobuf_repo():
    if "com_google_protobuf" not in native.existing_rules():
        http_archive(
            name = "com_google_protobuf",
            sha256 = "355cf346e6988fd219ff7b18e6e68a742aaef09a400a0cf2860e7841468a12ac",
            strip_prefix = "protobuf-3.15.7",
            urls = ["https://github.com/protocolbuffers/protobuf/releases/download/v3.15.7/protobuf-all-3.15.7.tar.gz"],
        )

    # Also download rules_python. This is because `protobuf_deps()` in
    # @com_google_protobuf//:protobuf_deps.bzl will install an ancient
    # version of rules_python that causes problems like:
    #
    #  Error: file '@rules_python//python:pip.bzl' does not contain symbol
    #  'pip_install'
    #
    # To work around this, we just depend on a newer version.
    http_archive(
        name = "rules_python",
        urls = ["https://github.com/bazelbuild/rules_python/releases/download/0.3.0/rules_python-0.3.0.tar.gz"],
        sha256 = "934c9ceb552e84577b0faf1e5a2f0450314985b4d8712b2b70717dc679fdc01b",
    )
