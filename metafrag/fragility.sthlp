{smcl}
{* *! version 1.1.0 02Nov2021}{...}
{* *! version 1.0.0 29Oct2019}{...}
{cmd:help fragility}{right: ({browse "https://doi.org/10.1177/1536867X221083856":SJ22-1: st0664})}
{hline}

{title:Title}

{p2colset 5 18 20 2}{...}
{p2col:{cmd:fragility} {hline 2}}Fragility index and quotient{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmd:fragility}
{it:#n11 #n12 #n21 #n22}
[{cmd:,} {it:options}]

{pstd}
In the syntax, variables {it:#n11} and {it:#n12} contain the respective
numbers of events and nonevents from individuals in group 1 (treatment), and
variables {it:#n21} and {it:#n22} contain the respective numbers for group 2
(control).

{synoptset 10}{...}
{synopthdr}
{synoptline}
{synopt :{opt lev:el(#)}}desired {it:p}-value threshold level at which to
test statistical significance; default is {cmd:level(0.05)}{p_end}
{synopt :{opt chi:2}}compute fragility index based on Pearson's chi-squared test; default is Fisher's exact test{p_end}
{synopt:{opt det:ail}}display all output documenting the steps performed to obtain the final results{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
{opt fragility} computes both the fragility index as described in Walsh et al.
(2014) and the fragility quotient as proposed by Ahmed, Fowler, and McCredie
(2016).  The fragility index represents the absolute number of additional
events (primary endpoints) required to obtain a {it:p}-value greater than or
equal to a predetermined statistical significance threshold (typically set to
0.05).  The fragility index is computed by adding an event to the group with
the smaller number of events (and subtracting a nonevent from the same group
to keep the total number of patients constant) and recomputing the two-sided
significance test (either Fisher's exact test or Pearson's chi-squared test).
Events are iteratively added until the first time the computed {it:p}-value
becomes equal to or greater than the desired {opt level()}.

{pstd}
The fragility quotient is a relative measure of fragility that simply divides
the absolute fragility index by the total sample size (Ahmed, Fowler, and
McCredie 2016).  The user is directed to the references provided below for a
comprehensive discussion of the usefulness and limitations of these two
measures.


{title:Options}

{phang}
{cmd:level(}{it:#}{cmd:)} specifies the desired {it:p}-value threshold level
at which to test statistical significance.  Most disciplines tend to use the
{it:p}-value threshold of 0.05 to imply that the observed result is unlikely
to occur by chance.  However, some disciplines set the threshold for
statistical significance more liberally to 0.10, while others may set the
threshold more conservatively, such as to 0.01.  {opt level(#)} allows users
to set their own threshold.  The default is {cmd:level(0.05)}.

{phang}
{cmd:chi2} calculates and displays Pearson's chi-squared for the hypothesis
that the rows and columns in a two-way table are independent.  The default is
Fisher's exact test, which generally produces more conservative estimates.

{phang}
{cmd:detail} displays all the 2 x 2 tables produced during the iterative
process of adding events to the group with the lowest actual number of events
until the {it:p}-value threshold is met or surpassed.


{title:Examples}

{pstd}
Example 1 from Walsh et al. (2014), in which group 1 has 1 event (99
nonevents) and group 2 has 9 events (91 nonevents).  The resulting fragility
index of 1 suggests that the inference of a treatment effect is "fragile".
That is, only one additional event is needed to flip the results from being
statistically significant to nonsignificant at the 0.05 level.{p_end}
{phang2}{bf:{stata "fragility 1 99 9 91":. fragility 1 99 9 91}} {p_end}

{pstd}
Example 2 from Walsh et al. (2014), in which group 1 has 200 events (3,800
nonevents) and group 2 has 250 events (3,750 nonevents).  Here the resulting
fragility index is 9, suggesting the results are less "fragile".{p_end}
{phang2}{bf:{stata "fragility 200 3800 250 3750":. fragility 200 3800 250 3750}} {p_end}

{pstd}
Same as above, but specifying that Pearson's chi-squared test be used rather
than the default, Fisher's exact test.{p_end}
{phang2}{bf:{stata "fragility 200 3800 250 3750, chi2":. fragility 200 3800 250 3750, chi2}} {p_end}

{pstd}
Same as above, but further requesting to display all the details.{p_end}
{phang2}{bf:{stata "fragility 200 3800 250 3750, chi2 detail":. fragility 200 3800 250 3750, chi2 detail}} {p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:fragility} stores the following in {cmd:r()}:

{synoptset 16 tabbed}{...}
{p2col 5 16 20 2: Scalars}{p_end}
{synopt:{cmd:r(fi)}}fragility index{p_end}
{synopt:{cmd:r(fq)}}fragility quotient{p_end}
{synopt:{cmd:r(pval)}}{it:p}-value at the fragility index{p_end}
{p2colreset}{...}


{title:References}

{phang}
Ahmed, W., R. A. Fowler, and V. A. McCredie. 2016. Does sample size matter
when interpreting the fragility index? 
{it:Critical Care Medicine} 44: e1142-e1143.
{browse "https://doi.org/10.1097/CCM.0000000000001976"}.

{phang}
Walsh, M., S. K. Srinathan, D. F. McAuley, M. Mrkobrada, O. Levine, C. Ribic,
A. O.  Molnar, N. D. Dattani, A. Burke, G. Guyatt, L. Thabane, S. D. Walter,
J. Pogue, and P. J. Devereaux. 2014. The statistical significance of
randomized controlled trial results is frequently fragile: A case for a
fragility index.  {it:Journal of Clinical Epidemiology} 67: 622-628.
{browse "https://doi.org/10.1016/j.jclinepi.2013.10.019"}.


{marker citation}{...}
{title:Citation of fragility}

{pstd}
{cmd:fragility} is not an official Stata command.  It is a free contribution
to the research community, like an article.  Please cite it as such:{p_end}

{phang2}
Linden, A. 2019. fragility: Stata module to compute the fragility index and
quotient. Statistical Software Components S458708,
Department of Economics, Boston College.
{browse "https://ideas.repec.org/c/boc/bocode/s458708.html"}.

{phang2}
Linden, A. 2022. Computing the fragility index for randomized
trials and meta-analyses using Stata. {it:Stata Journal} 22: 77-88.
{browse "https://doi.org/10.1177/1536867X221083856"}.


{title:Acknowledgment}

{p 4 4 2}
I thank John Moran for advocating that I write this package.


{title:Author}

{p 4 4 2}
Ariel Linden{break}
President, Linden Consulting Group{break}
San Francisco, CA{break}
alinden@lindenconsulting.org{break}


{marker alsosee}{...}
{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 22, number 1: {browse "https://doi.org/10.1177/1536867X221083856":st0664}{p_end}

{p 7 14 2}
Help:  {manhelp tabi R}{p_end}
