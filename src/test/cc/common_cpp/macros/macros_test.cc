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

#include "common_cpp/macros/macros.h"

#include "absl/status/status.h"
#include "absl/status/statusor.h"
#include "common_cpp/testing/status_matchers.h"
#include "gtest/gtest.h"

namespace wfa {
namespace {
TEST(MacrosTest, ReturnIfError) {
  auto run = [](absl::Status status) -> absl::StatusOr<int> {
    RETURN_IF_ERROR(status);
    return 5;
  };

  EXPECT_THAT(run(absl::OkStatus()), IsOkAndHolds(5));

  absl::Status error = absl::InternalError("Something went wrong");
  EXPECT_THAT(run(error).status(),
              StatusIs(error.code(), std::string(error.message())));
}

TEST(MacrosTest, AssignOrReturnInt) {
  auto run = [](absl::StatusOr<int>&& status_or) -> absl::StatusOr<int> {
    ASSIGN_OR_RETURN(int x, status_or);
    return x + 1;
  };

  EXPECT_THAT(run(5), IsOkAndHolds(6));

  absl::Status error = absl::InternalError("Something went wrong");
  EXPECT_THAT(run(error).status(),
              StatusIs(error.code(), std::string(error.message())));
}

struct MoveOrCopyHelper {
  MoveOrCopyHelper() = default;

  MoveOrCopyHelper(MoveOrCopyHelper&&) { moved = true; }
  MoveOrCopyHelper& operator=(MoveOrCopyHelper&&) {
    moved = true;
    return *this;
  }

  MoveOrCopyHelper(const MoveOrCopyHelper&) { copied = true; }
  MoveOrCopyHelper& operator=(const MoveOrCopyHelper&) {
    copied = true;
    return *this;
  }

  bool moved = false;
  bool copied = false;
};

TEST(MacrosTest, AssignOrReturnMoves) {
  auto run = [](absl::StatusOr<MoveOrCopyHelper>&& status_or)
      -> absl::StatusOr<MoveOrCopyHelper> {
    ASSIGN_OR_RETURN(MoveOrCopyHelper helper, status_or);
    return helper;
  };

  absl::StatusOr<MoveOrCopyHelper> helper = run(MoveOrCopyHelper());
  ASSERT_THAT(helper, IsOk());
  EXPECT_TRUE(helper->moved);
  EXPECT_FALSE(helper->copied);
}

TEST(MacrosTest, AssignOrReturnError) {
  auto run = [](absl::StatusOr<int>&& status_or) -> absl::StatusOr<int> {
    ASSIGN_OR_RETURN_ERROR(int x, status_or, "New error message");
    return x + 1;
  };

  EXPECT_THAT(run(5), IsOkAndHolds(6));

  absl::Status error = absl::InternalError("Something went wrong");
  EXPECT_THAT(run(error).status(), StatusIs(absl::StatusCode::kInvalidArgument,
                                            "New error message"));
}

}  // namespace
}  // namespace wfa
