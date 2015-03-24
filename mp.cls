\ProvidesClass{mp}
\LoadClass{beamer}

\RequirePackage{polski}
\RequirePackage[utf8]{inputenc}

\usetheme{PUT}

\usepackage{calc}

\usepackage{diagbox}

\newcommand{\set}[1]{\ensuremath\mathbf{#1}}

\usepackage{xcolor}

%http://tex.stackexchange.com/questions/42619/x-mark-to-match-checkmark
\usepackage{pifont}
\newcommand{\cmark}{\textcolor{green!80!black!50}{\text{\ding{51}}}}
\newcommand{\xmark}{\textcolor{red!80!black!50}{\text{\ding{55}}}}

\newcommand{\R}{\ensuremath\mathbb{R}}
\newcommand{\N}{\ensuremath\mathbb{N}}

%http://tex.stackexchange.com/questions/55000/continuing-enumerate-counters-in-beamer
\newcounter{saveenumi}
\newcommand{\seti}{\setcounter{saveenumi}{\value{enumi}}}
\newcommand{\conti}{\setcounter{enumi}{\value{saveenumi}}}

\usepackage{tikz}
\usetikzlibrary{shapes.misc} 
\usetikzlibrary{positioning,intersections} 
\usetikzlibrary{petri} 
\usetikzlibrary{calc,intersections,through,backgrounds}
\usetikzlibrary{calc,decorations.pathmorphing,patterns}

%robi ladniejsze strzalki
\usepgflibrary{arrows.meta}

\colorlet{color1}{black}
\colorlet{color2}{green!50!black!50}
\colorlet{color3}{blue!50!black!50}
\colorlet{color4}{red!50!black!50}
\tikzset{
	decoration={random steps,segment length=2.5mm,amplitude=0.3mm},
	color1/.style={color=color1},
	color2/.style={color=color2},
	color3/.style={color=color3},
	color4/.style={color=color4},
	set/.style={very thick, decorate},
	diagram/.style={rectangle, rounded corners=1.5mm, very thick, draw=cegla, top color=srebro!10!white, bottom color=srebro!10!white},
	dice/.style={draw=black,thick,rectangle,minimum size=10mm,diagram,node distance=2mm},
	dice token/.style={top color=black, bottom color=black, semitransparent}
}
%http://tex.stackexchange.com/questions/99119/beamer-problematic-use-of-visible-and-only-in-combination-with-tikz-to-draw-a
\tikzset{
	invisible/.style={opacity=0},
		visible on/.style={alt=#1{}{invisible}},
		alt/.code args={<#1>#2#3}{%
			\alt<#1>{\pgfkeysalso{#2}}{\pgfkeysalso{#3}} % \pgfkeysalso doesn't change the path
		},
}

%http://tex.stackexchange.com/questions/6135/how-to-make-beamer-overlays-with-tikz-node
\tikzset{onslide/.code args={<#1>#2}{%
  \only<#1>{\pgfkeysalso{#2}} 
}}

\newcommand{\dice}[1]{\tikz{\node [dice,tokens=#1] {};}}

% % http://tex.stackexchange.com/questions/39296/simulating-hand-drawn-lines
% \pgfdeclaredecoration{penciline}{initial}{
% 	\state{initial}[width=+\pgfdecoratedinputsegmentremainingdistance,auto corner on length=1mm,]{
% 		\pgfpathcurveto%
% 		{% From
% 			\pgfqpoint{\pgfdecoratedinputsegmentremainingdistance}
% 			{\pgfdecorationsegmentamplitude}
% 		}
% 		{%  Control 1
% 			\pgfmathrand
% 				\pgfpointadd{\pgfqpoint{\pgfdecoratedinputsegmentremainingdistance}{0pt}}
% 			{\pgfqpoint{-\pgfdecorationsegmentaspect\pgfdecoratedinputsegmentremainingdistance}%
% 				{\pgfmathresult\pgfdecorationsegmentamplitude}
% 			}
% 		}
% 		{%TO 
% 			\pgfpointadd{\pgfpointdecoratedinputsegmentlast}{\pgfpoint{1pt}{1pt}}
% 		}
% 	\state{final}{}
% }


%XXX: uwaga natury ogólnej: malo tekstu, dużo obrazków, zgodnie z zasadą: zobaczyć (na slajdzie) + usłyszeć (ode mnie)
\title{Metody probabilistyczne}
\author{Jędrzej Potoniec}
\date{}
