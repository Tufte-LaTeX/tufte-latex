\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{tufte-handout}[2008/06/06 v2.0.0 Tufte-handout class]

%%
% a4paper option

\newif\if@tufteh@afourpaper \@tufteh@afourpaperfalse
\DeclareOption{a4paper}{\@tufteh@afourpapertrue}

%%
% sfsidenotes option -- typesets sidenotes in sans serif typeface

\newif\if@tufteh@sfsidenotes \@tufteh@sfsidenotesfalse
\DeclareOption{sfsidenotes}{\@tufteh@sfsidenotestrue}

%%
% symmetric option -- puts marginpar space to the outside edge of the page
%   Note: this forces twoside

\newif\if@tufteh@symmetric\@tufteh@symmetricfalse
\DeclareOption{symmetric}{
  \@tufteh@symmetrictrue
  \PassOptionsToClass{twoside}{article}
}

%%
% justified option -- uses fully justified text (flush left and flush
% right) instead of ragged right.

\newif\if@tufteh@justified\@tufteh@justifiedfalse
\DeclareOption{justified}{\@tufteh@justifiedtrue}


% FIXME: should probably specify options not supported like Mittelbach's aipproc.cls

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions

\LoadClass{article}

%%
% Detect whether we're in two-side mode or not.  (Used to set up running
% heads later.)

\newif\if@tufteh@twoside\let\if@tufteh@twoside\if@twoside

%%
% Set page layout geometry

\RequirePackage[letterpaper,includemp,width=6.5in,marginparsep=0.375in,marginparwidth=2in]{geometry}

\if@tufteh@afourpaper
  \geometry{a4paper,includemp,width=170mm,marginparsep=10mm,marginparwidth=50mm}
\fi

\if@tufteh@symmetric
\else
  \geometry{asymmetric}
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
% \RaggedRight allows hyphenation

\RequirePackage{ragged2e}
\setlength{\RaggedRightRightskip}{\z@ plus 0.08\hsize}

%%
% Set the justification baesed on the `justified' class option

\newcommand{\@tufteh@justification}{%
  \if@tufteh@justified
    \justifying
  \else
    \RaggedRight
  \fi
}

%%
% Turn off section numbering

\setcounter{secnumdepth}{-1}

%%
% Tighten up space between displays (e.g., a figure or table) and make symmetric

\setlength\abovedisplayskip{6pt plus 2pt minus 4pt}
\setlength\belowdisplayskip{6pt plus 2pt minus 4pt}

%%
% To implement full-width display environments

\RequirePackage[strict]{chngpage}

%%
% Detect if we're using pdfLaTeX
\IfFileExists{ifpdf.sty}{%
  \RequirePackage{ifpdf}
}{% assume we're not using pdfTex?
  \newif\ifpdf\pdffalse
}

%%
% Detect if we're using XeLaTeX
\IfFileExists{ifxetex.sty}{%
  \RequirePackage{ifxetex}
}{% not using xelatex
  \newif\ifxetex\xetexfalse
}


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
  %\global\let\@author\@empty
  %\global\let\@date\@empty
  %\global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
}
\def\@maketitle{%
  \newpage
  \noindent\sffamily\large{\allcaps{\@title}}\\
  \vskip0.5\baselineskip
  \noindent\normalsize{\allcaps{\@author}}\\
  \vskip0.3\baselineskip
  \noindent{\allcaps{\@date}}
  \thispagestyle{plain}
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
\def\allcapsspacing{\relax}
\def\smallcapsspacing{\relax}
\newcommand{\allcaps}[1]{\MakeTextUppercase{\allcapsspacing{#1}}}
\newcommand{\smallcaps}[1]{\MakeTextLowercase{\textsc{#1}}}

\newcommand{\@tufteh@loadsoul}{%
  \IfFileExists{soul.sty}{%
    \RequirePackage{soul}
    \sodef\allcapsspacing{\upshape}{0.15em}{0.65em}{0.6em}
    \sodef\smallcapsspacing{\scshape}{0.075em}{0.5em}{0.6em}
  }{
    \PackageWarningNoLine{tufte-handout}{Couldn't locate `soul' package.}
  }% soul not installed... giving up.
}

% If we're using pdfLaTeX v1.40+, use the letterspace package. 
% If we're using pdfLaTex < v1.40, use the soul package.
% If we're using XeLaTeX, use XeLaTeX letterspacing options.
% Otherwise fall back on the soul package.

\ifpdf\PackageInfo{tufte-handout}{ifpdf = true}
\else\PackageInfo{tufte-handout}{ifpdf = false}
\fi

\ifxetex\PackageInfo{tufte-handout}{ifxetex = true}
\else\PackageInfo{tufte-handout}{ifxetex = false}
\fi



% Check pdfLaTeX version
\def\@tufteh@pdftexversion{0}
\ifx\normalpdftexversion\@undefined \else
  \let\pdftexversion \normalpdftexversion
  \let\pdftexrevision\normalpdftexrevision
  \let\pdfoutput     \normalpdfoutput
\fi
\ifx\pdftexversion\@undefined \else
  \ifx\pdftexversion\relax \else
    \def\@tufteh@pdftexversion{6}
    \ifnum\pdftexversion < 140
      \def\@tufteh@pdftexversion{5}
    \fi
  \fi
\fi

\ifnum\@tufteh@pdftexversion<6
  % pdfLaTeX version is too old or not using pdfLaTeX
  \ifxetex
    % TODO use xetex letterspacing
    \PackageInfo{tufte-handout}{XeTeX detected. Reverting to `soul' package for letterspacing.}
    \@tufteh@loadsoul
  \else
    \PackageInfo{tufte-handout}{Old version of pdfTeX detected.  Reverting to `soul' package for letterspacing.}
    \@tufteh@loadsoul
  \fi
\else
  \IfFileExists{letterspace.sty}{%
    \PackageInfo{tufte-handout}{Modern version of pdfTeX detected.  Using `letterspace' package.}
    \RequirePackage{letterspace}
    % Set up letterspacing (using microtype package) -- requires pdfTeX v1.40+
    \renewcommand{\smallcapsspacing}[1]{\textls[50]{##1}}
    \renewcommand{\allcaps}[1]{\textls[200]{\MakeTextUppercase{##1}}}
    \renewcommand{\smallcaps}[1]{\textsc{\MakeTextLowercase{##1}}}
  }{% microtype failed, check for soul
    \PackageInfo{tufte-handout}{Modern version of pdfTeX detected, but `letterspace' package not installed.  Reverting to `soul' package for letterspacing.}
    \@tufteh@loadsoul
  }
\fi


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
\providecommand*{\footnotelayout}{\@tufteh@marginfont\@tufteh@justification}
\renewcommand{\footnotelayout}{\@tufteh@marginfont\@tufteh@justification}

% Override footmisc's definition to set the sidenote marks (numbers) inside the
% sidenote's text block.
\long\def\@makefntext#1{\@textsuperscript{\@tufteh@marginfont\tiny\@thefnmark}\,\footnotelayout#1}

% Set the in-text footnote mark in the same typeface as the body text itself.
\def\@makefnmark{\hbox{\@textsuperscript{\normalfont\scriptsize\@thefnmark}}}

\let\sidenote\footnote

%%
% Sidenote without the footnote mark

\providecommand\marginnote[1]%
  {\marginpar{\@tufteh@marginfont\@tufteh@justification #1}}

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
        \@tufteh@justification
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
       \@tufteh@justification
   }
   {\end{minipage}%
    \end{lrbox}%
    \marginpar{\usebox{\@tufteh@margintablebox}}}


%%
% Full-width figure

\renewenvironment{figure*}[1]%
  [htbp]%
  {\@float{figure}[#1]%
   \if@tufteh@symmetric
     \begin{adjustwidth}[]{}{-\@tufteh@overhang}%
   \else
     \begin{adjustwidth}{}{-\@tufteh@overhang}%
   \fi
   \begin{minipage}{\linewidth}}%
  {\end{minipage}%
   \end{adjustwidth}%
   \end@float}

%%
% Full-width table

\renewenvironment{table*}[1]
  [htbp]%
  {\@float{table}[#1]%
   \if@tufteh@symmetric
     \begin{adjustwidth}[]{}{-\@tufteh@overhang}%
   \else
     \begin{adjustwidth}{}{-\@tufteh@overhang}%
   \fi
   \begin{minipage}{\linewidth}}%
  {\end{minipage}%
   \end{adjustwidth}%
   \end@float}

%%
% Full-page-width area

\newenvironment{fullwidth}
  {\if@tufteh@symmetric
     \begin{adjustwidth}[]{}{-\@tufteh@overhang}%
   \else
     \begin{adjustwidth}{}{-\@tufteh@overhang}%
   \fi
  }
  {\end{adjustwidth}}

%%
% Format the captions in a style similar to the sidenotes

\RequirePackage[format=default,font={rm,scriptsize},justification=raggedright,singlelinecheck=false]{caption}

% if the `sfsidenotes' option is specified, set the captions in sf, too.
\if@tufteh@sfsidenotes
  \captionsetup{font={sf,scriptsize}}
\else
  \captionsetup{font={rm,scriptsize}}
\fi

% if the `justified' option is specified, set the captions in flush left
% and flush right
\if@tufteh@justified
  \captionsetup{justification=justified}
\else
  \captionsetup{justification=raggedright}
\fi

%%
% If the Palatino typeface (and its math symbol set) are installed, load them.

\IfFileExists{palatino.sty}{%
  \RequirePackage{palatino}
  \IfFileExists{mathpazo.sty}{\RequirePackage[osf,sc]{mathpazo}}{}
}{} % if the Palatino typefaces aren't found, do nothing.


%%
% If the Bera Mono typeface is available, use it.

\IfFileExists{beramono.sty}{%
  \RequirePackage[T1]{fontenc}
  \RequirePackage[scaled=0.85]{beramono}
}{}


%%
% Sets up the running heads and folios.

\RequirePackage{fancyhdr}

% Set the header/footer width to be the body text block plus the margin
% note area.
\if@tufteh@symmetric
  \fancyhfoffset[LE,RO]{\@tufteh@overhang}
\else
  \fancyhfoffset[RE,RO]{\@tufteh@overhang}
\fi

% The 'fancy' page style is the default style for all pages.
\fancyhf{} % clear header and footer fields
\if@tufteh@twoside
  \fancyhead[LE]{\thepage\quad\smallcaps{\@author}}
  \fancyhead[RO]{\smallcaps{\@title}\quad\thepage}
\else
  \fancyhead[RE,RO]{\smallcaps{\@title}\quad\thepage}
\fi
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% The 'plain' page style is used on chapter opening pages.
\fancypagestyle{plain}{
  \fancyhf{} % clear header and footer fields
  \if@tufteh@twoside
    \fancyfoot[LE,RO]{\thepage}
  \else
    \fancyfoot[RE,RO]{\thepage}
  \fi
}

% The 'empty' page style suppresses all headers and footers.
% It's used on title pages and `intentionally blank' pages.
\fancypagestyle{empty}{
  \fancyhf{} % clear header and footer fields
}

% Set the default page style to 'fancy'
\pagestyle{fancy}


%%
% Set raggedright and paragraph indentation for document

\AtBeginDocument{\@tufteh@justification\setlength\parindent{1em}}


%%
% Prints the list of class options and their states.
\newcommand{\printclassoptions}{%
  \texttt{symmetric}---\if@tufteh@symmetric true\else false\fi\\
  \texttt{a4paper}---\if@tufteh@afourpaper true\else false\fi\\
  \texttt{twoside}---\if@tufteh@twoside true\else false\fi\\
  \texttt{sfsidenotes}---\if@tufteh@sfsidenotes true\else false\fi\\
  \texttt{justified}---\if@tufteh@justified true\else false\fi
}

\endinput
