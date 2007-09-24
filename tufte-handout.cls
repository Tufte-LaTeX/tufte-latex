\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{tufte-handout}[2007/09/24 v1.0.0 Tufte-handout class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
                \typeout{NOTE: Passing ``\CurrentOption" option on to the
                         standard LaTeX book class}}
\ProcessOptions
\LoadClass[11pt]{article}%
 \RequirePackage[includemp,letterpaper,width=6.5in,marginparwidth=2in]{geometry}
 \RequirePackage{paralist}

 \setlength\marginparsep{0.375in}
 \setlength\marginparpush{\baselineskip}
 \setlength\abovedisplayskip{6pt plus 2pt minus 4pt}
 \setlength\belowdisplayskip{6pt plus 2pt minus 4pt}

\renewcommand\maketitle{\par
  \global\let\and\relax
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \@thanks
  \endgroup
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
}
\def\@maketitle{%
  \newpage
  \let\footnote\sidenote
  {\noindent\large\bfseries \@title\par}%
  \vskip 3pt%
  {\small \@date\par}%
  \vskip 3pt%
  {\small \@author\par}
}

% modify abstract section behavior
 \renewenvironment{abstract}%
   {\footnotesize\quotation\sffamily\slshape}%
   {\normalfont\endquotation\normalsize}

% modify paralist compact enumeration list to add rightmargin
\def\@compactenum@{%
  \expandafter\list\csname label\@enumctr\endcsname{%
    \usecounter{\@enumctr}%
    \rightmargin=2em% added this
    \parsep\plparsep
    \itemsep\plitemsep
    \topsep\pltopsep
    \partopsep\plpartopsep
    \def\makelabel##1{\hss\llap{##1}}}}

% modify \raggedright from latex.ltx to allow hyphenation per Donald Arseneau
\def\raggedright{%
  \let\\\@centercr\@rightskip\z@ plus .3\hsize% changed this line
  \rightskip\@rightskip
  \leftskip\z@skip
  \parindent\z@}

\providecommand\newthought[1]{\vspace{1.8\baselineskip plus 3pt minus 2pt}%
                           {\noindent\scshape #1}}

\providecommand\sidenote[1]{\footnotemark%
  \marginpar{\textsuperscript{\thefootnote}\footnotesize\raggedright #1}}

\providecommand\marginnote[1]{\marginpar{\footnotesize\raggedright #1}}

\AtBeginDocument{\raggedright\setlength\parindent{1em}}

\endinput
