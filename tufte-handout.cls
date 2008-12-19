\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{tufte-handout}[2008/11/16 v3.0.0 Tufte-handout class]

%%
% The symmetric option forces twoside.
\DeclareOption{symmetric}{%
  \ExecuteOptions{twoside}
  \PassOptionsToPackage{twoside}{tufte-common}
  \PassOptionsToClass{twoside}{article}
  \PackageInfo{tufte-handout}{Passing twoside to `article' class}
}

\PassOptionsToPackage{handout}{tufte-common}
\DeclareOption*{% pass options to tufte-common package and the article class
  \PassOptionsToPackage{\CurrentOption}{tufte-common}
  \PassOptionsToClass{\CurrentOption}{article}
  \PackageInfo{tufte-handout}{Passing \CurrentOption\space to `article' class}
}
\ProcessOptions

\LoadClass{article}

\RequirePackage{tufte-common}


%%
% Set up any handout-specific stuff now

%%
% Abstract

% TODO The abstract should be printed on its own page of the `titlepage'
% option was specified.
\renewenvironment{abstract}{%
  \begin{quotation}
    \if@tufte@sfsidenotes\begin{sffamily}\fi
    \begin{small}
}{%
    \end{small}
    \if@tufte@sfsidenotes\end{sffamily}\fi
  \end{quotation}
}


%%
% If there is a `tufte-handout-local.tex' file, load it.

\IfFileExists{tufte-handout-local.tex}
  {\input{tufte-handout-local}}
  {}


%%
% End of file
\endinput
