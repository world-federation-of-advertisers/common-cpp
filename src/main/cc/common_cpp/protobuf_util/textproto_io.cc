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

#include "common_cpp/protobuf_util/textproto_io.h"

#include <fcntl.h>

#include <filesystem>

#include "absl/status/status.h"
#include "absl/strings/str_cat.h"
#include "absl/strings/string_view.h"
#include "google/protobuf/io/zero_copy_stream_impl.h"
#include "google/protobuf/message.h"
#include "google/protobuf/text_format.h"

namespace wfa {

absl::Status ReadTextProtoFile(absl::string_view path,
                               google::protobuf::Message& message) {
  int fd = open(path.data(), O_RDONLY);
  if (fd <= 0) {
    return absl::InvalidArgumentError(
        absl::StrCat("Unable to open file: ", path));
  }
  google::protobuf::io::FileInputStream file_input(fd);
  file_input.SetCloseOnDelete(true);
  if (!google::protobuf::TextFormat::Parse(&file_input, &message)) {
    return absl::InvalidArgumentError(
        absl::StrCat("Unable to parse textproto file: ", path));
  }
  return absl::OkStatus();
}

absl::Status WriteTextProtoFile(absl::string_view path,
                                const google::protobuf::Message& message) {
  // The output file is only accessible by owner.
  int fd = open(path.data(), O_CREAT | O_WRONLY, S_IRWXU);
  if (fd <= 0) {
    return absl::InvalidArgumentError(
        absl::StrCat("Unable to create file: ", path));
  }
  google::protobuf::io::FileOutputStream file_output(fd);
  file_output.SetCloseOnDelete(true);
  if (!google::protobuf::TextFormat::Print(message, &file_output)) {
    return absl::InvalidArgumentError(
        absl::StrCat("Unable to write textproto file: ", path));
  }
  return absl::OkStatus();
}

}  // namespace wfa

#endif  // SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_TEXTPROTO_IO_H_
