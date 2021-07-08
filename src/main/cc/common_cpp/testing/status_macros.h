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
#ifndef SRC_MAIN_CC_COMMON_CPP_TESTING_STATUS_MACROS_H_
#define SRC_MAIN_CC_COMMON_CPP_TESTING_STATUS_MACROS_H_

#include <utility>

#ifndef ASSERT_OK_AND_ASSIGN
#define ASSERT_OK_AND_ASSIGN(lhs, rexpr) \
  ASSERT_OK_AND_ASSIGN_IMPL(             \
      STATUS_MACROS__CONCAT(_status_or_value, __COUNTER__), lhs, rexpr)
#endif

#define ASSERT_OK_AND_ASSIGN_IMPL(statusor, lhs, rexpr) \
  auto statusor = (rexpr);                              \
  ASSERT_TRUE(statusor.ok());                           \
  lhs = std::move(statusor).value()

#define STATUS_MACROS__CONCAT_INNER(x, y) x##y
#define STATUS_MACROS__CONCAT(x, y) STATUS_MACROS_CONCAT_IMPL(x, y)

#endif  // SRC_MAIN_CC_COMMON_CPP_TESTING_STATUS_MACROS_H_
