\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{tufte-handout}[2007/10/18 v1.1.0 Tufte-handout class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
                \typeout{NOTE: Passing ``\CurrentOption" option on to the
                         standard LaTeX book class}}
\ProcessOptions

\LoadClass[11pt]{article}%

%%
% Set page layout geometry -- someone please submit a patch to make letterpaper optional!

\RequirePackage[letterpaper,includemp,width=6.5in,marginparsep=0.375in,marginparwidth=2in]{geometry}

%%
% Separation marginpars by a line's worth of space.

\setlength\marginparpush{\baselineskip}

%%
% Font for margin items

\newcommand{\@tufteh@marginfont}{\normalfont\scriptsize\sffamily}

%%
% Modify \raggedright from latex.ltx to allow hyphenation per Donald Arseneau

\def\@tufteh@raggedright{%
  \let\\\@centercr\@rightskip\z@ plus 0.08\hsize% changed this line
  \rightskip\@rightskip
  \leftskip\z@skip}

%%
% Turn off section numbering

\setcounter{secnumdepth}{-1}

%%
% Tighten up space between displays (e.g., a figure or table) and make symmetric

\setlength\abovedisplayskip{6pt plus 2pt minus 4pt}
\setlength\belowdisplayskip{6pt plus 2pt minus 4pt}

%%
% To accomodate full-width display environments

\RequirePackage{chngpage}

% Compute length used for full-width displays

\newlength{\@tufteh@overhang}
\setlength{\@tufteh@overhang}{\marginparwidth}
\addtolength{\@tufteh@overhang}{\marginparsep}

%%
% Alter \maketitle from article.cls

\renewcommand\maketitle{\par
  \global\let\and\relax
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@
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

%%
% Abstract

\renewenvironment{abstract}%
 {\begin{quotation}
   \begin{sffamily}
    \begin{small}}%
 {  \end{small}
   \end{sffamily}
  \end{quotation}}

%%
% Require paralist package for tigher lists

\RequirePackage{paralist}

% Add rightmargin to compactenum

\def\@compactenum@{%
  \expandafter\list\csname label\@enumctr\endcsname{%
    \usecounter{\@enumctr}%
    \rightmargin=2em% added this
    \parsep\plparsep
    \itemsep\plitemsep
    \topsep\pltopsep
    \partopsep\plpartopsep
    \def\makelabel##1{\hss\llap{##1}}}}

%%
% An environment for paragraph-style section

\providecommand\newthought[1]{\vspace{1.8\baselineskip plus 3pt minus 2pt}%
                           {\noindent\scshape #1}}

%%
% Sidenote: "Where God meant footnotes to go." --Tufte

\newcommand{\sidenote}[2][-0.8\baselineskip]%
            {\footnotemark%
             \marginpar{\@tufteh@marginfont
                        \vspace*{#1}
                        \textsuperscript{\thefootnote}%
                        \@tufteh@raggedright #2}}

%%
% Sidenote without the footnote mark

\providecommand\marginnote[1]{\marginpar{\footnotesize\raggedright #1}}

%%
% Margin figure

\newcommand{\marginfigure}[2][-1.2ex]%
  {\marginpar{\def\@captype{figure}
              \normalfont\scriptsize
              \vspace*{#1}
              \@tufteh@raggedright #2}}

%%
% Margin table

\newcommand{\margintable}[2][-1.2ex]%
  {\marginpar{\def\@captype{table}
              \normalfont\scriptsize
              \vspace*{#1}
              \@tufteh@raggedright #2}}

%%
% Full-width figure

\renewenvironment{figure*}[1][htbp]
               {\@float{figure}[#1]
                 \begin{adjustwidth}{}{-\tufteh@overhang}%
                  \begin{minipage}{\linewidth}}
               {  \end{minipage}%
                 \end{adjustwidth}%
                \end@float}

%%
% Full-width table

\renewenvironment{table*}[1][htbp]
               {\@float{table}[#1]
                 \begin{adjustwidth}{}{-\tufteh@overhang}%
                  \begin{minipage}{\linewidth}}
               {  \end{minipage}%
                 \end{adjustwidth}%
                \end@float}

%%
% Full-page-width area

\newenvironment{fullwidth}
  {\begin{adjustwidth}{}{-\tufteh@overhang}}%
  {\end{adjustwidth}}

%%
% Set raggedright and paragraph indentation for document

\AtBeginDocument{\@tufteh@raggedright\setlength\parindent{1em}}

\endinput
