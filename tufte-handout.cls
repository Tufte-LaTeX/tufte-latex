\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{tufte-handout}[2008/05/16 v2.0.0 Tufte-handout class]

%%
% a4paper option

\newif\if@tufteh@afourpaper \@tufteh@afourpaperfalse
\DeclareOption{a4paper}{\@tufteh@afourpapertrue}

%%
% sfsidenotes option -- typesets sidenotes in sans serif typeface

\newif\if@tufteh@sfsidenotes \@tufteh@sfsidenotesfalse
\DeclareOption{sfsidenotes}{\@tufteh@sfsidenotestrue}

% FIXME: should probably specify options not supported like Mittelbach's aipproc.cls

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

\LoadClass{article}%

%%
% Set page layout geometry

\if@tufteh@afourpaper
  \RequirePackage[a4paper,includemp,width=170mm,marginparsep=10mm,marginparwidth=50mm]{geometry}
\else
  \RequirePackage[letterpaper,includemp,width=6.5in,marginparsep=0.375in,marginparwidth=2in]{geometry}
\fi

%%
% Separation marginpars by a line's worth of space.

\setlength\marginparpush{\baselineskip}

%%
% Font for margin items

\if@tufteh@sfsidenotes
  \newcommand{\@tufteh@marginfont}{\normalfont\scriptsize\sffamily}
\else
  \newcommand{\@tufteh@marginfont}{\normalfont\scriptsize}
\fi

%%
% Modify \raggedright from latex.ltx to allow hyphenation per Donald Arseneau

\def\@tufteh@raggedright{%
  \let\\\@centercr\@rightskip\z@ plus 0.08\hsize
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
% To implement full-width display environments

\RequirePackage{chngpage}

% Compute length used for full-width displays

\newlength{\@tufteh@overhang}
\setlength{\@tufteh@overhang}{\marginparwidth}
\addtolength{\@tufteh@overhang}{\marginparsep}

%%
% Alter \maketitle from article.cls

\renewcommand\maketitle{\par
  \global\let\and\relax
  \global\let\thanks\footnote
  \begingroup
    \newpage
    \global\@topnum\z@
    \@maketitle
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
  \noindent\sffamily\large{\@title}\\
  \vskip0.5\baselineskip
  \noindent\normalsize{\@author}\\
  \vskip0.3\baselineskip
  \noindent{\@date}
  \thispagestyle{empty}
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
% Require paralist package for tighter lists

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
% Improved letterspacing of small caps and all-caps text.
%
% First, try to use the `microtype' package, if it's available. 
% Failing that, try to use the `soul' package, if it's available.
% Failing that, well, I give up.

\RequirePackage{textcase} % provides \MakeTextUppercase and \MakeTextLowercase
\newcommand{\allcaps}[1]{\MakeTextUppercase{#1}}
\newcommand{\smallcaps}[1]{\textsc{\MakeTextLowercase{#1}}}
\newcommand{\smallcapsspacing}[1]{#1}

\IfFileExists{microtype.sty}{%
  \RequirePackage[final]{microtype}
  % Set up letterspacing (using microtype package) -- requires pdfTeX v1.40+
  \renewcommand{\smallcapsspacing}[1]{\textls[50]{##1}}
  \renewcommand{\allcaps}[1]{\textls[200]{\MakeTextUppercase{##1}}}
  \renewcommand{\smallcaps}[1]{\textsc{\MakeTextLowercase{##1}}}
}{% microtype failed, check for soul
  \IfFileExists{soul.sty}{%
    \RequirePackage{soul}
    \sodef\allcapsspacing{\upshape}{0.15em}{0.65em}{0.6em}
    \sodef\smallcapsspacing{\scshape}{0.075em}{0.5em}{0.6em}
    \renewcommand{\allcaps}[1]{\allcapsspacing{\MakeTextUppercase{##1}}}
    \renewcommand{\smallcaps}[1]{\textsc{\MakeTextLowercase{##1}}}
  }{}% neither microtype nor soul are installed... giving up.
}

\DeclareTextFontCommand{\textsmallcaps}{\scshape}
\renewcommand{\textsc}[1]{\textsmallcaps{\smallcapsspacing{#1}}}


%%
% An environment for paragraph-style section

\providecommand\newthought[1]{\vspace{1.8\baselineskip plus 3pt minus 2pt}%
                           {\noindent\textsc{#1}}}

%%
% Transform existing \footnotes into \sidenotes
% Sidenote: ``Where God meant footnotes to go.'' ---Tufte

\RequirePackage[side,multiple]{footmisc}
\newcommand{\footnotelayout}{\@tufteh@marginfont\@tufteh@raggedright}

% Override footmisc's definition to set the sidenote marks (numbers) inside the
% sidenote's text block.
\long\def\@makefntext#1{\@textsuperscript{\@tufteh@marginfont\tiny\@thefnmark}\,\footnotelayout#1}

% Set the in-text footnote mark in the same typeface as the body text itself.
\def\@makefnmark{\hbox{\@textsuperscript{\normalfont\scriptsize\@thefnmark}}}

\let\sidenote\footnote

%%
% Sidenote without the footnote mark

\providecommand\marginnote[1]%
  {\marginpar{\@tufteh@marginfont\raggedright #1}}

%%
% Citations should go in the margin as well

\RequirePackage{natbib}
\RequirePackage{bibentry}	% allows bibitems to be typeset outside thebibliography environment
\nobibliography*		% pre-loads the bibliography keys
\renewcommand{\cite}[1]{\sidenote{\bibentry{#1}.}}
\providecommand{\doi}[1]{\textsc{doi:} #1} % pre-defining this so it may be used before the \bibliography command it issued

% TODO: Rewrite \cite so that you can specify multiple bib keys
%       at once.  For example, \cite{Author01,Author02}
% TODO: Combine sequences of citations so that 2,3,4,6 becomes 2-4,6
%       but be careful of hyperref interaction

%%
% Make Tuftian-style section headings

% TODO: I'd prefer to use the 'titlesec' package for this formatting, but
%       I'll do it old-style for now.  --Kevin

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\it}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\it}}

% Subsubsection and following section headings shouldn't be used.
% See Bringhurst's _The Elements of Typography_, section 4.2.2.
\renewcommand\subsubsection{%
  \PackageError{tufte-handout}{\noexpand\subsubsection is undefined by this class.%
    \MessageBreak See Robert Bringhurst's _The Elements of 
    \MessageBreak Typographic Style_, section 4.2.2.
    \MessageBreak \noexpand\subsubsection was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as 
    \MessageBreak many levels of headings as you need, no more and no fewer.  Also see the many 
    \MessageBreak related threads on Ask E.T. at http://www.edwardtufte.com/.}
}

\renewcommand\paragraph{%
  \PackageError{tufte-handout}{\noexpand\paragraph is undefined by this class.%
    \MessageBreak See Robert Bringhurst's _The Elements of 
    \MessageBreak Typographic Style_, section 4.2.2.
    \MessageBreak \noexpand\paragraph was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as 
    \MessageBreak many levels of headings as you need, no more and no fewer.  Also see the many 
    \MessageBreak related threads on Ask E.T. at http://www.edwardtufte.com/.}
}

\renewcommand\subparagraph{%
  \PackageError{tufte-handout}{\noexpand\subparagraph is undefined by this class.%
    \MessageBreak See Robert Bringhurst's _The Elements of 
    \MessageBreak Typographic Style_, section 4.2.2.
    \MessageBreak \noexpand\subparagraph was used}
    {From Bringhurst's _The Elements of Typographic Style_, section 4.2.2: Use as 
    \MessageBreak many levels of headings as you need, no more and no fewer.  Also see the many 
    \MessageBreak related threads on Ask E.T. at http://www.edwardtufte.com/.}
}


%%
% The placeins package provides the \FloatBarrier command.  This forces
% LaTeX to place all of the floats before proceeding.  We'll use this to
% keep the float (figure and table) numbers in sequence.
\RequirePackage{placeins}

%%
% Margin figure environment

\newsavebox{\@tufteh@marginfigbox}
\newenvironment{marginfigure}[1]
    [-1.2ex]
    {\FloatBarrier% process all floats before this point so the figure numbers stay in order.
    \begin{lrbox}{\@tufteh@marginfigbox}
    \begin{minipage}{\marginparwidth}
        \@tufteh@marginfont
        \def\@captype{figure}
        \vspace*{#1}
        \@tufteh@raggedright
    }    
    {\end{minipage}%
     \end{lrbox}%
     \marginpar{\usebox{\@tufteh@marginfigbox}}}


%%
% Margin table environment
\newsavebox{\@tufteh@margintablebox}
\newenvironment{margintable}[1]
   [-1.2ex]
   {\FloatBarrier% process all floats before this point so the figure numbers stay in order.
   \begin{lrbox}{\@tufteh@margintablebox}
   \begin{minipage}{\marginparwidth}
       \@tufteh@marginfont
       \def\@captype{table}
       \vspace*{#1}
       \@tufteh@raggedright
   }
   {\end{minipage}%
    \end{lrbox}%
    \marginpar{\usebox{\@tufteh@margintablebox}}}


%%
% Full-width figure

\renewenvironment{figure*}[1]%
  [htbp]%
  {\@float{figure}[#1]%
   \begin{adjustwidth}{}{-\@tufteh@overhang}%
   \begin{minipage}{\linewidth}}%
  {\end{minipage}%
   \end{adjustwidth}%
   \end@float}

%%
% Full-width table

\renewenvironment{table*}[1]
  [htbp]%
  {\@float{table}[#1]%
   \begin{adjustwidth}{}{-\@tufteh@overhang}%
   \begin{minipage}{\linewidth}}%
  {\end{minipage}%
   \end{adjustwidth}%
   \end@float}

%%
% Full-page-width area

\newenvironment{fullwidth}
  {\begin{adjustwidth}{}{-\@tufteh@overhang}}%
  {\end{adjustwidth}}

%%
% Format the captions in a style similar to the sidenotes

% if 'sfsidenotes' option is specified, set the captions in sf, too.
\if@tufteh@sfsidenotes
  \RequirePackage[format=default,font={sf,scriptsize},justification=raggedright,singlelinecheck=false]{caption}
\else
  \RequirePackage[format=default,font={rm,scriptsize},justification=raggedright,singlelinecheck=false]{caption}
\fi

%%
% If the Palatino typeface (and its math symbol set) are installed, load them.

\IfFileExists{palatino.sty}{%
  \RequirePackage{palatino}
  \IfFileExists{mathpazo.sty}{\RequirePackage[osf,sc]{mathpazo}}{}
}{} % if the Palatino typefaces aren't found, do nothing.

%%
% Set raggedright and paragraph indentation for document

\AtBeginDocument{\@tufteh@raggedright\setlength\parindent{1em}}

\endinput
