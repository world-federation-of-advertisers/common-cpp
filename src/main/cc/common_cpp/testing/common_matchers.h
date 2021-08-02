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

#ifndef SRC_MAIN_CC_COMMON_CPP_TESTING_COMMON_MATCHERS_H_
#define SRC_MAIN_CC_COMMON_CPP_TESTING_COMMON_MATCHERS_H_

#include "gmock/gmock.h"
#include "google/protobuf/util/message_differencer.h"
#include "gtest/gtest.h"

namespace wfa {

// Returns true if two proto messages are equal, including the order of repeated
// fields.
MATCHER_P(EqualsProto, expected, "") {
  ::google::protobuf::util::MessageDifferencer differencer;
  return differencer.Compare(arg, expected);
}

// Returns true if two proto messages are equal when ignoring the order of
// repeated fields.
MATCHER_P(EqualsProtoIgnoringRepeatedOrder, expected, "") {
  ::google::protobuf::util::MessageDifferencer differencer;
  differencer.set_repeated_field_comparison(
      ::google::protobuf::util::MessageDifferencer::AS_SET);
  return differencer.Compare(arg, expected);
}

}  // namespace wfa

#endif  // SRC_MAIN_CC_COMMON_CPP_TESTING_COMMON_MATCHERS_H_
