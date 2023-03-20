# The Tufte-LaTeX Classes

Welcome to the beginnings of Tufte-LaTeX package to help you
produce Tufte-style handouts, reports, and notes.

## Installation

If you're using TeX Live on Linux or macOS, you should be able to run
`make install` after cloning the repo. Otherwise, you can copy
`tufte-common.def`, `tufte-book.cls`, and `tufte-handout.cls` to the
appropriate subdirectory of your `TEXMFHOME` directory (probably something
like `$TEXMFHOME/tex/latex/tufte-latex`) and then run `texhash`.

To use the Tufte-LaTeX classes in just one specific LaTeX document, you
can copy `tufte-common.def`, `tufte-book.cls`, and `tufte-handout.cls`
into the working directory of that document.

## Quick Start

You can compile both the sample book and handout with all three TeX
engines (LuaLaTeX, XeLaTeX, and pdfLaTeX) by running `make test`, or you
can compile the book and handout with just one engine by running
`make test-lua`, `make test-xe`, or `make test-pdf`.

If you want to compile just the book or the handout, it's easiest to use
`latexmk` (substituting `xelatex` or `pdflatex` for `lualatex`, if desired):

```shell
$ latexmk -outdir=samples -bibtex -lualatex -jobname=%A-lualatex sample-book.tex
```

or

```shell
$ latexmk -outdir=samples -bibtex -lualatex -jobname=%A-lualatex sample-handout.tex
```

You could also do things manually. For the sample handout, run:

```shell
$ lualatex sample-handout
$ biber sample-handout
$ lualatex sample-handout
$ lualatex sample-handout
```

The result should look like the sample handout PDFs in [`samples/`](samples/).

The sample book can be compiled with the following:

```shell
$ lualatex sample-book
$ biber sample-book
$ makeindex sample-book.idx
$ lualatex sample-book
$ lualatex sample-book
$ lualatex sample-book
```

As when using `latexmk`, you can substitute `xelatex` or, less preferably,
`pdflatex` for `lualatex` above.

## Troubleshooting

If you encounter errors of the form,

    ! LaTeX Error: File `paralist.sty' not found.

you will need to obtain missing packages from [CTAN](http://ctan.org).
For package installation instructions and answers to many other
questions, see the [UK TeX FAQ](http://www.tex.ac.uk/faq/) or search the [`comp.text.tex` group](http://groups.google.com/group/comp.text.tex).

The following packages are required:

 * chngpage or changepage
 * fancyhdr
 * fontenc
 * geometry
 * hyperref
 * biblatex and biber
 * optparams
 * paralist
 * placeins
 * ragged2e
 * setspace
 * textcase
 * textcomp
 * titlesec
 * titletoc
 * xcolor
 * xifthen

The following packages are optional and will be automatically used if installed:

 * beramono
 * fontspec
 * helvet
 * iftex
 * letterspace (in the microtype package)
 * mathpazo
 * soul

## Bugs/Features/Support

For kudos, feature requests, patches, or support requests that you
feel are _particular_ to this Tufte-LaTeX package, i.e., not a general
LaTeX issue, please use this project's issue tracker available at <https://github.com/Tufte-LaTeX/tufte-latex/issues>.

## Contributing

Patches and pull requests are most welcome via the issue tracker!  Submit a series of high quality patches, and you'll find yourself a developer on this project.

## License

Copyright 2007–2015 by Kevin Godby, Bil Kleb, and Bill Wood.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
