# Korigamik Tap

## Packages

| Package | Type | Description |
| --- | --- | --- |
| [`amail`](https://github.com/KorigamiK/amail) | Formula, macOS | Fast Apple Mail CLI for humans and coding agents. |
| [`focusclock`](https://github.com/KorigamiK/focusclock) | Formula, macOS | Native clock overlay that floats above all windows to help you focus. |
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
