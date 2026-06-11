cask "supermoan" do
  version "0.0.2"
  sha256 "d8ee946c453f6cf6becc4cd6ab8d3a06f33b36281fca4d5e8216a66c946736d5"

  url "https://github.com/KorigamiK/supermoan/releases/download/v#{version}/Supermoan-v#{version}-macos.zip"
  name "Supermoan"
  desc "Native C++ natural dictation"
  homepage "https://github.com/KorigamiK/supermoan"

  depends_on macos: :sonoma

  app "Supermoan.app"

  caveats do
    unsigned_accessibility
  end
end
