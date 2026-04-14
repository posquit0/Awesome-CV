%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

\documentclass[11pt, a4paper]{awesome-cv}

% Configure page margins
\geometry{left=1.4cm, top=1.2cm, right=1.4cm, bottom=1.5cm, footskip=.5cm}

% 1. NAME FULLY BOLD & FONT THICKNESS FIX
% Redefining header styles to make both first and last name bold
\renewcommand{\headerfirstnamestyle}[1]{{\fontsize{32pt}{1em}\headerfont\bfseries\color{text} #1}}
\renewcommand{\headerlastnamestyle}[1]{{\fontsize{32pt}{1em}\headerfont\bfseries\color{text} #1}}


\setmainfont{Source Sans Pro}
[ 
Path = ./fonts/, UprightFont = *-Regular.otf,
ItalicFont = *-Italic.otf, 
BoldFont = *-Bold.otf, ]

% Color for highlights - Navy Blue (#000080)
\definecolor{navyblue}{HTML}{000080}
\colorlet{awesome}{navyblue}

% DISABLE split color highlighting for section titles
\setbool{acvSectionColorHighlight}{false}

% Force all headers to be solid Navy Blue
\renewcommand{\sectionstyle}[1]{{\fontsize{15pt}{1em}\bodyfont\bfseries\color{awesome} #1}}

% 3. PRISM SINGLE LINE FIX
% Adjusted R column to 8.5cm to give the title (L column) more space 
% while still keeping GitHub links on one line.
\renewcommand*{\cventry}[5]{%
  \vspace{-2.0mm}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 8.5cm} R{8.5cm}}
    \ifempty{#2#3}
      {\entrypositionstyle{#1} & \entrydatestyle{#4} \\}
      {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\
      \entrypositionstyle{#1} & \entrydatestyle{#4} \\}
    \ifstrempty{#5}
      {}
      {\multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}} \\}
  \end{tabular*}%
}

%-------------------------------------------------------------------------------
%	PERSONAL INFORMATION
%-------------------------------------------------------------------------------
\name{An Khanh (Kiki)}{Nguyen}
\mobile{+44 7833 706765}
\email{khanh.nguyen.careers@gmail.com}
\linkedin{an-khanh-nguyen11}
\github{AnKhanhKiki}

%-------------------------------------------------------------------------------
\begin{document}

\makecvheader[C]

\makecvfooter
  {\today}
  {An Khanh (Kiki) Nguyen~~~·~~~Résumé}
  {\thepage}

%-------------------------------------------------------------------------------
%	EDUCATION
%-------------------------------------------------------------------------------
\cvsection{Education}

\begin{cventries}
  \cventry
    {Masters of Science, Mathematics and Computation} 
    {London School of Economics (LSE)} 
    {\textbf{London, UK}} 
    {Sept 2026 - June 2027} 
    {
      \begin{cvitems} 
        \item {\textbf{Coursework:} Mathematical Game Theory, Stochastic Processes, Probability and Measure, Advanced Time Series Analysis, Machine Learning in Financial Mathematics, Mathematics of Cryptocurrencies and the Blockchain, Algorithmic Techniques in Machine Learning.}
      \end{cvitems}
    }
    \vspace{3.0 mm}

  \cventry
    {Bachelor of Engineering (Honours), Mechanical Engineering} 
    {The University of Manchester} 
    {\textbf{Manchester, UK}} 
    {Sept 2023 - June 2026} 
    {
      \begin{cvitems} 
        \item {Grade: \textbf{High First-Class Honours} - Received \textbf{£15,000 Academic Excellence Scholarship}}
        \item {\textbf{Dissertation:} Stochastic Finite Element Modelling for Stress Analysis of Reactor Components (Supervisor: Prof. Paul Mummery).}
      \end{cvitems}
    }
\end{cventries}

%-------------------------------------------------------------------------------
%	EXPERIENCE
%-------------------------------------------------------------------------------
\cvsection{Experience}

\begin{cventries}
  \cventry
    {Quantitative Trading Intern} 
    {SSI Securities Corporation} 
    {\textbf{Hanoi, Vietnam}} 
    {June 2025 - Sept 2025} 
    {
      \begin{cvitems} 
        \item {Gained intuition for \textbf{equity options market making} by understanding live dealer flow: how spreads are sized as a function of \textbf{implied volatility}, inventory risk, and real-time \textbf{delta/gamma/vega exposure} across the desk's book.}
        \item {Monitored the \textbf{auto-hedging system} in real time, tracking when Greek sensitivities breached rebalancing thresholds and how traders responded; developed working familiarity with the \textbf{Black–Scholes finite-difference pricing engine}.}
        \item {Learned the modelling of \textbf{VN30 index arbitrage}, and fair-value spreads between VN30 index futures, \textbf{E1VFVN30 ETF} and the underlying basket: understanding how market frictions \textbf{(tick sizes, T+2 settlement lags and replication costs)} affect exploitable mispricings.}
        \item {Engineered a \textbf{directional alpha signal} using \textbf{Multi-Level Order Flow Imbalance (ML-OFI)}, validating predictive power via \textbf{Granger causality}, \textbf{multivariate OLS} and \textbf{Ridge regression}, presenting results to the trading team.}
      \end{cvitems}
    }
\end{cventries}

%-------------------------------------------------------------------------------
%	PROJECTS & COMPETITION
%-------------------------------------------------------------------------------
\cvsection{Projects \& Competitions}

\begin{cventries}
  \cventry
    {President \& Co-head of Research} 
    {QUANTS@UoM} 
    {\textbf{quantsuom.com}} 
    {April 2025 - April 2026} 
    {
      \begin{cvitems} 
        \item {Lead \textbf{semester-long research projects} in quantitative finance for teams of \textbf{15 undergraduates, masters and PhDs}.}
        \item {Organised weekly educational workshops on mathematics, programming, and economics for \textbf{200+ students}.}
      \end{cvitems}
    }
    \vspace{3.0 mm}

  \cventry
    {Won 2nd Place} 
    {Imperial College's Algothon Trading Competition} 
    {\textbf{github.com/Dominion083/Allocation-Algo}} 
    {2026} 
    {
      \begin{cvitems} 
        \item {Built a \textbf{market-making engine} using a \textbf{Bayesian micro-price model} blending LOB imbalances with consensus VWAP, reducing adverse selection by \textbf{15\%} in high-volatility regimes.}
        \item {Designed a \textbf{risk management system} dynamically modulating inventory skew and spread-capture heuristics across non-linear synthetic derivatives.}
      \end{cvitems}
    }
    \vspace{3.0 mm}

  \cventry
    {Building the first student-led financial exchange} 
    {MANEX (The Manchester Exchange)} 
    {\textbf{Manchester, UK}} 
    {Aug 2025 - April 2026} 
    {
      \begin{cvitems} 
        \item {Co-leading a team to build a student-run financial exchange with a \textbf{low-latency matching engine}, order-book, and settlement infrastructure.}
        \item {Architecting production-ready trade lifecycle flows: order schemas, \textbf{OHLCV aggregation pipeline}, and \textbf{REST API contracts}.}
      \end{cvitems}
    }
    \vspace{3.0 mm}

  \cventry
    {University Hackathon} 
    {PRISM - Portfolio Risk, Investment \& Strategy Management} 
    {\textbf{github.com/cyrusknopf/PRISM-hackathon}} 
    {2025} 
    {
      \begin{cvitems} 
        \item {Orchestrated a university hackathon with \textbf{200+ participants} by designing a trading platform using \textbf{Go} and \textbf{Python}.}
        \item {Engineered a challenge requiring \textbf{NLP analysis} and portfolio selection using an optimised, bespoke \textbf{self-hosted LLM}.}
        \item {Implemented a \textbf{multi-metric evaluation system} as a function of \textbf{Sharpe, Sortino}, and diversity.}
      \end{cvitems}
    }
    \vspace{3.0mm}

  \cventry
    {Rank Top 15 in UK} 
    {IMC Trading Prosperity Challenge 2025} 
    {\textbf{github.com/AnKhanhKiki/IMC-Trading}} 
    {2025} 
    {
      \begin{cvitems} 
        \item {Implemented quantitative trading strategies including \textbf{VWAP market-making}, \textbf{mean reversion}, and \textbf{Black-Scholes option valuation} within a full order-book trading engine.}
        \item {Applied \textbf{log-return volatility estimation} and \textbf{EMA smoothing} to calibrate signals across multiple products in a backtesting framework.}
      \end{cvitems}
    }
\end{cventries}

%-------------------------------------------------------------------------------
%	TECHNICAL SKILLS
%-------------------------------------------------------------------------------
\cvsection{Technical Skills}

\begin{cvskills}
  \cvskill {Programming} {Python, SQL, MatLab.} 
  \cvskill {Skills} {Quantitative Research, Statistical Arbitrage, Options Pricing, Market Making, Time Series Analysis, Risk Management.}
\end{cvskills}

\end{document}