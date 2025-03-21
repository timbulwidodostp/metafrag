*! 1.1.1 Ariel Linden 30Nov2021 // fixed word-wrapping for description text
*! 1.1.0 Ariel Linden 02Nov2021 // changed syntax to mirror that of meta esize (binary case)
*! 1.0.0 Ariel Linden 28Oct2019

program define fragility, rclass
version 11.0

			syntax anything  [,			///
				LEVel(real 0.05)		/// critical P
				CHI2					/// use Pearson's chi-squared instead of Fisher's exact test
				DETail					/// if user wants to see all analyses as they run
				]                    

				preserve
				numlist "`anything'", min(4) max(4)
				tokenize `anything', parse(" ")

				local n11 `1' // Group 1's number of events
				local n12 `2' // Group 1's number of non-events 
				local n21 `3' // Group 2's number of events
				local n22 `4' // Group 2's number of non-events

				confirm integer number `n11'
				confirm integer number `n11'
				confirm integer number `n21'
				confirm integer number `n22'
                        
				if `n11'<0 | `n12'<0 | `n21'<0 | `n22'<0 { 
					di in red "negative numbers invalid"
					exit 411
				}

				local denom = `n11' + `n12' + `n21' + `n22' // total sample size

				// ensure group with lowest event count is first 
				if `n11' <= `n21' {
					local group "1"
					local a = `n11'
					local b = `n12'
					local c = `n21'
					local d = `n22'
				}
				else {
					local group "2"
					local a = `n21'
					local b = `n22'
					local c = `n11'
					local d = `n12'
				}
				
				if "`chi2'" != "" {
					local method chi2
					local test "Pearson's chi-squared test."
					local pval = r(p)
				} 
				else {
					local method exact
					local test "Fisher's exact test."
					local pval = r(p_exact)
				}

								
				if "`detail'" == "" local qui "quietly"
			
				// run original data to get starting p-value
				`qui' di _n %~50s `"Original Test Results"'
				`qui' tabi `a' `b' \ `c' `d' , `method'
				
				if "`chi2'" != "" {
					local pval = r(p)
				} 
				else {
					local pval = r(p_exact)
				}
				

				local i = 0

				// loop over 2 X 2 tables increasing the events by 1 in the group with lowest initial events
				`qui' {
					di _n
					di _n %~50s `"Increasing the event rate"'
					while `pval' <= `level' {
						local a = `a' + `i'
						local b = `b' - `i'
						tabi `a' `b' \ `c' `d' , `method'
						local i = 1

						if "`chi2'" != "" {
							local pval = r(p)
						} 
						else {
							local pval = r(p_exact)
						}
					}

					if `n11' <= `n21' {
						local fi = `a' - `n11'
					}
					else {
						local fi = `a' - `n21'
					}
				} // end quietly
				local fq = (`fi'/`denom')
				
				// output
				di _n
				di as txt "   Fragility index: " as result %1.0f `fi'
				di as txt "   Fragility quotient: " as result %5.3f `fq'
				di as txt "   {it:p}-value (`method'): " as result %5.3f `pval'
				
		
				// description of fragility index
				if `fi' > 0 { 
					di _n
					di as txt "   A fragility index of " %1.0f `fi' " indicates that group " %1.0f `group' 
					di as txt "   would require " %1.0f `fi' " additional events to obtain" 
					di as txt "   a {it:p}-value >= "  %5.3f `level' " using `test' "
				}
				else {
					di _n
					di as txt "   A fragility index of " %1.0f `fi' " indicates that neither group "
					di as txt "   requires additional events to obtain a {it:p}-value >= " %5.3f `level' ""
					di as txt "   using `test' "
				}

				// return list
				return scalar pval = `pval'
				return scalar fq = `fq'
				return scalar fi = `fi'
				
end

				
