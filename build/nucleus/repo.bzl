# Copyright 2022 The Cross-Media Measurement Authors
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

"""Repository rules/macros for Nucleus."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def nucleus():
    maybe(
        http_archive,
        name = "nucleus",
        urls = ["https://github.com/google/nucleus/archive/refs/tags/0.6.0.tar.gz"],
        sha256 = "326907b1ae0a3419806b52ff1bd80502d842248edc7986a89fba9fc4ed37ff0b",
        strip_prefix = "nucleus-0.6.0",
        patches = ["@wfa_common_cpp//build/nucleus:testing.patch"],
    )
