// Copyright 2020 The Cross-Media Measurement Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#ifndef SRC_MAIN_CC_COMMON_CPP_TESTING_STATUS_MATCHERS_H_
#define SRC_MAIN_CC_COMMON_CPP_TESTING_STATUS_MATCHERS_H_

#include <string>

#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace wfa {

namespace internal {
inline absl::Status GetStatus(const absl::Status& status) { return status; }

template <class T>
inline absl::Status GetStatus(const absl::StatusOr<T>& status) {
  return status.status();
}
}  // namespace internal

using internal::GetStatus;

MATCHER(IsOk, "") {
  if (!arg.ok()) {
    *result_listener << "expected OK status but got: " << GetStatus(arg);
    return false;
  }
  return true;
}

MATCHER(IsNotOk, "") {
  return testing::ExplainMatchResult(testing::Not(IsOk()), arg,
                                     result_listener);
}

MATCHER_P(IsOkAndHolds, value, "") {
  if (arg.ok()) {
    return testing::ExplainMatchResult(value, *arg, result_listener);
  }

  *result_listener << "expected OK but got: " << GetStatus(arg);
  return false;
}

MATCHER_P2(StatusIs, code, message, "") {
  if (arg.code() != code) {
    *result_listener << "Expected code: " << code << " but got "
                     << GetStatus(arg);
    return false;
  }
  return testing::ExplainMatchResult(
      testing::HasSubstr(message), std::string(arg.message()), result_listener);
}
}  // namespace wfa

#endif  // SRC_MAIN_CC_COMMON_CPP_TESTING_STATUS_MATCHERS_H_
