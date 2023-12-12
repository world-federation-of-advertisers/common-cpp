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
Repository rules/macros for boringssl library.

See https://boringssl.googlesource.com/boringssl.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def boringssl_repo():
    if "boringssl" not in native.existing_rules():
        commit = "e706c2ee12d5d5927cc10a804fefbae3da2d66b3"  # 12/12/2023, branch: master-with-bazel
        http_archive(
            name = "boringssl",
            # Use github mirror instead of https://boringssl.googlesource.com/boringssl
            # to obtain a boringssl archive with consistent sha256
            sha256 = "e665a65074df16891f682a682741816f34b70c380ab37d4b7dd408ac091efffc",
            strip_prefix = "boringssl-%s" % commit,
            urls = [
                #            "https://storage.googleapis.com/grpc-bazel-mirror/github.com/google/boringssl/archive/%s.tar.gz" % commit,
                "https://github.com/google/boringssl/archive/%s.tar.gz" % commit,
            ],
        )
