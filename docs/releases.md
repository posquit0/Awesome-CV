# Version and release maintenance

Development snapshots are identified by their Git commit. The class currently
reports `2026/10/21 development`, replacing the stale `2017/02/05 v1.6.1`
identification. This metadata correction does not create a numbered release.
The date is the class identification update date, not the PDF's build date.

`CHANGELOG.md` keeps changes under **Unreleased** until a maintainer chooses and
publishes a version. There is no automatic package publishing, tag creation,
GitHub release, or Overleaf deployment in the current workflows. CI only
validates changes and uploads build artifacts; metadata jobs handle labels,
reviewer/assignee assignment, and first-contribution greetings.

## Adopting tedilabs release automation

The common validation and repository workflows follow the tedilabs Terraform
repositories. Their release workflow additionally calls
[`github.release-please`](https://github.com/tedilabs/github-actions/blob/main/.github/actions/github.release-please/action.yaml),
which requires:

- Repository access for a GitHub App with contents, issues, and pull-request
  write permissions, plus the `RELEASE_GITHUB_APP_CLIENT_ID` and
  `RELEASE_GITHUB_APP_PRIVATE_KEY` Actions secrets.
- A release-please configuration and manifest with an explicitly chosen initial
  version and changelog policy.
- Version/date updates for `\ProvidesClass`, coordinated with release notes.
  Terraform module release configuration does not update a LaTeX class.

These prerequisites must be configured before enabling that release workflow.
Until then, follow the manual process below; the shared validation and metadata
workflows need only `GITHUB_TOKEN`.

## Prepare a release PR

1. Choose the release version explicitly. Account for the LuaLaTeX-only engine
   requirement and named-font migration when describing compatibility.
2. Change `\ProvidesClass` in the root `awesome-cv.cls` to
   `[YYYY/MM/DD vX.Y.Z Awesome Curriculum Vitae Class]` using the release date
   and chosen version. Leave `examples/awesome-cv.cls` as a symlink.
3. Move the relevant Unreleased notes to an `X.Y.Z — YYYY-MM-DD` changelog
   section, retaining migration instructions and links to fixes. Keep an empty
   Unreleased section for subsequent work. Do not invent historical releases.
4. From a clean worktree, build the Docker environment and run `make test` in
   it. Review all pages, text extraction, links, and the JSON report. Record the
   Git commit, architecture, compiler/font versions, and CI run in the PR.
5. Decide whether to refresh committed previews. If refreshing, copy PDFs from
   `build/` and render the corresponding PNGs from those exact PDFs. Review the
   README's page labels and links together. The two historical cover-letter
   previews depict different variants, so one current PDF is not a replacement
   for both without updating their labels. Do not include personal material
   beyond the repository examples.
6. Verify README requirements, the contributor guide, changelog, and class
   metadata agree. Obtain normal maintainer review and merge the release PR.

## Publish after review

Create the `vX.Y.Z` tag on the reviewed commit, then publish a GitHub release
using the matching changelog notes. If attaching example PDFs, use artifacts
from that exact commit and record their build environment. Publishing is a
separate maintainer action; this checklist is not an automatic release job.

If updating the Overleaf gallery, upload and test it separately with LuaLaTeX
and the documented font faces. The gallery is maintained outside this
repository's CI. Record its update independently rather than claiming a GitHub
tag deployed it.

For the next development change, mark the class as `development` with the
appropriate identification date and put new notes under Unreleased. Do not
leave the previous release identifier on a materially changed development
class.
