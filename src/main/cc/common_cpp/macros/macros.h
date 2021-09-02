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
#ifndef SRC_MAIN_CC_COMMON_CPP_MACROS_MACROS_H_
#define SRC_MAIN_CC_COMMON_CPP_MACROS_MACROS_H_

#include <utility>

#ifndef RETURN_IF_ERROR
#define RETURN_IF_ERROR(expr)    \
  do {                           \
    if (!expr.ok()) return expr; \
  } while (false)
#endif

#ifndef ASSIGN_OR_RETURN
#define ASSIGN_OR_RETURN(lhs, rexpr)                                          \
  MACROS__ASSIGN_OR_RETURN_IMPL(MACROS__CONCAT(status_or_value, __COUNTER__), \
                                lhs, rexpr)
#endif

#ifndef ASSIGN_OR_RETURN_ERROR
#define ASSIGN_OR_RETURN_ERROR(lhs, rexpr, message) \
  MACROS__ASSIGN_OR_RETURN_ERROR_IMPL(              \
      MACROS__CONCAT(status_or_value, __COUNTER__), lhs, rexpr, message)
#endif

#ifndef NULL_CHECK
#define NULL_CHECK(val)  \
  ({                     \
    assert(val != NULL); \
    val;                 \
  })
#endif

// Internal helper.
#define MACROS__ASSIGN_OR_RETURN_IMPL(statusor, lhs, rexpr) \
  auto statusor = (rexpr);                                  \
  if (ABSL_PREDICT_FALSE(!statusor.ok())) {                 \
    return std::move(statusor).status();                    \
  }                                                         \
  lhs = *std::move(statusor)

// Internal helper.
#define MACROS__ASSIGN_OR_RETURN_ERROR_IMPL(statusor, lhs, rexpr, message) \
  auto statusor = (rexpr);                                                 \
  if (ABSL_PREDICT_FALSE(!statusor.ok())) {                                \
    return absl::InvalidArgumentError(message);                            \
  }                                                                        \
  lhs = *std::move(statusor)

// Internal helper for concatenating macro values.
#define MACROS__CONCAT_INNER(x, y) x##y
#define MACROS__CONCAT(x, y) MACROS__CONCAT_INNER(x, y)

#endif  // SRC_MAIN_CC_COMMON_CPP_MACROS_MACROS_H_
