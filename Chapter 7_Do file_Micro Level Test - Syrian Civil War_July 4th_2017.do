***** Chapter 7_Micro Level Test - Syrian Civil War *****

** Panel Data Format

gen date=ym(year, month)

xtset subdistrict_id date 


*** Creating within-group identifier

sort subdistrict_english year month

by subdistrict_english: gen ordernu=_n
 
by subdistrict_english: gen new_idp=idp[47]


** Data Exploration

** Khassam Subdistrict seems to be an outlier

histogram total_ind 

scatter total_ind mean, mlabel(subdistrict_english)

twoway (scatter total_ind mean, mlabel(subdistrict_english))

*Interpolation of Population (IDP) variable by yslope

by subdistrict_english: ipolate idpv3 yslope, gen(ipol_idp)

by subdistrict_english: ipolate idpv3 yslope, gen(v2_ipol_idp) epolate

*Interpolation of Population (IDP) variable by Trend in IDP

by subdistrict_english: ipolate idp_2 trend_idp, gen(idpol_new)

by subdistrict_english: ipolate idp_2 trend_idp, gen(idpol_new_2) epolate



**** Descriptive statistics - Table 7.1

local controls "log_pop_2004 idpol_new_2 share_urban_2004 sc_emplgov road_density sunni alawites war_age russian_intervention gcpv1 area"

estpost summarize total_ind `controls' dxmean dxmean_2 dxmean_pct

esttab using summarystats.rtf, cells("mean(fmt(3)) min(fmt(3)) max(fmt(3)) sd(fmt(3)) count(fmt(0))") noobs nonumber label title("Summary statistics") replace



**** Main Models - Table 7.2

xtset subdistrict_id date

** Model 1

eststo: xtnbreg total_ind `controls' , re 

** Model 2 (Absolute Change From the Previuos Month)

eststo: xtnbreg total_ind `controls' dxmean, re 

** Model 3 (Absolute Change From the First Month- April 2012)

eststo: xtnbreg total_ind `controls' dxmean_2, re

** Model 4 (Change Rate From the First Month)

eststo: xtnbreg total_ind `controls' dxmean_pct, re

esttab using 1_main_RE_model.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial (RE) Models) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace

eststo clear


**** Testing for causality: Instrumental Variables


** First Stage Regression - Table 7.3

eststo: xtreg lag_mean lagdv3  sc_industrial_workers russian_intervention idpol_new_2 gcpv1 dum_subdistrict_oilgas log_pop_2004 road_density , re

esttab using 2_IV_First_Stage_model.rtf, b(3) p(3) aic scalars(ll) label title(First Stage IV Model) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace

eststo clear
 
predict double lagmean_hat , resid // predicting residuals



** Second Stage Regression - Table 7.4

eststo: xtnbreg total_ind  lagmean_hat  `controls'  , re // adding the residuals to the second stage equation





** Bootstrap to correct the standard errors in the Second Stage Regresion


 eststo: bootstrap, reps(100) seed(1234):xtnbreg total_ind  lagmean_hat  `controls'  , re
 
 esttab using 3_IV_Second_Stage_model.rtf, b(3) p(3) aic scalars(ll) label title(Second Stage IV Model) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace

 eststo clear

 
 

**** Robustnes Checks, Tables Appendix (7.5 - 7.10)

tab gov_id, gen(dumgov)


*** Fixed Effect Models - Table 7.5

** Model 
eststo: xtnbreg total_ind `controls' , fe 

** Model 
eststo: xtnbreg total_ind `controls' dxmean, fe 

** Model 
eststo: xtnbreg total_ind `controls' dxmean_2, fe

** Model 
eststo: xtnbreg total_ind `controls' dxmean_pct, fe

esttab using 1_main_FE_model.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial (FE) Models) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace

eststo clear


* Negative Binomial estimations with alternative thresholds for dependent variable 

* Table 7.6 : Threshold 5

** Model 
eststo: xtnbreg Total_above5 `controls' dxmean, re 
eststo: xtnbreg Total_above5 `controls' dxmean_2 , re
eststo: xtnbreg Total_above5 `controls' dxmean_pct, re
esttab using 1_model_above5.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial Models, Alternative Threshold for Dependent Variable (5)) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace
eststo clear

* Table 7.7 : Threshold 10

** Models 
eststo: xtnbreg Total_above10 `controls' dxmean, re 
eststo: xtnbreg Total_above10 `controls' dxmean_2, re
eststo: xtnbreg Total_above10 `controls' dxmean_pct, re
esttab using 1_model_above10.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial Models, Alternative Threshold for Dependent Variable (10)) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace
eststo clear

* Table 7.8 : Threshold 25

** Models 
eststo: xtnbreg Total_above25 `controls' dxmean, re 
eststo: xtnbreg Total_above25 `controls' dxmean_2, re
eststo: xtnbreg Total_above25 `controls' dxmean_pct, re
esttab using 1_model_above25.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial Models, Alternative Threshold for Dependent Variable (25)) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace
eststo clear

* Table 7.9 : Threshold 50

** Models 
eststo: xtnbreg Total_above50 `controls' dxmean, re 
eststo: xtnbreg Total_above50 `controls' dxmean_2, re
eststo: xtnbreg Total_above50 `controls' dxmean_pct, re
esttab using 1_model_above50.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial Models, Alternative Threshold for Dependent Variable (50)) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace
eststo clear


* Table 7.10  NB estimations without oil/gas producing governorates != 1

** Model 1
eststo: xtnbreg total_ind `controls' if dum_subdistrict_oilgas != 1, re 

** Model 2 
eststo: xtnbreg total_ind `controls' dxmean if dum_subdistrict_oilgas != 1, re 

** Model 3
eststo: xtnbreg total_ind `controls' dxmean_2 if dum_subdistrict_oilgas != 1, re

** Model 4 
eststo: xtnbreg total_ind `controls' dxmean_pct if dum_subdistrict_oilgas != 1, re

esttab using 1_robust_oilgas_model.rtf, b(3) p(3) aic scalars(ll) label title(Government Violence - Negative Binomial (RE) Models Control for oil and gas) nomtitles nodepvars  star(Ü 0.1 * 0.05 ** 0.01 *** 0.001) replace

eststo clear

