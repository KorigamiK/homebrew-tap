class SioyekOpen < Formula
  desc "Open arXiv, web PDFs, and local PDFs in Sioyek from a bookmarklet"
  homepage "https://github.com/KorigamiK/sioyek-open"
  url "https://github.com/KorigamiK/sioyek-open/releases/download/v0.3.0/sioyek-open-0.3.0.tar.gz"
  sha256 "79c8daeffa57cf6e2eac1dcd7ffeffeef8758008c97e77e03704e356167d5740"
  license "GPL-3.0-only"

  depends_on :macos
  depends_on "python@3.15"

  def install
    libexec.install "sioyek_open.py"
    (bin/"sioyek-open").write_env_script formula_opt_bin("python@3.15")/"python3.15",
                                       [opt_libexec/"sioyek_open.py"],
                                       SIOYEK_OPEN_LAUNCHER: opt_bin/"sioyek-open"
  end

  def caveats
    <<~EOS
      Install Sioyek separately, then create your per-user URL handler:
        sioyek-open setup --browser Firefox

      Drag "Open in Sioyek" from the setup page to your bookmarks toolbar.
      Replace an old arXiv-only bookmark with the new button to enable other PDFs.

      Before uninstalling this formula, remove the per-user handler with:
        sioyek-open uninstall
      Saved PDFs and settings are kept.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sioyek-open --version")
    assert_match "sioyek-open://open?url=", shell_output("#{bin}/sioyek-open bookmarklet --print")
    assert_match "Use an arXiv", shell_output(
      "#{bin}/sioyek-open open --no-open ftp://example.com/paper.pdf 2>&1", 1
    )
  end
end
