class SioyekOpen < Formula
  desc "Open arXiv, web PDFs, and local PDFs in Sioyek from a bookmarklet"
  homepage "https://github.com/KorigamiK/sioyek-open"
  url "https://github.com/KorigamiK/sioyek-open/releases/download/v0.4.0/sioyek-open-0.4.0.tar.gz"
  sha256 "611012eb52b2ecd69a9106435ea2a70e1235449ac22da2d609eacb2a26c22845"
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
      Replace an older bookmark with the new button to capture page metadata.
      Index existing PDFs with: sioyek-open library scan

      Before uninstalling this formula, remove the per-user handler with:
        sioyek-open uninstall
      Saved PDFs, the local library and settings are kept.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sioyek-open --version")
    assert_match "sioyek-open://open?url=", shell_output("#{bin}/sioyek-open bookmarklet --print")
    assert_match '"schema_version": 1', shell_output("#{bin}/sioyek-open library export")
    assert_match "Use an arXiv", shell_output(
      "#{bin}/sioyek-open open --no-open ftp://example.com/paper.pdf 2>&1", 1
    )
  end
end
