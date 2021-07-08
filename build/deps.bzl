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

load("//build/com_google_absl:repo.bzl", "com_google_absl_repo")
load("//build/boringssl:repo.bzl", "boringssl_repo")
load("//build/farmhash:repo.bzl", "farmhash_repo")
load("//build/googletest:repo.bzl", "googletest_repo")
load("//build/com_github_glog_glog:repo.bzl", "com_github_glog_glog_repo")

def common_cpp_deps():
    com_google_absl_repo()
    boringssl_repo()
    farmhash_repo()
    googletest_repo()
    com_github_glog_glog_repo()
