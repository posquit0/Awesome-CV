# Changelog

This file describes the current development line. It is not a reconstructed
history of numbered releases. The old class header still said `v1.6.1` from
2017 even after the changes below; development snapshots now identify themselves
as `development`. Use the Git commit to identify an exact snapshot.

## Unreleased

### Build and compatibility

- Require **LuaLaTeX with HarfBuzz** and use **latexmk** for local, editor, Docker,
  and CI builds. Run from the repository root; output goes to `build/`.
  XeLaTeX/pdfLaTeX are unsupported on this development line.
  ([#643](https://github.com/posquit0/Awesome-CV/pull/643))
- Use **Source Sans 3**, **Roboto**, and **Font Awesome 6**.
  Static font faces must be visible by family name. The former bundled-font
  directory and `\fontdir` setting no longer select fonts.
  ([font migration](https://github.com/posquit0/Awesome-CV/commit/6ce486222286092f068ab40697b832b25854ce2c),
  [Source Sans 3](https://github.com/posquit0/Awesome-CV/commit/852b04279f647506152f88879ebc71a9e1caf2a2),
  [bundled-font removal](https://github.com/posquit0/Awesome-CV/pull/403))
- Pin the reference Docker image and Debian archive; reuse tedilabs workflows
  for validation and repository automation. See
  [build-environment.md](docs/build-environment.md) for update procedures and the
  policy of following upstream workflow changes through `@main`.
- Add `make test` for PDF text, font, link, pagination, and focused layout checks,
  plus rendered pages and logs in CI artifacts.

### Rendering and document behavior

- Preserve spaces and bold weight in short section headings, including empty
  headings. ([#529](https://github.com/posquit0/Awesome-CV/pull/529))
- Correct the extra gap in single-item `cvitems` lists.
  ([#532](https://github.com/posquit0/Awesome-CV/pull/532))
- Skip the description row for a genuinely empty `{}` argument to `\cventry`.
  A whitespace-only `{ }` argument is still a separate open limitation.
  ([fix](https://github.com/posquit0/Awesome-CV/commit/e140258764fd635f05077394b43dbbb5250ea885),
  [#249](https://github.com/posquit0/Awesome-CV/issues/249))
- Preserve the scheme supplied to `\homepage`; include `https://` for a web URL.
  ([fix](https://github.com/posquit0/Awesome-CV/commit/404d6065fe0f3742e90df3c14ba82ab3f8c01911))
- Add WhatsApp links.
  ([#555](https://github.com/posquit0/Awesome-CV/pull/555))

### Migrating an older document

Select LuaLaTeX, install the current named static fonts and `fontawesome6`, and
build from the repository root with `latexmk`. Follow the README's separate
Overleaf steps instead of assuming the gallery template matches this checkout.
Compare line wrapping and page breaks after the font/engine migration.
Historical preview PDFs are not a current rendering baseline.
