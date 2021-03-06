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

#include "common_cpp/testing/random.h"

#include "absl/random/distributions.h"
#include "absl/random/random.h"

namespace wfa {

int64_t RandomInt64(int64_t max) {
  static absl::BitGen bit_gen;
  return absl::Uniform<int64_t>(absl::IntervalClosed, bit_gen, 0, max);
}

}  // namespace wfa
