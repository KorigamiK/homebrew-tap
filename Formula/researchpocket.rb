class Researchpocket < Formula
  desc "Local-first personal library for saving, curating, and syncing URLs"
  homepage "https://researchpocket.github.io/"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ResearchPocket/researchpocket.github.io/releases/download/v2.3.0/research-v2.3.0-macos-arm64.tar.gz"
      sha256 "b989b1ae4feb79f449e03de76dc9fa240b7cd61a34e9263fb13dbf2455192783"
    end
    on_intel do
      url "https://github.com/ResearchPocket/researchpocket.github.io/releases/download/v2.3.0/research-v2.3.0-macos-amd64.tar.gz"
      sha256 "df2c173a5d1b777d6859ae0967747a58542a5f78fba6494f396554875b67b2a8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ResearchPocket/researchpocket.github.io/releases/download/v2.3.0/research-v2.3.0-linux-amd64.tar.gz"
      sha256 "0b4853732fe9b5e9729aa93f95d5d1a0d1a2b8c0232cfd070740b6b07270e39d"
    end
  end

  def install
    bin.install "research"
  end

  def caveats
    <<~EOS
      Create a library (or connect an existing one with `research sync connect`):
        research init

      Save links from your browser by registering the capture handler and
      copying the bookmarklet into a new bookmark's URL field:
        research capture install
        curl -fsSL https://raw.githubusercontent.com/ResearchPocket/researchpocket.github.io/v#{version}/bookmarklet.js | pbcopy

      To keep the full page of every capture as Markdown with Firecrawl:
        printf '%s' "$FIRECRAWL_API_KEY" | research enrich configure firecrawl --api-key-stdin --on-capture

      If the capture handler was installed by ResearchPocket 2.3.0 or earlier,
      run `research capture install` once more after `brew upgrade`.
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
