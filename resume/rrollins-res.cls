\ProvidesClass{rrollins-res}[2013/12/18]

\LoadClass[10pt,letterpaper]{article}

\pagestyle{empty}

\usepackage{relsize}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Header
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define the name
\def \name#1{\def\@name{#1}}
\def \@name {}

%define the seperator for the address
\def \addressSep {$\diamond$}

%there should be three address lines
\let \@addressone \relax
\let \@addresstwo \relax
\let \@addressthree \relax

\newcommand{\address}[3] {
  \def \@addressone{#1}
  \def \@addresstwo{#2}
  \def \@addressthree{#3}
}


% style the address line
\def \printaddress #1{
  \begingroup
    \def \\ {\addressSep\ }
    #1 
  \endgroup
  \par
  \addressskip
}

% style the name
\def \printname {
  \begingroup
    {\namesize\bf \@name}
    \break
    \rule{1\linewidth}{1pt}
    
  \endgroup
}

% style the subsections
\def \printsec #1{
  \begingroup
    #1
  \endgroup
}

%print the header
\let\ori@document=\document
\renewcommand{\document}{
  \ori@document
  \printname
  \printaddress{\@addressone}
  \printaddress{\@addresstwo}
  \printaddress{\@addressthree}
}

%some whitespace definitions
\def\namesize{\huge}
\def\addressskip{\smallskip}
\def\sectionlineskip{\medskip}
\def\nameskip{\smallskip}
\def\sectionskip{\medskip}

\newenvironment{indentsection}
{\begin{list}{}{\setlength{\leftmargin}{\newparindent}\setlength{\parsep}
{0pt}\setlength{\parskip}{0pt}\setlength{\itemsep}{0pt}\setlength{\topsep}
{0pt}}}{\end{list}}

\newcommand*\roottitle[1]{\subsection*{#1}\vspace{-0.3em}\nopagebreak[4]}

\newcommand{\headedsection}[3]
{\nopagebreak[4]\begin{indentsection}\item[]\textscale{1.1}
{#1}\hfill#2#3\end{indentsection}\nopagebreak[4]}

\newcommand{\headedsubsection}[3]
{\nopagebreak[4]\begin{indentsection}\item[]\textbf{#1}\hfill\emph{#2}#3\end{indentsection}\nopagebreak[4]}

\newcommand{\bodytext}[1]
{\nopagebreak[4]\begin{indentsection}\item[]#1\end{indentsection}\pagebreak[2]}

\newlength{\newparindent}
\addtolength{\newparindent}{\parindent}
