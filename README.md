<h1 align="center">
  <a href="https://github.com/grafanaKibana/LatexCV" title="LatexCV">
    <img alt="LatexCV" src="https://github.com/grafanaKibana/LatexCV/raw/master/icon.png" width="200px" height="200px" />
  </a>
  <br />
  LatexCV
</h1>

<p align="center">
  My personal résumé, CV and cover letter, built with LaTeX and published automatically on every merge to <code>master</code>.
</p>

<div align="center">
  <a href="https://github.com/grafanaKibana/LatexCV/actions/workflows/main.yml">
    <img alt="GitHub Actions" src="https://github.com/grafanaKibana/LatexCV/actions/workflows/main.yml/badge.svg" />
  </a>
  <a href="https://github.com/grafanaKibana/LatexCV/releases/latest">
    <img alt="Latest Release" src="https://img.shields.io/github/v/release/grafanaKibana/LatexCV?label=latest%20release" />
  </a>
</div>

<div align="center">
  <a href="https://github.com/grafanaKibana/LatexCV/releases/latest/download/resume.pdf">
    <img alt="Download Résumé" src="https://img.shields.io/badge/résumé-download%20pdf-green.svg" />
  </a>
  <a href="https://github.com/grafanaKibana/LatexCV/releases/latest/download/cv.pdf">
    <img alt="Download CV" src="https://img.shields.io/badge/cv-download%20pdf-green.svg" />
  </a>
  <a href="https://github.com/grafanaKibana/LatexCV/releases/latest/download/coverletter.pdf">
    <img alt="Download Cover Letter" src="https://img.shields.io/badge/cover%20letter-download%20pdf-green.svg" />
  </a>
</div>

<br />

## About

This repository holds my personal **résumé**, **CV (Curriculum Vitae)** and **cover letter**. It is a fork of [posquit0/Awesome-CV](https://github.com/posquit0/Awesome-CV) — the original LaTeX template — customized for my own profile.

The badges above always link to the freshest documents: every push to `master` compiles the LaTeX sources and publishes a new [GitHub Release](https://github.com/grafanaKibana/LatexCV/releases/latest) with `resume.pdf`, `cv.pdf` and `coverletter.pdf` attached. There is no need to dig through the Actions tab to find the latest build — just click a download badge.

## Download

The latest compiled documents are always available from the newest release:

| Document | Download |
| --- | --- |
| Résumé | [resume.pdf](https://github.com/grafanaKibana/LatexCV/releases/latest/download/resume.pdf) |
| CV | [cv.pdf](https://github.com/grafanaKibana/LatexCV/releases/latest/download/cv.pdf) |
| Cover Letter | [coverletter.pdf](https://github.com/grafanaKibana/LatexCV/releases/latest/download/coverletter.pdf) |

The `releases/latest/download/<file>` links resolve to the assets of the most recent release, so they never go stale.

## How to Build Locally

#### Requirements

A full TeX distribution is assumed.  [Various distributions for different operating systems (Windows, Mac, \*nix) are available](http://tex.stackexchange.com/q/55437) but TeX Live is recommended.
You can [install TeX from upstream](https://tex.stackexchange.com/q/1092) (recommended; most up-to-date) or use `sudo apt-get install texlive-full` if you really want that.  (It's generally a few years behind.)

If you don't want to install the dependencies on your system, this can also be obtained via [Docker](https://docker.com).

#### Usage

At a command prompt, run

```bash
make
```

This compiles all documents into the `compiled/` directory. To build a single document you can also run `xelatex` directly:

```bash
xelatex {your-cv}.tex
```

Or, without installing anything locally, using Docker:

```bash
docker run --rm --user $(id -u):$(id -g) -i -w "/doc" -v "$PWD":/doc texlive/texlive:latest make
```

In either case, this results in the creation of the corresponding ``.pdf`` files.

## Releases

Releases are produced automatically by the [Compile PDFs workflow](https://github.com/grafanaKibana/LatexCV/actions/workflows/main.yml):

1. On every push and pull request the LaTeX sources are compiled and uploaded as workflow artifacts.
2. On a push to `master`, the compiled PDFs are additionally attached to a new GitHub Release tagged `vYYYY.MM.DD-<run number>`.

## Credit

[**Original Repository — Awesome-CV**](https://github.com/posquit0/Awesome-CV) by posquit0, which this repository is forked from. This is a personal repository for my own profile.

**Awesome CV** is a LaTeX template for a **CV**, **Résumé** or **Cover Letter** inspired by [Fancy CV](https://www.sharelatex.com/templates/cv-or-resume/fancy-cv). It is easy to customize, especially since it is written with clean, semantic markup.

* [**Edit Résumé on OverLeaf.com**](https://www.overleaf.com/latex/templates/awesome-cv/tvmzpvdjfqxp)
* [**Edit Cover Letter on OverLeaf.com**](https://www.overleaf.com/latex/templates/awesome-cv-cover-letter/pfzzjspkthbk)

**_Note:_ The above services do not guarantee up-to-date source code of Awesome CV.**

[**LaTeX**](https://www.latex-project.org) is a fantastic typesetting program that a lot of people use these days, especially the math and computer science people in academia.

[**FontAwesome6 LaTeX Package**](https://github.com/braniii/fontawesome) is a LaTeX package that provides access to the [Font Awesome 6](https://fontawesome.com/v6/icons) icon set.

[**Roboto**](https://github.com/google/roboto) is the default font on Android and ChromeOS, and the recommended font for Google’s visual language, Material Design.

[**Source Sans Pro**](https://github.com/adobe-fonts/source-sans-pro) is a set of OpenType fonts that have been designed to work well in user interface (UI) environments.

## See Also

* [Awesome Identity](https://github.com/posquit0/hugo-awesome-identity) - A single-page Hugo theme to introduce yourself.
