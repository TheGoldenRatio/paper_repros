clear
set more off

cd "\\Client\C$\Users\jchang\Downloads\116198-V1\data\Stata_Files"
use mpaz_master_NATIVE.dta, clear
local tables = "\\Client\C$\Users\jchang\Downloads\"

*** Statistics for Paper 
tab cbn_feb28 if d1==0 // 6 out of 472 employees who were defaulted out chose to contribute at 5%

egen mpaz_bonus_d0_high = sum(mpaz_bonus) if d1==0 & high==1
tab  mpaz_bonus_d0_high

// Effect of defaults on participation and contribution (Feb 28th values)
reg participates_feb28 d1, r
estadd local samplestr "Complete"
est store col1
reg participates_feb28 d1 if low==1,r
estadd local samplestr "0\% Match"
est store col2
reg participates_feb28 d1 if med==1,r
estadd local samplestr "25\% Match"
est store col3
reg participates_feb28 d1 if high==1,r
estadd local samplestr "50\% Match"
est store col4

reg cbn_feb28 d1, r
estadd local samplestr "Complete"
est store col5
reg cbn_feb28 d1 if low==1,r
estadd local samplestr "0\% Match"
est store col6
reg cbn_feb28 d1 if med==1,r
estadd local samplestr "25\% Match"
est store col7
reg cbn_feb28 d1 if high==1,r
estadd local samplestr "50\% Match"
est store col8

// Effect of defaults on M-Paz final balance
reg mpaz_balance_final d1, r
estadd local samplestr "Complete"
est store col9
reg mpaz_balance_final d1 if low==1,r
estadd local samplestr "0\% Match"
est store col10
reg mpaz_balance_final d1 if med==1,r
estadd local samplestr "25\% Match"
est store col11
reg mpaz_balance_final d1 if high==1,r
estadd local samplestr "50\% Match"
est store col12


estout col1 col2 col3 col4 , cells(b(fmt(%9.2f) nostar) se(par fmt(%9.2f))) ///
		starlevels(* .1 ** .05 *** .01) style(tex) keep(d1 _cons) ///
		stats(samplestr N r2, fmt(0 0 3) label("Sample" "\# Observations" "R-Squared")) ///
		mlabels(,depvars) collabels(none) label title("The Effect of Automatic Enrollment") varlabels(_cons "Constant")
estout col5 col6 col7 col8, cells(b(fmt(%9.2f) nostar) se(par fmt(%9.2f))) ///
		starlevels(* .1 ** .05 *** .01) style(tex) keep(d1 _cons) ///
		stats(samplestr N r2, fmt(0 0 3) label("Sample" "\# Observations" "R-Squared")) ///
		mlabels(,depvars) collabels(none) label title("The Effect of Automatic Enrollment") varlabels(_cons "Constant")
estout col9 col10 col11 col12, cells(b(fmt(%9.2f) nostar) se(par fmt(%9.2f))) ///
		starlevels(* .1 ** .05 *** .01) style(tex) keep(d1 _cons) ///
		stats(samplestr N r2, fmt(0 0 3) label("Sample" "\# Observations" "R-Squared")) ///
		mlabels(,depvars) collabels(none) label title("The Effect of Automatic Enrollment") varlabels(_cons "Constant")


esttab col1 col2 col3 col4 using "`tables'\table1_panela.tex", cells(b(fmt(%9.2f) nostar) se(par fmt(%9.2f))) ///
		starlevels(* .1 ** .05 *** .01) style(tex) keep(d1 _cons) replace ///
		stats(samplestr N r2, fmt(0 0 3) label("Sample" "\# Observations" "R-Squared")) ///
		mlabels(,depvars) collabels(none) label title("The Effect of Automatic Enrollment") varlabels(_cons "Constant")
esttab col5 col6 col7 col8 using "`tables'\table1_panelb.tex", cells(b(fmt(%9.2f) nostar) se(par fmt(%9.2f))) ///
		starlevels(* .1 ** .05 *** .01) style(tex) keep(d1 _cons) replace ///
		stats(samplestr N r2, fmt(0 0 3) label("Sample" "\# Observations" "R-Squared")) ///
		mlabels(,depvars) collabels(none) label title("The Effect of Automatic Enrollment") varlabels(_cons "Constant")
esttab col9 col10 col11 col12 using "`tables'\table1_panelc.tex", cells(b(fmt(%9.2f) nostar) se(par fmt(%9.2f))) ///
		starlevels(* .1 ** .05 *** .01) style(tex) keep(d1 _cons) replace ///
		stats(samplestr N r2, fmt(0 0 3) label("Sample" "\# Observations" "R-Squared")) ///
		mlabels(,depvars) collabels(none) label title("The Effect of Automatic Enrollment") varlabels(_cons "Constant")
