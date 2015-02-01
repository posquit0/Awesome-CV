%% start of file `moderncv.cls'.
%% Copyright 2006-2013 Xavier Danaux (xdanaux@gmail.com).
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License version 1.3c,
% available at http://www.latex-project.org/lppl/.


%-------------------------------------------------------------------------------
%                identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{moderncv}[2013/04/29 v1.5.1 modern curriculum vitae and letter document class]


%-------------------------------------------------------------------------------
%                class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% paper size option
\DeclareOption{a4paper}{
  \setlength\paperheight{297mm}
  \setlength\paperwidth{210mm}}
\DeclareOption{a5paper}{
  \setlength\paperheight{210mm}
  \setlength\paperwidth{148mm}}
\DeclareOption{b5paper}{
  \setlength\paperheight{250mm}
  \setlength\paperwidth{176mm}}
\DeclareOption{letterpaper}{
  \setlength\paperheight{11in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{legalpaper}{
  \setlength\paperheight{14in}
  \setlength\paperwidth{8.5in}}
\DeclareOption{executivepaper}{
  \setlength\paperheight{10.5in}
  \setlength\paperwidth{7.25in}}
\DeclareOption{landscape}{
  \setlength\@tempdima{\paperheight}
  \setlength\paperheight{\paperwidth}
  \setlength\paperwidth{\@tempdima}}

% font size options
\newcommand\@ptsize{}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}

% font type options
\DeclareOption{sans}{\AtBeginDocument{\renewcommand{\familydefault}{\sfdefault}}}
\DeclareOption{roman}{\AtBeginDocument{\renewcommand{\familydefault}{\rmdefault}}}

% draft/final option
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% execute default options
\ExecuteOptions{a4paper,11pt,final}

% process given options
\ProcessOptions\relax
\input{size1\@ptsize.clo}


%-------------------------------------------------------------------------------
%                required packages
%-------------------------------------------------------------------------------
% \AtEndPreamble hook (loading etoolbox instead of defining the macro, as to avoid incompatibilities with etoolbox (and packages relying on it) defining the macro too)
\RequirePackage{etoolbox}
%\let\@endpreamblehook\@empty
%\def\AtEndPreamble{\g@addto@macro\@endpreamblehook}
%\let\document@original\document
%\def\document{\endgroup\@endpreamblehook\begingroup\document@original}

% if... then... else... constructs
\RequirePackage{ifthen}
% TODO: move to xifthen and \isempty{<arg>} instead of \equal{<arg>}{}

% color
\RequirePackage{xcolor}

% font loading
\RequirePackage{ifxetex,ifluatex}
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi
% automatic loading of latin modern fonts
%\ifxetexorluatex
%  \RequirePackage{fontspec}
%  \defaultfontfeatures{Ligatures=TeX}
%  \RequirePackage{unicode-math}
%  \setmainfont{Latin Modern}
%  \setsansfont{Latin Modern Sans}
%  \setmathfont{Latin Modern Math}
%\else
  \RequirePackage[T1]{fontenc}
  \IfFileExists{lmodern.sty}%
    {\RequirePackage{lmodern}}%
    {}
%\fi

% hyper links (hyperref is loaded at the end of the preamble to pass options required by loaded packages such as CJK)
\newcommand*\pdfpagemode{UseNone}% do not show thumbnails or bookmarks on opening (on supporting browsers); set \pdfpagemode to "UseOutlines" to show bookmarks
\RequirePackage{url}
\urlstyle{tt}
\AtEndPreamble{
  \pagenumbering{arabic}% has to be issued before loading hyperref, as to set \thepage and hence to avoid hyperref issuing a warning and setting pdfpagelabels=false
  \RequirePackage[unicode]{hyperref}% unicode is required for unicode pdf metadata
  \hypersetup{
    breaklinks,
    baseurl       = http://,
    pdfborder     = 0 0 0,
    pdfpagemode   = \pdfpagemode,
    pdfstartpage  = 1,
    pdfcreator    = {\LaTeX{} with 'moderncv' package},
%    pdfproducer   = {\LaTeX{}},% will/should be set automatically to the correct TeX engine used
    bookmarksopen = true,
    bookmarksdepth= 2,% to show sections and subsections
    pdfauthor     = {\@firstname{}~\@lastname{}},
    pdftitle      = {\@firstname{}~\@lastname{} -- \@title{}},
    pdfsubject    = {Resum\'{e} of \@firstname{}~\@lastname{}},
    pdfkeywords   = {\@firstname{}~\@lastname{}, curriculum vit\ae{}, resum\'{e}}}}

% graphics
\RequirePackage{graphicx}

% headers and footers
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  \fancyhf{}}
% page numbers in footer if more than 1 page
\newif\if@displaypagenumbers\@displaypagenumberstrue
\newcommand*{\nopagenumbers}{\@displaypagenumbersfalse}
\AtEndPreamble{%
  \AtBeginDocument{%
    \if@displaypagenumbers%
      \@ifundefined{r@lastpage}{}{%
        \ifthenelse{\pageref{lastpage}>1}{%
          \newlength{\pagenumberwidth}%
          \settowidth{\pagenumberwidth}{\color{color2}\addressfont\itshape\strut\thepage/\pageref{lastpage}}%
          \fancypagestyle{plain}{%
            \fancyfoot[r]{\parbox[b]{\pagenumberwidth}{\color{color2}\pagenumberfont\strut\thepage/\pageref{lastpage}}}}% the parbox is required to ensure alignment with a possible center footer (e.g., as in the casual style)
          \pagestyle{plain}}{}}%
      \AtEndDocument{\label{lastpage}}\else\fi}}
\pagestyle{plain}

% reduced list spacing
% package providing hooks into lists
%   originally developped by Jakob Schiøtz (see http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/tweaklist.sty)
%   modified and distributed with moderncv(not available otherwise on ctan)
\RequirePackage{tweaklist}
\renewcommand*{\itemhook}{%
  \@minipagetrue% removes spacing before lists as they use \addvspace, which doesn't add vertical space inside minipages
  \@noparlisttrue% removes spacing at end of lists, caused by \par
  \setlength{\topsep}{0pt}% normally not required thanks to \@minipagetrue
  \setlength{\partopsep}{0pt}% normally not required thanks to \@minipagetrue
  \setlength{\parsep}{0pt}% not required when \itemsep and \parskip are set to 0pt (?)
  \setlength{\parskip}{0pt}%
  \setlength{\itemsep}{0pt}}
\renewcommand*{\enumhook}{\itemhook{}}
\renewcommand*{\deschook}{\itemhook{}}

% lengths calculations
\RequirePackage{calc}

% advanced command arguments (LaTeX 3)
\RequirePackage{xparse}
% TODO (?): replace all \newcommand by \NewDocumentCommand

% micro-typography (e.g., character protrusion, font expansion, hyphenatable letterspacing)
\RequirePackage{microtype}

% stack of key-value elements, used to save personal information
\RequirePackage{moderncvcollection}

% compatibility package with older versions of moderncv
\RequirePackageWithOptions{moderncvcompatibility}


%-------------------------------------------------------------------------------
%                class definition
%-------------------------------------------------------------------------------
% minimal base settings
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\setlength{\parindent}{0\p@}
\setlength{\parskip}{0\p@}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}

% not set on purpose
%\setlength\arraycolsep{5\p@}
%\setlength\tabcolsep{6\p@}
%\setlength\tabbingsep{\labelsep}

\raggedbottom
\onecolumn


%-------------------------------------------------------------------------------
%                overall design commands definitions
%-------------------------------------------------------------------------------
% elements
%---------
% defines one's name
% usage: \name{<firstname>}{<lastname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}

% defines one's title (optional)
% usage: \title{<title>}
\renewcommand*{\title}[1]{\def\@title{#1}}

% defines one's address (optional)
% usage: \address{<street>}{<city>}{<country>}
% where the <city> and <country> arguments can be omitted or provided empty
\NewDocumentCommand{\address}{mG{}G{}}{\def\@addressstreet{#1}\def\@addresscity{#2}\def\@addresscountry{#3}}

% defines one's email (optional)
% usage: \email{<email adress>}
\newcommand*{\email}[1]{\def\@email{#1}}

% defines one's home page (optional)
% usage: \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% adds a fixed/mobile/fax number to one's personal information (optional)
% usage: \phone[<optional type>]{<number>}
% where <optional type> should be either "fixed" (default), "mobile" or "fax
\collectionnew{phones}
\newcommand*{\phone}[2][fixed]{\collectionadd[#1]{phones}{#2}}

% adds a social link to one's personal information (optional)
% usage: \social[<optional type>][<optional url>]{<account name>}
% where <optional type> should be either "linkedin", "twitter" or "github"
\collectionnew{socials}
\NewDocumentCommand{\social}{O{}O{}m}{%
  \ifthenelse{\equal{#2}{}}%
    {%
      \ifthenelse{\equal{#1}{linkedin}}{\collectionadd[linkedin]{socials}{\protect\httplink[#3]{www.linkedin.com/in/#3}}}{}%
      \ifthenelse{\equal{#1}{twitter}} {\collectionadd[twitter]{socials} {\protect\httplink[#3]{www.twitter.com/#3}}}    {}%
      \ifthenelse{\equal{#1}{github}}  {\collectionadd[github]{socials}  {\protect\httplink[#3]{www.github.com/#3}}}     {}%
    }
    {\collectionadd[#1]{socials}{\protect\httplink[#3]{#2}}}}

% defines additional personal information (optional)
% usage: \extrainfo{<text>}
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}

% colors
%-------
\definecolor{color0}{rgb}{0,0,0}% main default color, normally left to black
\definecolor{color1}{rgb}{0,0,0}% primary scheme color
\definecolor{color2}{rgb}{0,0,0}% secondary scheme color
\definecolor{color3}{rgb}{0,0,0}% tertiary scheme color

% symbols
%--------
% itemize labels (the struts were added to correct inter-item spacing (works for single line items, until a solution is found for multi-line ones...)
\newcommand*{\labelitemi}          {\strut\textcolor{color1}{\large\rmfamily\textbullet}}% the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemii}         {\strut\textcolor{color1}{\large\bfseries-}}
\newcommand*{\labelitemiii}        {\strut\textcolor{color1}{\rmfamily\textperiodcentered}}% alternative: \textasteriskcentered; the \rmfamily is required to force Latin Modern fonts when using sans serif, as OMS/lmss/m/n is not defined and gets substituted by OMS/cmsy/m/n
\newcommand*{\labelitemiv}         {\labelitemiii}

% enumerate labels
\renewcommand{\theenumi}           {\@arabic\c@enumi}
\renewcommand{\theenumii}          {\@alph\c@enumii}
\renewcommand{\theenumiii}         {\@roman\c@enumiii}
\renewcommand{\theenumiv}          {\@Alph\c@enumiv}

% other symbols
\newcommand*{\listitemsymbol}      {\labelitemi~}
\newcommand*{\addresssymbol}       {}
\newcommand*{\mobilephonesymbol}   {}
\newcommand*{\fixedphonesymbol}    {}
\newcommand*{\faxphonesymbol}      {}
\newcommand*{\emailsymbol}         {}
\newcommand*{\homepagesymbol}      {}
\newcommand*{\linkedinsocialsymbol}{}
\newcommand*{\twittersocialsymbol} {}
\newcommand*{\githubsocialsymbol}  {}

% other
%------
% fonts
\AtBeginDocument{\normalfont\color{color0}}

% strings for internationalisation
\newcommand*{\refname}{Publications}
\newcommand*{\enclname}{Enclosure}

% makes the footer (normally used both for the resume and the letter)
% usage: \makefooter
\newcommand*{\makefooter}{}%

% loads a style variant
% usage: \moderncvstyle{<style variant name>}
\newcommand*{\moderncvstyle}[1]{
  \RequirePackage{moderncvstyle#1}}
  
% loads a color scheme
% usage: \moderncvcolor{<color scheme name>}
\newcommand*{\moderncvcolor}[1]{
  \RequirePackage{moderncvcolor#1}}

% loads an icons set
% usage: \moderncvicons{<icon set name>}
\newcommand*{\moderncvicons}[1]{
  \RequirePackage{moderncvicons#1}}

% recomputes all automatic lengths
\newcommand*{\recomputelengths}{\recomputecvlengths}
\AtBeginDocument{\recomputelengths{}}

% creates a length if not yet defined
\newcommand*{\@initializelength}[1]{%
  \ifdefined#1\else\newlength{#1}\fi}


%-------------------------------------------------------------------------------
%                resume design commands definitions
%-------------------------------------------------------------------------------
% elements
% defines one's picture (optional)
% usage: photo[<picture width>][<picture frame thickness>]{<picture filename>}
\NewDocumentCommand{\photo}{O{64pt}O{0.4pt}m}{\def\@photowidth{#1}\def\@photoframewidth{#2}\def\@photo{#3}}
\newcommand*{\quote}[1]{\def\@quote{#1}}

% fonts
\newcommand*{\namefont}{}
\newcommand*{\titlefont}{}
\newcommand*{\addressfont}{}
\newcommand*{\quotefont}{}
\newcommand*{\sectionfont}{}
\newcommand*{\subsectionfont}{}
\newcommand*{\hintfont}{}
\newcommand*{\pagenumberfont}{\addressfont\itshape}

% styles
\newcommand*{\namestyle}[1]{{\namefont#1}}
\newcommand*{\titlestyle}[1]{{\titlefont#1}}
\newcommand*{\addressstyle}[1]{{\addressfont#1}}
\newcommand*{\quotestyle}[1]{{\quotefont#1}}
\newcommand*{\sectionstyle}[1]{{\sectionfont#1}}
\newcommand*{\subsectionstyle}[1]{{\subsectionfont#1}}
\newcommand*{\hintstyle}[1]{{\hintfont#1}}
\newcommand*{\pagenumberstyle}[1]{{\pagenumberfont#1}}

% recompute all resume lengths
\newcommand*{\recomputecvlengths}{}

% internal maketitle command to issue a new line only when required
\newif\if@firstdetailselement\@firstdetailselementtrue
\newcommand*{\makenewline}{
  \if@firstdetailselement%
    \strut% to ensure baseline alignment, e.g. with when put in the margin vs sections that also contains a \strut
  \else%
    \\\fi%
  \@firstdetailselementfalse}

% makes the resume title
% usage: \makecvtitle
\newcommand*{\makecvtitle}{}

% makes the resume footer
% usage: \makecvfooter
\newcommand*{\makecvfooter}{\makefooter}

% makes a resume section
% usage: \section{<title>}
% identical starred and non-starred variants should be defined for compatibility with other packages (e.g. with natbib, that uses \section*{} for the bibliography header)
\NewDocumentCommand{\section}{sm}{}

% makes a resume subsection
% usage: \subsection{title}
\NewDocumentCommand{\subsection}{sm}{}

% makes a resume line with a header and a corresponding text
% usage: \cvitem[spacing]{header}{text}
\newcommand*{\cvitem}[3][.25em]{}

% makes a resume line 2 headers and their corresponding text
% usage: \cvdoubleitem[spacing]{header1}{text1}{header2}{text2}
\newcommand*{\cvdoubleitem}[5][.25em]{}

% makes a resume line with a list item
% usage: \cvlistitem[label]{item}
\newcommand*{\cvlistitem}[2][\listitemsymbol]{}

% makes a resume line with 2 list items
% usage: \cvlistdoubleitem[label]{item1}{item2}
\newcommand*{\cvlistdoubleitem}[3][\listitemsymbol]{}

% makes a typical resume job / education entry
% usage: \cventry[spacing]{years}{degree/job title}{institution/employer}{localization}{optionnal: grade/...}{optional: comment/job description}
\newcommand*{\cventry}[7][.25em]{}

% makes a resume entry with a proficiency comment
% usage: \cvitemwithcomment[spacing]{header}{text}{comment}
\newcommand*{\cvitemwithcomment}[4][.25em]{}

% makes a generic hyperlink
% usage: \link[optional text]{link}
\newcommand*{\link}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\href{#2}{#2}}%
    {\href{#2}{#1}}}

% makes a http hyperlink
% usage: \httplink[optional text]{link}
\newcommand*{\httplink}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\href{http://#2}{#2}}%
    {\href{http://#2}{#1}}}

% makes an email hyperlink
% usage: \emaillink[optional text]{link}
\newcommand*{\emaillink}[2][]{%
  \ifthenelse{\equal{#1}{}}%
    {\href{mailto:#2}{#2}}%
    {\href{mailto:#2}{#1}}}

% cvcolumns environment, where every column is created through \cvcolumn
% usage: \begin{cvcolumns}
%          \cvcolumn[width]{head}{content}
%          \cvcolumn[width]{head}{content}
%          ...
%        \end{cvcolumns}
% where "width" is the width as a fraction of the line length (between 0 and 1), "head" is the column header and "content" its content
\newcounter{cvcolumnscounter}% counter for the number of columns
\newcounter{cvcolumnsautowidthcounter}% counter for the number of columns with no column width provided, and which will then be equally distributed
\newcounter{tmpiteratorcounter}% counter for any temporary purpose (e.g., iterating loops)
\newlength{\cvcolumnsdummywidth}\setlength{\cvcolumnsdummywidth}{1000pt}% dummy width for total width, in order to enable arithmetics (TeX has no float variables, only integer counters or lengths)
\newlength{\cvcolumnswidth}% total width available for head / content
\newlength{\cvcolumnsautowidth}% total width of columns with no explicit width provided
\newlength{\cvcolumnautowidth}% width of one of the columns with no explicit width provided (based on equal distribution of remaining space)
\newif\if@cvcolumns@head@empty% whether or not at least one of the columns has a header
\newenvironment*{cvcolumns}%
  {% at environment opening: reset counters, lengths and ifs
    \setcounter{cvcolumnscounter}{0}%
    \setcounter{cvcolumnsautowidthcounter}{0}%
    \setlength{\cvcolumnsautowidth}{\cvcolumnsdummywidth}%
    \setlength{\cvcolumnautowidth}{0pt}%
    \@cvcolumns@head@emptytrue}%
  {% at environment closing: typeset environment
    % compute the width of each cvcolumn, considering a spacing of \separatorcolumnwidth and the columns with set width
    \ifnum\thecvcolumnscounter>0%
      \setlength{\cvcolumnswidth}{\maincolumnwidth-\value{cvcolumnscounter}\separatorcolumnwidth+\separatorcolumnwidth}%
      \setlength{\cvcolumnautowidth}{\cvcolumnswidth*\ratio{\cvcolumnsautowidth}{\cvcolumnsdummywidth}/\value{cvcolumnsautowidthcounter}}\fi%
    % pre-aggregate the tabular definition, heading and content (required before creating the tabular, as the tabular environment doesn't like loops --- probably because "&" generates a \endgroup)
    % - the tabular definition is the aggregation of the different "\cvcolumn<i>@def" (by default "p{\cvcolumnautowidth}"), separated by "@{\hspace*{\separatorcolumnwidth}}"
    % - the tabular heading is the aggregation of the different "\cvcolumn<i>@head", separated by "&"
    % - the tabular content is the aggregation of the different "\cvcolumn<i>@content", separated by "&"
    % to aggregate the different elements, \protected@edef or \g@addto@macro is required to avoid that \cvcolumns@def, -@head and -@content get expanded in subsequent redefinitions, which would cause errors due to the expansions of \hspace, of \subsectionstyle and possibly of user content/argument such as font commands
    \def\cvcolumns@def{}%
    \def\cvcolumns@head{}%
    \def\cvcolumns@content{}%
    \setcounter{tmpiteratorcounter}{0}%
    % loop based on \g@addto@macro
    \loop\ifnum\thetmpiteratorcounter<\thecvcolumnscounter%
      \ifnum\thetmpiteratorcounter=0\else%
        \g@addto@macro\cvcolumns@def{@{\hspace*{\separatorcolumnwidth}}}%
        \g@addto@macro\cvcolumns@head{&}%
        \g@addto@macro\cvcolumns@content{&}\fi%
      \expandafter\g@addto@macro\expandafter\cvcolumns@def\expandafter{\csname cvcolumn\roman{tmpiteratorcounter}@def\endcsname}%
      \expandafter\g@addto@macro\expandafter\cvcolumns@head\expandafter{\csname cvcolumn\roman{tmpiteratorcounter}@head\endcsname}%
      \expandafter\g@addto@macro\expandafter\cvcolumns@content\expandafter{\csname cvcolumn\roman{tmpiteratorcounter}@content\endcsname}%
      \stepcounter{tmpiteratorcounter}%
      \repeat%
%    % same loop based on \protected@edef
%    \loop\ifnum\thetmpiteratorcounter<\thecvcolumnscounter%
%      \ifnum\thetmpiteratorcounter=0\else%
%        \protected@edef\cvcolumns@def{\cvcolumns@def @{\hspace*{\separatorcolumnwidth}}}%
%        \protected@edef\cvcolumns@head{\cvcolumns@head &}%
%        \protected@edef\cvcolumns@content{\cvcolumns@content &}\fi%
%      \expandafter\protected@edef\expandafter\cvcolumns@def\expandafter{\expandafter\cvcolumns@def\expandafter\protect\csname cvcolumn\roman{tmpiteratorcounter}@def\endcsname}%
%      \expandafter\protected@edef\expandafter\cvcolumns@head\expandafter{\expandafter\cvcolumns@head\expandafter\protect\csname cvcolumn\roman{tmpiteratorcounter}@head\endcsname}%
%      \expandafter\protected@edef\expandafter\cvcolumns@content\expandafter{\expandafter\cvcolumns@content\expandafter\protect\csname cvcolumn\roman{tmpiteratorcounter}@content\endcsname}%
%      \stepcounter{tmpiteratorcounter}%
%      \repeat%
    % create the tabular
    \cvitem{}{%
      \begin{tabular}{\cvcolumns@def}%
        \if@cvcolumns@head@empty\else%
          \cvcolumns@head%\\[-.8em]%
%          {\color{color1}\rule{\maincolumnwidth}{.25pt}}%
          \\\fi%
        \cvcolumns@content%
      \end{tabular}}}

% cvcolumn command, to create a column inside a cvcolumns environment
% usage: \cvcolumn[width]{head}{content}
% where "width" is the width as a fraction of the line length (between 0 and 1), "head" is the column header and "content" its content ("head" and "content" can contain "\\", "\newline" or any other paragraph command such as "itemize")
\newcommand*{\cvcolumn}[3][\cvcolumnautowidth]{%
%  \def\cvcolumn@width{}%
  \ifthenelse{\equal{#1}{\cvcolumnautowidth}}%
    {% if no width fraction is provided, count this column as auto-adjusted and set its width to \cvcolumnsautowidth
      \stepcounter{cvcolumnsautowidthcounter}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@def\endcsname{p{\cvcolumnautowidth}}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@head\endcsname{\protect\parbox[b]{\cvcolumnautowidth}{\protect\subsectionstyle{#2}}}}%
    {% if a width is provided, set the width of the column to it and decrease the available space for auto-adjusted columns
      \addtolength{\cvcolumnsautowidth}{-#1\cvcolumnsdummywidth}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@def\endcsname{p{#1\cvcolumnswidth}}%
      \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@head\endcsname{\protect\parbox[b]{#1\cvcolumnswidth}{\protect\subsectionstyle{#2}}}}%
  \ifthenelse{\equal{#2}{}}{}{\@cvcolumns@head@emptyfalse}%
  \expandafter\expandafter\expandafter\def\expandafter\csname cvcolumn\roman{cvcolumnscounter}@content\endcsname{\protect\cvcolumncell{#3}}%
  \stepcounter{cvcolumnscounter}}

% internal cvcolumncell command, that enables a cvcolumn cell to contain paragraph commands (lists, newlines, etc)
\newcommand*{\cvcolumncell}[1]{{% put cell inside a group, so that command redefinitions are only local
  % roughly restore \\ to its regular definition (outside of tabular)
  \renewcommand*{\\}{\newline}%
  % enclose the contents of the cell inside a vertical box, to allow paragraph commands
  \protect\vtop{#1}}}

% thebibliography environment, for use with BibTeX and possibly multibib
\newlength{\bibindent}
\setlength{\bibindent}{1.5em}
% bibliography item label
\newcommand*{\bibliographyitemlabel}{}% use \@biblabel{\arabic{enumiv}} for BibTeX labels
%\newif\if@multibibfirstbib\@multibibfirstbibfalse
% bibliography head (section, etc}, depending on whether multibib is used
\newcommand*{\bibliographyhead}[1]{\section{#1}}
\AtEndPreamble{\@ifpackageloaded{multibib}{\renewcommand*{\bibliographyhead}[1]{\subsection{#1}}}{}}
% thebibliography environment definition
\newenvironment{thebibliography}[1]{}{}
\newcommand*{\newblock}{\hskip .11em\@plus.33em\@minus.07em}
\let\@openbib@code\@empty

% itemize, enumerate and description environment
\setlength{\leftmargini}   {1em}
\leftmargin\leftmargini
\setlength{\leftmarginii}  {\leftmargini}
\setlength{\leftmarginiii} {\leftmargini}
\setlength{\leftmarginiv}  {\leftmargini}
\setlength{\leftmarginv}   {\leftmargini}
\setlength{\leftmarginvi}  {\leftmargini}
\setlength{\labelsep}      {.5em}% this is the distance between the label and the body, but it pushes the label to the left rather than pushing the body to the right (to do the latter, modify \leftmargin(i)
\setlength{\labelwidth}    {\leftmargini}% unfortunately, \labelwidth is not defined by item level (i.e. no \labeliwidth, \labeliiwidth, etc)
\addtolength{\labelwidth}  {-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\p@enumii(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
% description label
\newcommand*\descriptionlabel[1]{\hspace\labelsep\normalfont\bfseries#1}

% classical \today definition
\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

%\newcommand{\widthofautobox}[1]{%
%  \widthof{\begin{tabular}{@{}l@{}}#1\end{tabular}}}

%\newcommand{\autobox}[2][b]{%
%  \parbox[#1]{\widthofautobox{#2}}{#2}}


%-------------------------------------------------------------------------------
%                letter design commands definitions
%-------------------------------------------------------------------------------
% elements
\newcommand*{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}
\renewcommand*{\date}[1]{\def\@date{#1}}\date{\today}
\newcommand*{\opening}[1]{\def\@opening{#1}}
\newcommand*{\closing}[1]{\def\@closing{#1}}
\newcommand*{\enclosure}[2][]{%
  % if an optional argument is provided, use it to redefine \enclname
  \ifthenelse{\equal{#1}{}}{}{\renewcommand*{\enclname}{#1}}%
  \def\@enclosure{#2}}

% recompute all letter lengths
\newcommand*{\recomputeletterlengths}{}

% makes the letter title
% usage: \makelettertitle
\newcommand*{\makelettertitle}{}

% makes the letter footer
% usage: \makeletterfooter
\newcommand*{\makeletterfooter}{\makefooter}

% makes the letter closing
% usage: \makeletterclosing
\newcommand*{\makeletterclosing}{}


\endinput


%% end of file `moderncv.cls'.
