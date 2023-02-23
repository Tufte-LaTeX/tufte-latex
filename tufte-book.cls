\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{tufte-book}
  [2015/06/30 v3.5.3 Tufte-book class]

%%
% Declare we're tufte-book
% The base LaTeX class (defaults to the book style)
\newcommand{\@tufte@class}{book}
% The name of the package (defaults to tufte-handout)
\newcommand{\@tufte@pkgname}{tufte-book}

%%
% Load the common style elements
\input{tufte-common.def}

%%
% Set up any book-specific stuff now

%%
% The front matter in Tufte's /Beautiful Evidence/ contains everything up
% to the opening page of Chapter 1.  The running heads, when they appear,
% contain only the (arabic) page number in the outside corner.
%\newif\if@mainmatter \@mainmattertrue
\renewcommand\frontmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmatterfalse%
  \pagenumbering{arabic}%
  %\pagestyle{plain}%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}{%
    \fancyhead[LE,RO]{\thepage}
  }{%
    \fancyhead[RE,RO]{\thepage}
  }%
}

%%
% The main matter in Tufte's /Beautiful Evidence/ doesn't restart the page
% numbering---it continues where it left off in the front matter.
\renewcommand\mainmatter{%
  \if@openright%
    \cleardoublepage%
  \else%
    \clearpage%
  \fi%
  \@mainmattertrue%
  \fancyhf{}%
  \ifthenelse{\boolean{@tufte@twoside}}{%
    % Two-side
    \renewcommand{\chaptermark}[1]{\markboth{##1}{}}%
    % Book title
    \fancyhead[LE]{\thepage\quad\smallcaps{\newlinetospace{\plaintitle}}}%
    % Chapter title
    \fancyhead[RO]{\smallcaps{\newlinetospace{\leftmark}}\quad\thepage}%
  }{%
    % One-side
    %  Book title
    \fancyhead[RE,RO]{\smallcaps{\newlinetospace{\plaintitle}}\quad\thepage}%
  }%
}

%%
% The back matter contains appendices, indices, glossaries, endnotes,
% bibliographies, list of contributors, illustration credits, etc.
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
\IfFileExists{tufte-book-local.tex}{%
  \@tufte@info@noline{Loading tufte-book-local.tex}%
  \input{tufte-book-local}%
}{}

%%
% End of file
\endinput
