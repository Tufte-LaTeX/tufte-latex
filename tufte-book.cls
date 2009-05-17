\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{tufte-book}[2009/05/17 v3.0.0 Tufte-book class]


\PassOptionsToPackage{book}{tufte-common}
\DeclareOption*{% pass options to tufte-common package and the article class
  \PassOptionsToPackage{\CurrentOption}{tufte-common}
  \PassOptionsToClass{\CurrentOption}{book}
  \PackageInfo{tufte-book}{Passing \CurrentOption\space to `book' class}
}
\ProcessOptions

\LoadClass{book}

\RequirePackage{tufte-common}


%%
% Set up any book-specific stuff now

%%
% The front matter in Tufte's /Beautiful Evidence/ contains everything up
% to the opening page of Chapter 1.  The running heads, when they appear,
% contain only the (arabic) page number in the outside corner.
%\newif\if@mainmatter \@mainmattertrue
\renewcommand\frontmatter{%
  \cleardoublepage%
  \@mainmatterfalse%
  \pagenumbering{arabic}%
  %\pagestyle{plain}%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {\fancyhead[LE,RO]{\thepage}}%
    {\fancyhead[RE,RO]{\thepage}}%
}


%%
% The main matter in Tufte's /Beautiful Evidence/ doesn't restart the page
% numbering---it continues where it left off in the front matter.
\renewcommand\mainmatter{%
  \cleardoublepage%
  \@mainmattertrue%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}%
    {% two-side
      \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
      \fancyhead[LE]{\thepage\quad\smallcaps{\plaintitle}}% book title
      \fancyhead[RO]{\smallcaps{\leftmark}\quad\thepage}% chapter title
    }%
    {% one-side
      \fancyhead[RE,RO]{\smallcaps{\plaintitle}\quad\thepage}% book title
    }%
}


%%
% The back matter contains appendices, indices, glossaries, endnotes,
% biliographies, list of contributors, illustration credits, etc.
\renewcommand\backmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmatterfalse%
}

%%
% Only show the chapter titles in the table of contents
\setcounter{tocdepth}{0}

%%
% If there is a `tufte-book-local.sty' file, load it.

\IfFileExists{tufte-book-local.tex}
  {\input{tufte-book-local}}
  {}

%%
% End of file
\endinput
