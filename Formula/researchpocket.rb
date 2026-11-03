class Researchpocket < Formula
  desc "Local-first personal library for saving, curating, and syncing URLs"
  homepage "https://researchpocket.github.io/"
  url "https://github.com/ResearchPocket/researchpocket.github.io/releases/download/v2.4.0/research-v2.4.0-macos-arm64.tar.gz"
  sha256 "efc641868126a909f1b42833fad8dd0b36890e9b42ff3d51a75e410edd80782d"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :macos

  on_macos do
    on_intel do
      url "https://github.com/ResearchPocket/researchpocket.github.io/releases/download/v2.4.0/research-v2.4.0-macos-amd64.tar.gz"
      sha256 "9390a8661f679af1a188594c94a17353d17d62782bb500e6f288cf65b16b3d03"
    end
  end

  def install
    bin.install "research"
  end

  def caveats
    <<~EOS
      Create a library (or connect an existing one with `research sync connect`):
        research init

      Save links from your browser: register the capture handler, then paste
      the copied bookmarklet into a new bookmark's URL field:
        research capture install
        research capture bookmarklet | pbcopy

      To keep the full page of every capture as Markdown with Firecrawl:
        printf '%s' "$FIRECRAWL_API_KEY" | research enrich configure firecrawl --api-key-stdin

      The handler keeps working across `brew upgrade`. One installed by
      ResearchPocket 2.3.0 or earlier needs `research capture install` once.
      Before uninstalling, remove the handler with:
        research capture uninstall
      Your library and settings are kept.
    EOS
  end

  test do
    assert_match "research #{version}", shell_output("#{bin}/research --version")
    library = testpath/"library"
    system bin/"research", "--data-dir", library, "init", "--format", "json"
    system bin/"research", "--data-dir", library, "add", "https://example.com/brew", "--format", "json"
    assert_match "https://example.com/brew",
                 shell_output("#{bin}/research --data-dir #{library} list --format json")
    assert_match "invalid capture URI",
                 shell_output("#{bin}/research --data-dir #{library} capture handle -- " \
                              "researchpocket://capture?version=9 2>&1", 1)
  end
end
