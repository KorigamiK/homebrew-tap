class Focusclock < Formula
  desc "Big clock that floats above all windows to help you focus"
  homepage "https://github.com/KorigamiK/focusclock"
  url "https://github.com/KorigamiK/focusclock/archive/refs/tags/v2.1.1.tar.gz"
  sha256 "cf11d71f56356726d4c68216434a3e1b0b976ab48ff2410c8c6df594911e8050"
  license "GPL-3.0-or-later"
  head "https://github.com/KorigamiK/focusclock.git", branch: "main"

  depends_on "cmake" => :build
  depends_on :macos

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      Start the clock from Terminal:
        focusclock -br -B 50
      Press Ctrl-C to stop it. On macOS the clock uses the primary display.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/focusclock --version")
    assert_match "--24-hour", shell_output("#{bin}/focusclock --help")
  end
end
