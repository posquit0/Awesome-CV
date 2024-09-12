# My Personal Cirriculum Vitae

I use the template provided by [@posquit0](https://github.com/posquit0).

I leave the banner in this README as a hyperlink to the original template for anyone who wants to fork:

<h1 align="center">
  <a href="https://github.com/posquit0/Awesome-CV" title="AwesomeCV Documentation">
    <img alt="AwesomeCV" src="https://github.com/posquit0/Awesome-CV/raw/master/icon.png" width="200px" height="200px" />
  </a>
  <br />
  Awesome CV
</h1>

<p align="center">
  LaTeX template for your outstanding job application
</p>


<br />

## Requirements

A full TeX distribution is assumed.  [Various distributions for different operating systems (Windows, Mac, \*nix) are available](http://tex.stackexchange.com/q/55437) but TeX Live is recommended.
You can [install TeX from upstream](https://tex.stackexchange.com/q/1092) (recommended; most up-to-date) or use `sudo apt-get install texlive-full` if you really want that.  (It's generally a few years behind.)

If you don't want to install the dependencies on your system, this can also be obtained via [Docker](https://docker.com).

## Usage

This Makefile is designed to help you quickly generate personal documents (such as your CV, resume, and cover letter) as well as example documents for demonstration purposes. Below are the available modes and commands you can use.

### 1. Generate Personal Documents (Default Mode)

By default, running `make` will generate your personal CV, resume, and cover letter.

#### Command:
```bash
make
```

#### Output:
- `cv.pdf` – Your personal CV.
- `resume.pdf` – Your personal resume.
- `coverletter.pdf` – Your personal cover letter.

You can also generate these files individually:

- To generate only your CV:
  ```bash
  make cv
  ```

- To generate only your resume:
  ```bash
  make resume
  ```

- To generate only your cover letter:
  ```bash
  make coverletter
  ```

### 2. Generate Example Documents

You can also generate example CV, resume, and cover letter files located in the `examples` directory by running the following command:

#### Command:
```bash
make examples
```

#### Output:
- `examples/cv.pdf` – Example CV.
- `examples/resume.pdf` – Example resume.
- `examples/coverletter.pdf` – Example cover letter.

### 3. Clean Up Generated Files

If you want to remove all generated PDF files (both personal and example), you can use the `clean` command.

#### Command:
```bash
make clean
```


## Credit

[**LaTeX**](https://www.latex-project.org) is a fantastic typesetting program that a lot of people use these days, especially the math and computer science people in academia.

[**LaTeX FontAwesome**](https://github.com/furl/latex-fontawesome) is bindings for FontAwesome icons to be used in XeLaTeX.

[**Roboto**](https://github.com/google/roboto) is the default font on Android and ChromeOS, and the recommended font for Google’s visual language, Material Design.

[**Source Sans Pro**](https://github.com/adobe-fonts/source-sans-pro) is a set of OpenType fonts that have been designed to work well in user interface (UI) environments.
