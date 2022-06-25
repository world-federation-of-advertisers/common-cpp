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
Adds all external repos necessary for common-cpp.
"""

load("//build/rules_proto:repo.bzl", "rules_proto")
load("//build/com_github_grpc_grpc:repo.bzl", "com_github_grpc_grpc_repo")
load("//build/com_facebook_zstd:repo.bzl", "com_facebook_zstd_repo")
load("//build/com_google_absl:repo.bzl", "com_google_absl_repo")
load("//build/com_google_brotli:repo.bzl", "com_google_brotli_repo")
load("//build/com_google_highwayhash:repo.bzl", "com_google_highwayhash_repo")
load("//build/com_google_riegeli:repo.bzl", "com_google_riegeli")
load("//build/com_google_snappy:repo.bzl", "com_google_snappy_repo")
load("//build/boringssl:repo.bzl", "boringssl_repo")
load("//build/farmhash:repo.bzl", "farmhash_repo")
load("//build/com_google_googletest:repo.bzl", "com_google_googletest_repo")
load("//build/com_github_google_glog:repo.bzl", "com_github_google_glog_repo")
load("//build/com_google_private_join_and_compute:repo.bzl", "com_google_private_join_and_compute")
load("//build/nucleus:repo.bzl", "nucleus")

def common_cpp_repositories():
    """
    Adds all external repos necessary for common-cpp.
    """
    com_google_absl_repo()
    rules_proto()
    boringssl_repo()
    farmhash_repo()
    com_google_googletest_repo()
    com_github_google_glog_repo()
    com_github_grpc_grpc_repo()
    com_google_private_join_and_compute()
    com_google_brotli_repo()
    com_google_riegeli()
    com_facebook_zstd_repo()
    com_google_highwayhash_repo()
    com_google_snappy_repo()
    nucleus()
