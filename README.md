# Korigamik Tap

## Packages

| Package | Type | Description |
| --- | --- | --- |
| [`amail`](https://github.com/KorigamiK/amail) | Formula, macOS | Fast Apple Mail CLI for humans and coding agents. |
| [`sioyek-arxiv`](https://github.com/KorigamiK/sioyek-arxiv) | Formula, macOS | Save arXiv papers with descriptive filenames and open them in Sioyek from a browser bookmarklet. |
| [`supermoan`](https://github.com/KorigamiK/supermoan) | Cask, macOS | Native C++ natural dictation. |

## arXiv → Sioyek

Install Sioyek separately, then run:

```sh
brew install korigamik/tap/sioyek-arxiv
sioyek-arxiv setup --browser Firefox
```

Drag **Open in Sioyek** from the setup page onto the bookmarks toolbar. Click it
on an arXiv abstract or HTML page to save the PDF into `~/Downloads/Papers` with
its title and version, then open it in Sioyek.

Existing installations retain their settings and bookmarklet URL. Use
`sioyek-arxiv setup --papers-dir ~/Documents/Papers` to choose a different
folder. See the [project documentation](https://github.com/KorigamiK/sioyek-arxiv)
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
