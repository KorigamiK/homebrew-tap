class SioyekArxiv < Formula
  desc "Open arXiv PDFs in Sioyek from a browser bookmarklet"
  homepage "https://github.com/KorigamiK/sioyek-arxiv"
  url "https://github.com/KorigamiK/sioyek-arxiv/releases/download/v0.1.0/sioyek-arxiv-0.1.0.tar.gz"
  sha256 "3c815027d5ce41e0a63c32a026b7d159cb441330286938ab43f24c8b1b96cafd"
  license "GPL-3.0-only"

  depends_on :macos
  depends_on "python@3.15"

  def install
    libexec.install "sioyek_arxiv.py"
    (bin/"sioyek-arxiv").write_env_script formula_opt_bin("python@3.15")/"python3.15",
                                       [opt_libexec/"sioyek_arxiv.py"],
                                       SIOYEK_ARXIV_LAUNCHER: opt_bin/"sioyek-arxiv"
  end

  def caveats
    <<~EOS
      Install Sioyek separately, then create your per-user URL handler:
        sioyek-arxiv setup --browser Firefox

      Drag "Open in Sioyek" from the setup page to your bookmarks toolbar.
      Existing settings and downloaded papers are preserved.

      Before uninstalling this formula, remove the per-user handler with:
        sioyek-arxiv uninstall
      Saved PDFs and settings are kept.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sioyek-arxiv --version")
    assert_match "sioyek-arxiv://open?url=", shell_output("#{bin}/sioyek-arxiv bookmarklet --print")
    assert_match "Open an arXiv", shell_output(
      "#{bin}/sioyek-arxiv open --no-open https://example.com/abs/1706.03762 2>&1", 1
    )
  end
end
