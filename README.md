<h1 align="center">
  <a href="https://github.com/laeberkaes/Awesome-CV" title="AwesomeCV Documentation">
    <img alt="AwesomeCV" src="https://github.com/laeberkaes/Awesome-CV//raw/master/icon_fork.png" width="200px" height="200px" />
  </a>
  <br />
  Awesome CV
</h1>

<p align="center">
  LaTeX template for your outstanding job application
</p>

## Fork of Awesome CV

This is a [**fork of the original Awesome CV repository**](https://github.com/posquit0/Awesome-CV). I will implement some of my own needs. If you have some pull requests, I will merge them, if I find them productive, as the author is not maintaining the project very active.

## What is Awesome CV?

**Awesome CV** is LaTeX template for a **CV(Curriculum Vitae)**, **Résumé** or **Cover Letter** inspired by [Fancy CV](https://www.sharelatex.com/templates/cv-or-resume/fancy-cv). It is easy to customize your own template, especially since it is really written by a clean, semantic markup.

## Preview

#### Curriculum Vitae

View [PDF](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/cv.pdf)

| Page 1 | Page 2 |
|:---:|:---:|
| [![Résumé](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/cv0.png)](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/cv.pdf)  | [![Résumé](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/cv1.png)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/cv.pdf) |

#### Résumé

View [PDF](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/resume.pdf)

| Page 1 | Page 2 |
|:---:|:---:|
| [![Résumé](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/resume0.png)](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/resume.pdf)  | [![Résumé](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/resume1.png)](https://raw.githubusercontent.com/posquit0/Awesome-CV/master/examples/resume.pdf) |

#### Cover Letter

View [PDF](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/coverletter.pdf)

| Page 1 | Page 2 |
|:---:|:---:|
| [![Cover Letter(Traditional)](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/coverletter0.png)](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/coverletter.pdf)  | [![Cover Letter(Awesome)](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/coverletter1.png)](https://raw.githubusercontent.com/laeberkaes/Awesome-CV/master/examples/coverletter.pdf) |

## How to Use

#### Requirements

A full TeX distribution is assumed.  [Various distributions for different operating systems (Windows, Mac, \*nix) are available](http://tex.stackexchange.com/q/55437) but TeX Live is recommended.
You can [install TeX from upstream](http://tex.stackexchange.com/q/1092) (recommended; most up-to-date) or use `sudo apt-get install texlive-full` if you really want that.  (It's generally a few years behind.)

#### Usage

At a command prompt, run

```bash
$ xelatex {your-cv}.tex
```

This should result in the creation of ``{your-cv}.pdf``

##### List of Publications

You can generate list of publication from [**BibTeX**](http://www.bibtex.org/) source files.
[**BibLaTeX**](https://www.ctan.org/pkg/biblatex) and [**biber**](https://www.ctan.org/pkg/biber) should be available.

To generate document with the list of publications, at a command prompt, run

```bash
$ xelatex {your-cv}.tex
$ biber {your-cv}
$ xelatex {your-cv}.tex
```

## Credit

[**LaTeX**](http://www.latex-project.org) is a fantastic typesetting program that a lot of people use these days, especially the math and computer science people in academia.

[**LaTeX FontAwesome**](https://github.com/furl/latex-fontawesome) is bindings for FontAwesome icons to be used in XeLaTeX.

[**Roboto**](https://github.com/google/roboto) is the default font on Android and ChromeOS, and the recommended font for Google’s visual language, Material Design.

[**Source Sans Pro**](https://github.com/adobe-fonts/source-sans-pro) is a set of OpenType fonts that have been designed to work well in user interface (UI) environments.

[**posquit0**](https://github.com/posquit0) has created this project.
