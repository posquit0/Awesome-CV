# Build environment

The repository's `Dockerfile` is the reference for both local builds and the
Compile PDFs workflow. `latexmkrc` remains the shared compiler configuration.

| Input | Pin |
| --- | --- |
| TeX Live and base operating system | Multi-platform SHA-256 digest in `FROM` |
| Additional fonts, Make, and their dependencies | Dated Debian archive URL and suite in `Dockerfile` |
| Direct build actions | Major version tags, maintained by Dependabot |
| tedilabs reusable workflows | `@main`, following upstream updates |
| Workflow validation tools | tedilabs workflow defaults (`latest` where specified) |
| GitHub runner OS | `ubuntu-latest`, following the tedilabs convention |

The base image supplies TeX Live 2026, LuaHBTeX 1.24.0, and latexmk 4.88.
The snapshot supplies Source Sans 3 3.052 and Roboto 3.016. Both Linux amd64
and arm64 are supported by the pinned image index; CI uses amd64.

## Reproduce and inspect

Run from the repository root:

```sh
docker build --pull --tag awesome-cv .
docker run --rm --user "$(id -u):$(id -g)" --volume "$PWD:/doc" awesome-cv
docker run --rm awesome-cv sh -c \
  'lualatex --version; latexmk -v; dpkg-query -W fonts-adobe-sourcesans3 fonts-roboto make'
```

To match the CI architecture on an ARM machine, add `--platform linux/amd64`
to both `docker build` and `docker run`. Native TeX Live and Overleaf are useful
alternatives, but their independently managed packages are not this baseline.
Use a clean checkout or `make distclean` before comparing builds.

## Update deliberately

1. Resolve the candidate image with
   `docker buildx imagetools inspect texlive/texlive:latest`. Replace the **index**
   digest in `Dockerfile`, preserving amd64 and arm64 support.
2. Review its Debian release before choosing a compatible dated
   [Debian snapshot](https://snapshot.debian.org/). Update the archive URL and
   suite together when needed. Do not replace the archive with a rolling mirror.
3. Build with `docker build --pull --no-cache --tag awesome-cv .`, compile all
   examples from a clean output directory, and inspect their PDFs. Record the
   old and new compiler/font versions and any pagination or layout changes in
   the PR.
4. Dependabot checks action version tags daily and the Docker digest weekly;
   review those PRs and rerun CI.
   The Debian snapshot date requires a separate, deliberate update.

## Shared GitHub automation

The repository calls the public
[`tedilabs/github-actions`](https://github.com/tedilabs/github-actions/tree/main)
workflows through `@main`:

| Local workflow | Shared workflow | Behavior |
| --- | --- | --- |
| `yaml.integration.yaml` | `yaml.yamllint.yaml` | YAML lint with the repository configuration |
| `github-actions.integration.yaml` | `github-actions.integration.yaml` | jactionlint, ShellCheck, and workflow schema validation |
| `github.pr.yaml` | `github.pr.auto-assign.yaml` | Assign the author and request a maintainer review |
| `github.pr.yaml` | `github.pr.auto-label.yaml` | Area labels and PR size labels |
| `github.pr.yaml`, `github.issue.yaml` | `github.issue.welcome.yaml` | Separate first-issue and first-PR greetings |
| `github.repo.yaml` | `github.repo.sync-labels.yaml` | Preview on PRs, updates on master; preserve other labels |

These callers follow the layout used by
[`tedilabs/terraform-aws-network`](https://github.com/tedilabs/terraform-aws-network/tree/main/.github/workflows),
with `master` as this repository's default branch, English greetings, and the
existing CODEOWNERS as reviewer candidates. `ubuntu-latest`, validation tool
versions, and PR-size thresholds use the shared defaults. The LaTeX build remains
project-specific and runs inside the pinned Docker environment.

No organization secrets are needed for these workflows; they use `GITHUB_TOKEN`.
`pull_request_target` is used for PR metadata only and does not execute PR code.
Build and validation run on `pull_request`. The shared Actions integration posts
a report comment when permitted; on fork PRs, GitHub restricts the token to read
access and the shared reporting action tolerates inability to post a comment.

Project area labels are in `.github/labels.yaml`; common labels follow tedilabs
in `.github/labels.common.yaml`. The label-sync matrix previews both files on PRs
and applies them after merge, preserving labels not listed in either file.
The shared PR-size workflow uses its own counting defaults, including the
15/100/500/1000 thresholds, without the previous exclusions for examples/fonts.

The shared workflows intentionally track upstream `main`, including their nested
composite actions. Tool and runner defaults also follow upstream. Automation can
therefore change without a commit here; the TeX image and Debian package
snapshot remain pinned separately. YAML and GitHub Actions validation have
separate files, path filters, and concurrency groups.

For local workflow checks, the commands below use the current shared conventions.
Consult the CI job log and upstream workflow for exact versions when reproducing
a lint failure; these tools are intentionally not locked in this repository.

```sh
mise exec jactionlint@2.1.0 shellcheck@latest -- jactionlint --profile=correctness
uvx yamllint --config-file .yamllint.yaml .
uvx check-jsonschema --builtin-schema vendor.github-workflows \
  .github/workflows/*.yaml .github/workflows/*.yml
```

Digest pinning follows [Docker's build guidance](https://docs.docker.com/build/building/best-practices/#pin-base-image-versions).
Archived APT metadata requires `check-valid-until=no`, as documented by
[Debian snapshot](https://snapshot.debian.org/); package signatures are still
verified. Pins receive no automatic security fixes until an update is merged.

This is a reproducible dependency baseline, not a promise of byte-identical
PDFs or container layers. Build timestamps, `\today`, processor architecture,
and the hosted runner image can still differ. Preserve the checkout commit and
the architecture when reporting a rendering problem.
