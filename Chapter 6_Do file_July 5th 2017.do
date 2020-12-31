*** Chapter 6 - Empirics II : Macro Level Test


* Descriptive Statistics

outreg2 using x.doc, replace sum(log)



* Correlations

*** Table 6.3: Pearson Correlation Matrix

mkcorr govbest uav cellphone_dum_1 internet_dum_1 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, replace log(mycorr.xls)  cdec(3)


*** Table 6.4: One-Sided Violence (Negative Binomial)


* Models

*** Model 1

nbreg govbest  uav lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB.doc, adds(" α ", e(alpha), "α SE", `se') replace eqdrop(lnalpha) ctitle(Model 1)

*** Model 2

nbreg govbest cellphone_dum_1 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha) append ctitle (Model 2)

*** Model 3

nbreg govbest internet_dum_1 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha)  append ctitle (Model 3)



* Substantive results ((Figures 6.2-6.4)

*** Negative Binomial Models



** Iv 1: UAV (Figure 6.2)

nbreg govbest  uav lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)

** My variable of interest is UAV.

*** Margins

margins, at (uav=(0/1)) atmeans

*** Marginsplot

marginsplot, level(95)

** Iv 2:  CPS (Figure 6.3)

nbreg govbest  cellphone_dum_1 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)

** My variable of interest is cellphone_dum_1.

*** Margins

margins, at (cellphone_dum_1=(0/1)) atmeans

*** Marginsplot

marginsplot, level(95)


** Iv 3: Internet Usage (Figure 6.4)

nbreg govbest  internet_dum_1 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)

** My variable of interest is UAV.

*** Margins

margins, at (internet_dum_1=(0/1)) atmeans

*** Marginsplot

marginsplot, level(95)

**** Robustness Checks


* Models (Table 6.6)

** Model 4

nbreg govbest  cellphone_dum_5 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se') replace eqdrop(lnalpha) ctitle(Model 4)

** Model 5

nbreg govbest cellphone_dum_10 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha) append ctitle (Model 5)

** Model 6

nbreg govbest cellphone_dum_20 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha)  append ctitle (Model 6)

** Model 7
nbreg govbest  cellphone_dum_50 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se') replace eqdrop(lnalpha) ctitle(Model 7)

** Model 8

nbreg govbest internet_dum_5 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha) append ctitle (Model 8)

** Model 9

nbreg govbest internet_dum_10 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha)  append ctitle (Model 9)

** Model 10

nbreg govbest internet_dum_20 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha) append ctitle (Model 10)

** Model 11

nbreg govbest internet_dum_50 lntotarea tcgovt demo_new  duration laglnpop intensity multireb lnpercapgdp  lnrebbest  laggovbest, cluster(side_a)
outreg2 using Table_NB_RC.doc, adds(" α ", e(alpha), "α SE", `se')  eqdrop(lnalpha)  append ctitle (Model 11)












