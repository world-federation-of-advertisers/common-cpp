# Copyright 2023 The Cross-Media Measurement Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Module extension for non-module dependencies."""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _riegeli_deps():
    http_archive(
        name = "org_brotli",
        urls = ["https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz"],
        strip_prefix = "brotli-1.1.0",
        sha256 = "e720a6ca29428b803f4ad165371771f5398faba397edf6778837a18599ea13ff",
    )

    http_archive(
        name = "net_zstd",
        build_file = "@com_google_riegeli//third_party:net_zstd.BUILD",
        sha256 = "b6c537b53356a3af3ca3e621457751fa9a6ba96daf3aebb3526ae0f610863532",
        strip_prefix = "zstd-1.4.5/lib",
        urls = ["https://github.com/facebook/zstd/archive/v1.4.5.zip"],  # 2020-05-22
    )

    http_archive(
        name = "highwayhash",
        build_file = "@com_google_riegeli//third_party:highwayhash.BUILD",
        sha256 = "cf891e024699c82aabce528a024adbe16e529f2b4e57f954455e0bf53efae585",
        strip_prefix = "highwayhash-276dd7b4b6d330e4734b756e97ccfb1b69cc2e12",
        urls = ["https://github.com/google/highwayhash/archive/276dd7b4b6d330e4734b756e97ccfb1b69cc2e12.zip"],  # 2019-02-22
    )

    http_archive(
        name = "snappy",
        build_file = "@com_google_riegeli//third_party:snappy.BUILD",
        urls = ["https://github.com/google/snappy/archive/refs/tags/1.1.10.tar.gz"],
        strip_prefix = "snappy-1.1.10",
        sha256 = "49d831bffcc5f3d01482340fe5af59852ca2fe76c3e05df0e67203ebbe0f1d90",
    )

def _non_module_deps_impl(
        # buildifier: disable=unused-variable
        mctx):
    http_archive(
        name = "farmhash",
        urls = [
            # 2019-05-13, final version before repo was archived
            "https://github.com/google/farmhash/archive/0d859a811870d10f53a594927d0d0b97573ad06d.tar.gz",
        ],
        strip_prefix = "farmhash-0d859a811870d10f53a594927d0d0b97573ad06d",
        sha256 = "18392cf0736e1d62ecbb8d695c31496b6507859e8c75541d7ad0ba092dc52115",
        build_file_content = """
package(default_visibility = ["//visibility:public"])

cc_library(
    name = "farmhash",
    hdrs = ["src/farmhash.h"],
    srcs = ["src/farmhash.cc"],
)
""",
    )

    # TODO(google/riegeli#28): Load as bazel_dep once available.
    http_archive(
        name = "com_google_riegeli",
        urls = [
            # 2023-12-06
            "https://github.com/google/riegeli/archive/6b99c30ce30d7ebc24a8c04772c11682cafc0732.tar.gz",
        ],
        strip_prefix = "riegeli-6b99c30ce30d7ebc24a8c04772c11682cafc0732",
        sha256 = "0d50ba0f8654a4b1674f25c4c02f990c44c760f35d397d99cf0551b73912beea",
    )
    _riegeli_deps()

non_module_deps = module_extension(
    implementation = _non_module_deps_impl,
)
