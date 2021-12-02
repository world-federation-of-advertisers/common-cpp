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

#ifndef SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_RIEGELI_IO_H_
#define SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_RIEGELI_IO_H_

#include <fcntl.h>
#include <stdio.h>

#include <vector>

#include "absl/status/status.h"
#include "absl/strings/str_cat.h"
#include "absl/strings/string_view.h"
#include "google/protobuf/any.pb.h"
#include "riegeli/bytes/fd_reader.h"
#include "riegeli/bytes/fd_writer.h"
#include "riegeli/records/record_reader.h"
#include "riegeli/records/record_writer.h"

namespace wfa {

// Read a list of protobuf messages to @messages. The input messages are from
// the file with @path. Any existing entity in the input @messages is cleared
// before reading.
// Return error status if the reading fails.
// The details about the format of the input file can be found in
// https://github.com/google/riegeli/blob/master/doc/riegeli_records_file_format.md
// Any message in the file must be stored as google::protobuf::Any, and can be
// unpacked to the given Message.
template <typename Message>
absl::Status ReadRiegeliFile(absl::string_view path,
                             std::vector<Message>& messages) {
  riegeli::RecordReader reader(riegeli::FdReader(path, O_RDONLY));
  messages.clear();
  google::protobuf::Any any;
  while (reader.ReadRecord(any)) {
    if (!any.UnpackTo(&messages.emplace_back())) {
      messages.pop_back();
      if (!reader.Close()) {
        return reader.status();
      }
      return absl::InternalError(
          "Unable to parse the file to the given message.");
    }
    any.Clear();
  }
  if (!reader.Close()) {
    return reader.status();
  }
  return absl::OkStatus();
}

// Write the list of protobuf messages in @messages to the file with @path.
// Return error status if the writing fails.
// The details about the format of the output file can be found in
// https://github.com/google/riegeli/blob/master/doc/riegeli_records_file_format.md
// Any message in @messages is packed to google::protobuf::Any before written to
// the file.
template <typename Message>
absl::Status WriteRiegeliFile(absl::string_view path,
                              const std::vector<Message>& messages) {
  riegeli::RecordWriter writer(
      riegeli::FdWriter(path, O_WRONLY | O_CREAT | O_TRUNC));
  google::protobuf::Any any;
  for (const Message& message : messages) {
    if (!any.PackFrom(message)) {
      return absl::InternalError("Fails to serialize the input message.");
    }
    if (!writer.WriteRecord(any)) {
      writer.Close();
      return writer.status();
    }
    any.Clear();
  }
  if (!writer.Close()) {
    return writer.status();
  }
  return absl::OkStatus();
}

}  // namespace wfa

#endif  // SRC_MAIN_CC_COMMON_CPP_PROTOBUF_UTIL_RIEGELI_IO_H_
