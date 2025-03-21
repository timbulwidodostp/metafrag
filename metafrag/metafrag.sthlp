{smcl}
{* *! version 2.0.0 15Jul2020}{...}
{cmd:help metafrag}{right: ({browse "https://doi.org/10.1177/1536867X221083856":SJ22-1: st0664})}
{hline}

{title:Title}

{p2colset 5 17 19 2}{...}
{p2col:{cmd:metafrag} {hline 2}}Fragility index for meta-analysis{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{cmd:metafrag}
[{cmd:,} {it:options}]

{pstd}
Before using {cmd:metafrag}, you must first use {helpb meta_esize:meta esize}
to compute effect sizes for a two-group comparison of binary outcomes.

{synoptset 22}{...}
{synopthdr}
{synoptline}
{synopt :{opt ef:orm}}report exponentiated results{p_end}
{synopt:{opt for:est}[{cmd:(}{it:{help meta_forestplot:forestplot}}{cmd:)}]}display a forest plot of the studies
after modification; specifying {cmd:forest} without options uses the default
{help meta_forestplot:forest plot} settings{p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
{opt metafrag} is an extension of the fragility index for single studies with
a binary outcome (Walsh et al. 2014) to meta-analysis (Atal et al. 2019).  The
fragility index for meta-analysis is defined as the minimum number of patients
from one or more trials included in the meta-analysis for which a modification
of the event status (that is, changing events to nonevents or nonevents to
events) would change the statistical significance of the pooled treatment
effect (Atal et al. 2019).  As such, a fragility index score of zero indicates
that no modification of the event status is necessary to elicit a
statistically nonsignificant pooled treatment effect.  Conversely, a large
fragility index score indicates that many modifications to the event status
are required to change a statistically significant pooled effect to
nonsignificant (and thus, the results may be considered more robust).

{pstd}
{opt metafrag} is a postestimation command for {helpb meta_esize:meta esize},
thereby capitalizing on the comprehensive list of options available in
official Stata's {helpb meta:meta} suite for computing effect sizes for binary
outcomes.


{title:Options}

{phang}
{cmd:eform} reports exponentiated effect sizes and transforms their respective
confidence intervals whenever applicable.  By default, the results are
displayed in the metric declared with {cmd:meta esize} such as log odds-ratios
and log risk-ratios.  {cmd:eform} uses odds ratios when used with log
odds-ratios declared with {cmd:meta esize} or risk ratios when used with the
declared log risk-ratios.  {cmd:eform} affects how results are displayed, not
how they are estimated and stored.

{phang}
{opt forest}[{cmd:(}{it:{help meta_forestplot:forestplot}}{cmd:)}] displays a
forest plot of the studies after modification to the events and nonevents of
included studies to move the pooled effect from statistically significant to
nonsignificant (the user can set the level that "significance" represents
using the {cmd:level()} option in {helpb meta_esize:meta esize}).  Specifying
{cmd:forest} without options uses the default
{help meta_forestplot:forest plot} settings (with only the column headers
modified).  Studies that have event modifications are highlighted in blue
(when events are added) and red (when events are subtracted).


{title:Remarks}

{pstd}
{opt metafrag} produces results consistent with those of the R package 
{browse "https://github.com/iatal/fragility_ma":{cmd:fragility_ma}} and its
related website {browse "http://www.clinicalepidemio.fr/fragility_ma/"}.
However, there are some differences between the software programs: 1) Stata's
{helpb meta_esize:meta esize} command does not support the combination of
random effects with the Mantel-Haenszel method (see
{helpb meta_esize##remethod:meta esize}), whereas
{browse "https://github.com/iatal/fragility_ma":{cmd:fragility_ma}}, which
uses the
{browse "https://www.rdocumentation.org/packages/meta/versions/4.9-7/topics/metabin":{cmd:metabin}}
package for computing pooled treatment effects, does support this combination;
2) Stata's {helpb meta_esize:meta esize} handles zero cells somewhat
differently from 
{browse "https://www.rdocumentation.org/packages/meta/versions/4.9-7/topics/metabin":{cmd:metabin}},
possibly leading to slightly different results between software packages; and
3) when there are ties between studies in the computed maximum (minimum)
confidence level at any iteration, 
{browse "https://github.com/iatal/fragility_ma":{cmd:fragility_ma}}
reports the fragility index that includes the modifications to all tied
studies.  Conversely, {cmd:metafrag} reports both the fragility index
for each iteration in the loop where any event modification occurs and
the total number of modifications if there are ties.


{title:Examples}

{pstd}
Load example data{p_end}
{phang2}{bf:{stata "webuse bcgset, clear":. webuse bcgset}}{p_end}

{pstd}
Use {helpb meta_esize:meta esize} to compute effect sizes for the log
risk-ratio using a random-effects model{p_end}
{phang2}
{bf:{stata "meta esize npost nnegt nposc nnegc, esize(lnrratio) studylabel(studylbl)":. meta esize npost nnegt nposc nnegc, esize(lnrratio) studylabel(studylbl)}}{p_end}

{pstd}
Generate a forest plot to review the original pooled estimates{p_end}
{phang2}
{bf:{stata "meta forestplot, eform nullrefline":. meta forestplot, eform nullrefline}}{p_end}

{pstd}
Compute the fragility index for the meta-analysis, specifying that the results
be presented in exponentiated form in a forest plot{p_end}
{phang2}
{bf:{stata "metafrag, forest eform":. metafrag, forest eform}}{p_end}

{pstd}
The results indicate that the fragility index is 28 and that 2 trials
were modified -- with the first adding 8 events to group 1 and
subtracting 9 events from group 2, and the second adding 11 events to
group 1{p_end}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:metafrag} stores the following in {cmd:r()}:

{synoptset 16 tabbed}{...}
{p2col 5 16 20 2: Scalars}{p_end}
{synopt:{cmd:r(frag)}}fragility index for meta-analysis{p_end}
{synopt:{cmd:r(frag_ties)}}fragility index for meta-analysis when there are ties{p_end}
{synopt:{cmd:r(changes)}}number of studies in which events were modified{p_end}
{p2colreset}{...}


{title:References}

{phang}
Atal, I., R. Porcher, I. Boutron, and P. I. Ravaud. 2019. The statistical
significance of meta-analyses is frequently fragile: Definition of a fragility
index for meta-analyses.  {it:Journal of Clinical Epidemiology} 111: 32-40.
{browse "https://doi.org/10.1016/j.jclinepi.2019.03.012"}.

{phang}
Walsh, M., S. K. Srinathan, D. F. McAuley, M. Mrkobrada, O. Levine, C. Ribic,
A. O.  Molnar, N. D. Dattani, A. Burke, G. Guyatt, L. Thabane, S. D. Walter,
J. Pogue, and P. J. Devereaux. 2014. The statistical significance of
randomized controlled trial results is frequently fragile: A case for a
fragility index.  {it:Journal of Clinical Epidemiology} 67: 622-628.
{browse "https://doi.org/10.1016/j.jclinepi.2013.10.019"}.


{marker citation}{...}
{title:Citation of metafrag}

{pstd}
{cmd:metafrag} is not an official Stata command.  It is a free contribution to
the research community, like an article.  Please cite it as such:{p_end}

{phang2}
Linden, A. 2019. metafrag: Stata module to compute the fragility index for
meta-analysis. Statistical Software Components S458717, Department of
Economics, Boston College.  
{browse "https://ideas.repec.org/c/boc/bocode/s458717.html"}.

{phang2}
Linden, A. 2022. Computing the fragility index for randomized
trials and meta-analyses using Stata. {it:Stata Journal} 22: 77-88.
{browse "https://doi.org/10.1177/1536867X221083856"}.


{title:Acknowledgments}

{p 4 4 2}
I thank John Moran for advocating that I write this package.  I also thank
Ignacio Atal for his support in testing the results reported by {cmd:metafrag}
to assess their consistency with his R package {cmd:fragility_ma} and website
{browse "http://www.clinicalepidemio.fr/fragility_ma/"}.  Finally, I thank
Houssein Assaad at StataCorp for providing details of how Stata and R differ
in their respective computations for meta-analyses.


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
Help:  {manhelp meta META}, {manhelp meta_esize META:meta esize}, 
{manhelp meta_summarize META:meta summarize}, 
{manhelp meta_forestplot META: meta forestplot},
{helpb fragility} (if installed){p_end}
