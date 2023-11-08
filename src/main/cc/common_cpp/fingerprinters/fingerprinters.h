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
#ifndef SRC_MAIN_CC_COMMON_CPP_FINGERPRINTERS_FINGERPRINTERS_H_
#define SRC_MAIN_CC_COMMON_CPP_FINGERPRINTERS_FINGERPRINTERS_H_

#include <cstdint>

#include "absl/strings/string_view.h"
#include "absl/types/span.h"

namespace wfa {

class Fingerprinter {
 public:
  virtual ~Fingerprinter() = default;

  virtual uint64_t Fingerprint(absl::Span<const unsigned char> item) const = 0;

  uint64_t Fingerprint(absl::string_view item) const {
    return Fingerprint(absl::MakeConstSpan(
        reinterpret_cast<const unsigned char*>(item.data()), item.size()));
  }
};

const Fingerprinter& GetSha256Fingerprinter();
Fingerprinter* GetSaltedSha256Fingerprinter(absl::string_view salt);
const Fingerprinter& GetFarmFingerprinter();
Fingerprinter* GetSaltedFarmFingerprinter(absl::string_view salt);
}  // namespace wfa

#endif  // SRC_MAIN_CC_COMMON_CPP_FINGERPRINTERS_FINGERPRINTERS_H_
