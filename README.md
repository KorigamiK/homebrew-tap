# Korigamik Tap

## Packages

| Package | Type | Description |
| --- | --- | --- |
| [`amail`](https://github.com/KorigamiK/amail) | Formula, macOS | Fast Apple Mail CLI for humans and coding agents. |
| [`focusclock`](https://github.com/KorigamiK/focusclock) | Formula, macOS | Native clock overlay that floats above all windows to help you focus. |
| [`researchpocket`](https://github.com/ResearchPocket/researchpocket.github.io) | Formula, macOS | Local-first personal library for saving, curating, and syncing URLs. |
| [`sioyek-open`](https://github.com/KorigamiK/sioyek-open) | Formula, macOS | Open arXiv papers, web PDFs, and local PDFs in Sioyek from a browser bookmarklet. |
| [`supermoan`](https://github.com/KorigamiK/supermoan) | Cask, macOS | Native C++ natural dictation. |

## FocusClock

Install and start the clock from Terminal:

```sh
brew install korigamik/tap/focusclock
focusclock -br -B 50
```

This places the clock in the bottom-right corner with a 50-point bottom margin.
Press Ctrl-C in that Terminal to stop it. FocusClock uses the primary display
and has no Dock icon or app window to open. Homebrew builds it from source,
so CMake and the Xcode Command Line Tools are required; Homebrew installs CMake
as a build dependency. Install the Command Line Tools with
`xcode-select --install` if needed.

See the [project documentation](https://github.com/KorigamiK/focusclock) for
positioning, fonts, colours and other options.

## ResearchPocket

Install the `research` CLI, create a library, and register the browser
capture handler:

```sh
brew install korigamik/tap/researchpocket
research init
research capture install
```

Create a bookmark named **Save to ResearchPocket** and paste the bookmarklet
into its URL field. Copy it with
`research capture bookmarklet | pbcopy`.
Click it on any web page to save that page locally. The handler lives in
`~/Applications/ResearchPocket Capture.app` and is bound to your library.

To keep the full page of every capture as Markdown, configure Firecrawl once:

```sh
printf '%s' "$FIRECRAWL_API_KEY" | \
  research enrich configure firecrawl --api-key-stdin
```

Run `research capture uninstall` before `brew uninstall researchpocket`; your
library is kept. See the
[project documentation](https://github.com/ResearchPocket/researchpocket.github.io)
for sync, the terminal UI, and the hosted owner app.

## Open in Sioyek

Install Sioyek separately, then run:

```sh
brew install korigamik/tap/sioyek-open
sioyek-open setup --browser Firefox
```

Drag **Open in Sioyek** from the setup page onto the bookmarks toolbar. Click it
on an arXiv page or a direct PDF URL. Web PDFs save to `~/Downloads/Papers`;
arXiv papers keep descriptive title-and-version names. Local `file://` PDFs
open at their existing location. If Firefox restricts bookmarklets in its PDF
viewer, copy the URL, click the bookmark on an ordinary web page, and paste it
into the prompt.

The local library stores metadata beside the PDFs in `library.sqlite3`. Replace
older bookmarks with the current setup button to capture citation metadata from
article pages. Use `sioyek-open library scan` to index existing PDFs,
`sioyek-open library list` to inspect the catalog and
`sioyek-open library export` to export JSON.

Use `sioyek-open setup --papers-dir ~/Documents/Papers` to choose a different
folder. See the [project documentation](https://github.com/KorigamiK/sioyek-open)
for setup, upgrades, and removal.

## How do I install these formulae?

`brew install korigamik/tap/<formula>`

Or `brew tap korigamik/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "korigamik/tap"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
