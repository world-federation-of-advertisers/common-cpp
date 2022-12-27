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
Runs external macros necessary for common-cpp.
"""

load(
    "@rules_proto//proto:repositories.bzl",
    "rules_proto_dependencies",
    "rules_proto_toolchains",
)
load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

# Dependencies for differential-privacy
# Load dependencies for the cc workspace.
load("@com_google_cc_differential_privacy//:cc_differential_privacy_deps.bzl", "cc_differential_privacy_deps")

# Accounting dependencies.
load("@com_google_cc_differential_privacy//:cc_accounting_deps.bzl", "cc_accounting_deps")

def common_cpp_deps():
    """
    Runs transitive dependencies from external macros necessary for common-cpp.
    """
    rules_proto_dependencies()
    rules_proto_toolchains()
    grpc_deps()
    cc_differential_privacy_deps()
    cc_accounting_deps()
