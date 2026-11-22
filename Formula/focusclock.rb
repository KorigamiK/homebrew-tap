class Focusclock < Formula
  desc "Big clock that floats above all windows to help you focus"
  homepage "https://github.com/KorigamiK/focusclock"
  url "https://github.com/KorigamiK/focusclock/archive/refs/tags/v2.2.0.tar.gz"
  sha256 "c578a10d56a76a60ed52e85e206c4788bb5daae2857c9dd36ff70b411c72afde"
  license "GPL-3.0-or-later"
  head "https://github.com/KorigamiK/focusclock.git", branch: "main"

  depends_on "cmake" => :build
  depends_on :macos

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  service do
    run opt_bin/"focusclock"
    error_log_path var/"log/focusclock.log"
  end

  def caveats
    <<~EOS
      Start the clock from Terminal:
        focusclock -br -B 50
      Press Ctrl-C to stop it. On macOS the clock uses the primary display
      unless you pass --monitor secondary.

      The service runs focusclock without options, so it reads them from
      ~/.config/focusclock/config. Save the options you like there first:
        mkdir -p ~/.config/focusclock
        echo "-br -B 50" > ~/.config/focusclock/config
      After editing that file, apply it with:
        brew services restart focusclock
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/focusclock --version")
    assert_match "--24-hour", shell_output("#{bin}/focusclock --help")
    (testpath/"focusclock/config").write "# options\n--version\n"
    with_env(XDG_CONFIG_HOME: testpath) do
      assert_match version.to_s, shell_output(bin/"focusclock")
    end
  end
end
