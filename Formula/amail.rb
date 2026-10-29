class Amail < Formula
  desc "Fast Apple Mail CLI for humans and coding agents"
  homepage "https://github.com/KorigamiK/amail"
  url "https://github.com/KorigamiK/amail/releases/download/v0.1.1/amail-0.1.1.tar.gz"
  sha256 "4fd18306d73f84f252991613649c6a41a9364d3f59eb99d96539064af9454adb"
  license "MIT"

  depends_on "bun"
  depends_on :macos

  def install
    libexec.install "amail.js"
    pkgshare.install "skills"
    (bin/"amail").write_env_script formula_opt_bin("bun")/"bun", [opt_libexec/"amail.js"], {}
  end

  def caveats
    <<~EOS
      amail reads Mail's data in ~/Library/Mail, so your terminal app needs
      Full Disk Access (System Settings → Privacy & Security). macOS asks for
      Automation access to Mail the first time you run a write command.
      Email composition stops at a saved draft; review and send it manually in Mail.

      To let coding agents use amail, link the bundled skill:
        ln -s #{opt_pkgshare}/skills/amail ~/.agents/skills/amail
        ln -s #{opt_pkgshare}/skills/amail ~/.claude/skills/amail
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/amail --version")
    assert_match "search", shell_output("#{bin}/amail --help")
    assert_match "Unknown command", shell_output("#{bin}/amail bogus 2>&1", 2)
    assert_match 'Unknown command "send"', shell_output("#{bin}/amail send 2>&1", 2)
  end
end
