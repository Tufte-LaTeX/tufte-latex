Hi,

Welcome to the beginnings of Tufte LaTeX package to help you
produce Tufte-style handouts, reports, and notes.

## Quick Start

Try typesetting `sample-handout.tex` with the following sequence
of commands,

    pdflatex sample-handout
    bibtex   sample-handout
    pdflatex sample-handout
    pdflatex sample-handout

The result should look like `sample-handout.pdf`.

The sample book can be compiled with the following:

    pdflatex sample-book
    bibtex sample-book
    texindy --language english sample-book.idx
    # or makeindex sample-book.idx
    pdflatex sample-book
    pdflatex sample-book
    pdflatex sample-book

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
 * natbib and bibentry
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
 * helvet
 * ifpdf
 * ifxetex
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
