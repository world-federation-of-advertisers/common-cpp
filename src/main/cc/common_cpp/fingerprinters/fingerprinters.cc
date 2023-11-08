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

#include "common_cpp/fingerprinters/fingerprinters.h"

#include <string>

#include "absl/base/internal/endian.h"
#include "openssl/sha.h"
#include "src/farmhash.h"

namespace wfa {
namespace {
class Sha256Fingerprinter : public Fingerprinter {
 private:
  std::string salt;

 public:
  explicit Sha256Fingerprinter(absl::string_view salt = "") {
    this->salt = salt;
  }
  ~Sha256Fingerprinter() override = default;

  uint64_t Fingerprint(absl::Span<const unsigned char> item) const override {
    SHA256_CTX context;
    uint8_t digest[32];
    memset(digest, 0, sizeof(digest));

    SHA256_Init(&context);
    if (!salt.empty()) {
      std::string salted_item(item.begin(), item.end());
      salted_item += salt;
      SHA256_Update(&context, salted_item.data(), salted_item.size());
    } else {
      SHA256_Update(&context, item.data(), item.size());
    }
    SHA256_Final(digest, &context);

    return absl::little_endian::Load64(digest);
  }
};

class FarmFingerprinter : public Fingerprinter {
 private:
  std::string salt;

 public:
  explicit FarmFingerprinter(absl::string_view salt = "") { this->salt = salt; }
  ~FarmFingerprinter() override = default;

  uint64_t Fingerprint(absl::Span<const unsigned char> item) const override {
    if (!salt.empty()) {
      std::string salted_item(item.begin(), item.end());
      salted_item += salt;
      return util::Fingerprint64(salted_item.data(), salted_item.size());
    }
    return util::Fingerprint64(reinterpret_cast<const char*>(item.data()),
                               item.size());
  }
};
}  // namespace

const Fingerprinter& GetSha256Fingerprinter() {
  static const auto* const fingerprinter = new Sha256Fingerprinter();
  return *fingerprinter;
}

std::unique_ptr<Fingerprinter> GetSaltedSha256Fingerprinter(
    absl::string_view salt) {
  return std::make_unique<Sha256Fingerprinter>(salt);
}

const Fingerprinter& GetFarmFingerprinter() {
  static const auto* const fingerprinter = new FarmFingerprinter();
  return *fingerprinter;
}

std::unique_ptr<Fingerprinter> GetSaltedFarmFingerprinter(
    absl::string_view salt) {
  return std::make_unique<FarmFingerprinter>(salt);
}
}  // namespace wfa
