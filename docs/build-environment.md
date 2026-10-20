# Build environment

The repository's `Dockerfile` is the reference for both local builds and the
Compile PDFs workflow. `latexmkrc` remains the shared compiler configuration.

| Input | Pin |
| --- | --- |
| TeX Live and base operating system | Multi-platform SHA-256 digest in `FROM` |
| Additional fonts, Make, and their dependencies | Dated Debian archive URL and suite in `Dockerfile` |
| Direct build actions | Full commit SHAs |
| tedilabs reusable workflows | `@main`, following upstream updates |
| Workflow validation tools | Explicit version inputs on the reusable workflows |
| GitHub runner OS | `ubuntu-24.04` (the hosted runner image still receives updates) |

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
4. Keep action SHAs and their version comments together. Dependabot checks
   Actions daily and the Docker digest weekly; review those PRs and rerun CI.
   The Debian snapshot date requires a separate, deliberate update.

## Shared GitHub automation

The repository calls the public
[`tedilabs/github-actions`](https://github.com/tedilabs/github-actions/tree/main)
workflows through `@main`:

| Local workflow | Shared workflow | Behavior |
| --- | --- | --- |
| `yaml.integration.yaml` | `yaml.yamllint.yaml` | YAML lint with the repository configuration |
| `github-actions.integration.yaml` | `github-actions.integration.yaml` | jactionlint, ShellCheck, and workflow schema validation |
| `pull-request-labeler.yaml` | `github.pr.auto-label.yaml` | Area labels and PR size labels |
| `welcome.yaml` | `github.issue.welcome.yaml` | Separate first-issue and first-PR greetings |
| `sync-labels.yaml` | `github.repo.sync-labels.yaml` | Read-only preview on PRs, updates on master; preserve other labels |

No organization secrets are needed. Metadata jobs receive only the necessary
permissions and `GITHUB_TOKEN`. `pull_request_target` is used only for labels and
greetings; these jobs do not check out or execute PR code. Build and validation
jobs run on `pull_request` with read-only repository permissions, including for
forks. Integration reports go to the job summary, without a PR comment.

Area rules in `.github/labeler.yaml` use labels declared in `.github/labels.yaml`.
The shared PR-size workflow counts changed files using its own defaults; unlike
the previous local action, it does not exclude examples, fonts, or image files.
The existing size thresholds remain 20/100/500/1000 lines.

The shared workflows intentionally track upstream `main`, including their nested
composite actions. Upstream changes can therefore affect automation without a
commit here. The TeX image and Debian package snapshot remain pinned separately.
YAML and GitHub Actions validation have separate workflow files, path filters,
and concurrency groups, following the tedilabs layout.

For local workflow checks, use the versions in `yaml.integration.yaml` and
`github-actions.integration.yaml`:

```sh
mise exec jactionlint@2.1.0 shellcheck@0.11.0 -- jactionlint --profile=correctness
uvx --from yamllint==1.38.0 yamllint --config-file .yamllint.yaml .
uvx --from check-jsonschema==0.38.2 check-jsonschema \
  --builtin-schema vendor.github-workflows .github/workflows/*.yaml .github/workflows/*.yml
```

Digest pinning follows [Docker's build guidance](https://docs.docker.com/build/building/best-practices/#pin-base-image-versions).
Archived APT metadata requires `check-valid-until=no`, as documented by
[Debian snapshot](https://snapshot.debian.org/); package signatures are still
verified. Pins receive no automatic security fixes until an update is merged.

This is a reproducible dependency baseline, not a promise of byte-identical
PDFs or container layers. Build timestamps, `\today`, processor architecture,
and the hosted runner image can still differ. Preserve the checkout commit and
the architecture when reporting a rendering problem.
