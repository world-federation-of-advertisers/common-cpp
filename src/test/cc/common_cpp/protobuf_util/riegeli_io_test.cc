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

#include "common_cpp/protobuf_util/riegeli_io.h"

#include <cstdio>
#include <string>
#include <vector>

#include "absl/status/status.h"
#include "common_cpp/protobuf_util/riegeli_io_test.pb.h"
#include "common_cpp/testing/common_matchers.h"
#include "common_cpp/testing/status_matchers.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

namespace wfa {
namespace {

using ::testing::ElementsAre;
using ::wfa::test::RiegeliIoTestProto1;
using ::wfa::test::RiegeliIoTestProto2;

TEST(RiegeliIoTest, WriteAndRead) {
  RiegeliIoTestProto1 message_1;
  message_1.set_a(1);
  RiegeliIoTestProto1 message_2;
  message_2.set_a(2);
  RiegeliIoTestProto1 message_3;
  message_3.set_a(3);
  std::vector<RiegeliIoTestProto1> messages = {message_1, message_2, message_3};

  std::string filename = std::tmpnam(nullptr);

  EXPECT_THAT(WriteRiegeliFile<RiegeliIoTestProto1>(filename, messages),
              IsOk());

  std::vector<RiegeliIoTestProto1> read_messages;
  EXPECT_THAT(ReadRiegeliFile<RiegeliIoTestProto1>(filename, read_messages),
              IsOk());

  EXPECT_THAT(read_messages,
              ElementsAre(EqualsProto(message_1), EqualsProto(message_2),
                          EqualsProto(message_3)));

  ASSERT_EQ(std::remove(filename.c_str()), 0)
      << "Unable to remove file: " << filename;
}

TEST(RiegeliIoTest, ReadAndClearExistingMessages) {
  RiegeliIoTestProto1 message_1;
  message_1.set_a(1);
  RiegeliIoTestProto1 message_2;
  message_2.set_a(2);
  RiegeliIoTestProto1 message_3;
  message_3.set_a(3);
  std::vector<RiegeliIoTestProto1> messages = {message_1, message_2, message_3};

  std::string filename = std::tmpnam(nullptr);

  EXPECT_THAT(WriteRiegeliFile<RiegeliIoTestProto1>(filename, messages),
              IsOk());

  RiegeliIoTestProto1 message_4;
  message_4.set_a(4);
  std::vector<RiegeliIoTestProto1> read_messages = {message_4};
  EXPECT_THAT(ReadRiegeliFile<RiegeliIoTestProto1>(filename, read_messages),
              IsOk());

  EXPECT_THAT(read_messages,
              ElementsAre(EqualsProto(message_1), EqualsProto(message_2),
                          EqualsProto(message_3)));

  ASSERT_EQ(std::remove(filename.c_str()), 0)
      << "Unable to remove file: " << filename;
}

TEST(RiegeliIoTest, ReadWrongProto) {
  RiegeliIoTestProto2 message;
  message.set_a(1);
  std::vector<RiegeliIoTestProto2> messages = {message};

  std::string filename = std::tmpnam(nullptr);

  EXPECT_THAT(WriteRiegeliFile<RiegeliIoTestProto2>(filename, messages),
              IsOk());

  std::vector<RiegeliIoTestProto1> read_messages;
  EXPECT_THAT(ReadRiegeliFile<RiegeliIoTestProto1>(filename, read_messages),
              StatusIs(absl::StatusCode::kInternal,
                       "Unable to parse the file to the given message."));

  ASSERT_EQ(std::remove(filename.c_str()), 0)
      << "Unable to remove file: " << filename;
}

}  // namespace
}  // namespace wfa
