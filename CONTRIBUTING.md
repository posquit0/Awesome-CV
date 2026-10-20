# Contributing to Awesome CV

Start with the [README](README.md) for installation and document customization.
Use LuaLaTeX with HarfBuzz through the repository's `latexmkrc`.

## Source layout

| Path | Responsibility |
| --- | --- |
| `awesome-cv.cls` | Class implementation and development/release identification |
| `examples/awesome-cv.cls` | Symlink to the root class; never maintain a second copy |
| `examples/{resume,cv,coverletter}.tex` | Main documents, compiled from the repository root |
| `examples/{resume,cv}/` | Content fragments included by the main documents |
| `latexmkrc`, `Makefile` | Compiler configuration and build/test entry points |
| `Dockerfile` | Reference TeX, font, and PDF inspection environment |
| `luaotfload.conf` | Discovery of static fonts placed in the working directory |
| `.vscode/` | Editor configuration using the shared build recipe |
| `tests/` | Focused fixtures and PDF assertions |
| `.github/` | CI callers, dependency updates, and repository metadata automation |
| `build/` | Ignored PDFs, logs, test results, and rendered review images |
| `examples/*.pdf`, `examples/*.png` | Committed historical previews; updated deliberately |

Fonts are resolved by family name. `\fontdir` remains accepted for old documents
but does not change font discovery. Install static Source Sans 3 and Roboto
faces or place them at the repository root as described in the README.

## Validate a change

Run from the repository root:

```sh
docker build --tag awesome-cv .
docker run --rm --user "$(id -u):$(id -g)" --volume "$PWD:/doc" awesome-cv make test
```

The [test guide](tests/README.md) explains the assertions and native Python
dependency. Inspect `build/quality/*.png` and the generated PDFs for typography,
clipping, spacing, and page breaks. Automated text checks do not certify ATS
compatibility or accessibility. Existing box warnings are recorded in
`build/quality/report.json`; compare them when changing layout.

For a bug fix, add a small fixture and an assertion that fails with the old
behavior. Keep unrelated formatting and example-content edits out of the PR.
When changing example content intentionally, review pagination before updating
page-count expectations. Do not regenerate historical previews incidentally.

For workflow changes, run the local lint commands in
[the build environment guide](docs/build-environment.md). Keep build commands,
editor settings, CI, and user documentation aligned. Describe dependency
updates and observed layout changes in the PR. See the same guide for how the
public tedilabs workflows are called and their permissions.

## Report a problem

Search existing issues and PRs, including closed ones, and link related reports.
Provide:

- The Git commit or release, OS, CPU architecture, and build command.
- Whether the problem occurs with the repository's Docker image, native TeX, or
  Overleaf; include `lualatex --version` and `latexmk -v` for native builds.
- A minimal `.tex` file, the relevant `.log` output, and expected versus actual
  behavior. Remove private contact details before sharing documents or logs.
- A screenshot for visual problems, and a copied-text example for extraction
  problems. A screenshot alone cannot reproduce a compiler error.

Reproduce with the reference Docker environment when possible. Engine/font
differences matter; an old XeLaTeX log does not describe the current class.

## Changes and releases

Add user-visible changes and migration notes under **Unreleased** in
[CHANGELOG.md](CHANGELOG.md). Keep the class metadata and release information
consistent using [the release guide](docs/releases.md). A merged PR or successful
CI run does not publish a release or refresh the Overleaf gallery.
