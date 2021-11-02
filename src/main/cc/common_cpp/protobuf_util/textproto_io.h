// Copyright 2021 The Cross-Media Measurement Authors
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

#ifndef SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_TEXTPROTO_IO_H_
#define SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_TEXTPROTO_IO_H_

#include "absl/status/status.h"
#include "absl/strings/string_view.h"
#include "google/protobuf/message.h"

namespace wfa {

// Read textproto from file with @path, and store the protobuf object in
// @message.
// Return error status if the reading fails.
absl::Status ReadTextProtoFile(absl::string_view path,
                               google::protobuf::Message& message);

// Write @message to file with @path in textproto format.
// The output file is only accessible by owner.
// Return error status if the writing fails.
absl::Status WriteTextProtoFile(absl::string_view path,
                                const google::protobuf::Message& message);

}  // namespace wfa

#endif  // SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_TEXTPROTO_IO_H_
