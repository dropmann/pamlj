


TRANS_WARNS<-list()
TRANS_WARNS[[1]]<-list(original="end points not of opposite sign",new="Power parameters cannot be for the combination of input parameters")


common_init<-" <h1> Info </h1>
             <div>
             <p> Please select the aim of the analysis:</p>
             <ul>
             <li> <b> Calculate N</b> computes the required sample size given the <b> Target effect size</b> and <b> Minimum desire power</b>  </li>          
             <li> <b> Calculate Power</b> computes the achievable power given the <b> Target effect size</b> and <b> N (Sample size)</b>  </li>          
             <li> <b> Calculate Effect Size</b> computes the minimally-detectable effect size given the <b> N (Sample size)</b> and <b> Minimum desired power</b>  </li>          
             </ul>
              <p> In all cases, you can set the required Type I error rate (significance cut-off)</b>
             </div>
             "
INFO<-list()

INFO[["correlation"]] <- common_init
INFO[["glm"]]         <- common_init
INFO[["ttest"]]       <- common_init
INFO[["proportions"]] <- common_init

INFO[["factorial"]]<-" <h1> Info </h1>
             <div>
             <p> Please select the aim of the analysis:</p>
             <ul>
             <li> <b> Calculate N</b> computes the required sample size given the <b> Target effect size</b> and <b> Minimum desire power</b>  </li>          
             <li> <b> Calculate Power</b> computes the achievable power given the <b> Target effect size</b> and <b> N (Sample size)</b>  </li>          
             </ul>
              <p> In all cases, you can set the required Type I error rate (significance cut-off)</b>
             </div>
             "

INFO[["peta"]]<-"
             <div>
             <p> Set the <b> Model degrees of freedom</b>. 
              If the model degrees of freedom are not easy to compute, please use the 
             <b> Model definition </b> panel to help you out. <p>
             </div>
             "
INFO[["eta"]]<-"
             <div>
             <p> In all cases, set the expected <b> R-squared </b> for the full model. 
             For models with only one independent variable the R-squared is calculated
             as the square of the beta coefficients.<p>
             <p> Set the <b> Model degrees of freedom</b>. 
              If the model degrees of freedom are not easy to compute, please use the 
             <b> Model definition </b> panel to help you out. <p>
             </div>
              "

INFO[["beta"]]<-"
             <div>
             <p> Please notice that in case of multiple regression, the predictors are <b> assumed to be uncorrelated </b>. If correlated predictors
             are expected, please insert the correlations among covariates in the <b>Correlations panel </b> or use the <b>Partial Eta-squared</b> interface.</p>
             <p> In all cases, you can set the required Type I error rate and whether the test will be carried out two-tailed or one-tailed.</b></p>
             <p> In all cases, set the expected <b> R-squared </b> for the full model. 
             For models with only one independent variable the R-squared is calculated
             as the square of the beta coefficients.<p>
             <p> Set the <b> Model degrees of freedom</b>. 
              If the model degrees of freedom are not easy to compute, please use the 
             <b> Model definition </b> panel to help you out. <p>
             </div>
            "

INFO[["correlation"]]<-"
                   <div>
                   In all cases, you can also decide whether the test will be carried out two-tailed or one-tailed.
                   </div>
                   " 

INFO[["propind"]]<-"
                   <div>
                   In all cases, you can also decide whether the test will be carried out two-tailed or one-tailed.
                   </div>
                   <div>
                   The analysis is carried out based on binomial distribution and arcsine transformation.
                   </div>
                   <div>
                   The default effect size is the odd of the proportions in input (P1/(1-P1)/(P2/(1-P2)). In the <b> Options </b> panel
                   one can choose to use the proportion differences (P1-P2) or the relative risk (P1/P2). Results are equivalent.
                   </div>

                   " 
INFO[["propone"]]<-"
                   <div>
                   In all cases, you can also decide whether the test will be carried out two-tailed or one-tailed.
                   </div>
                   <div>
                   The analysis is carried out based on binomial distribution and arcsine transformation.
                   </div>
                   <div>
                   The default effect size is the odd of the proportion in input (P1/(1-P1)/(P2/(1-P2)). In the <b> Options </b> panel
                   one can choose to use the proportion differences (P1-P2) or the relative risk (P1/P2). Results are equivalent.
                   </div>

                   " 
INFO[["proppaired"]]<-"
                   <div>
                   In all cases, you can also decide whether the test will be carried out two-tailed or one-tailed.
                   </div>
                   <div>
                   The analysis is carried out based on  McNemar paired comparison of proportions approximate power calculation.
                   The default effect size is the odd of the proportion in input (P12/P21). P12 is the <b> smaller proportion
                   of discordant pairs </b> and P21 is the largest propotion of discordant pairs.
                   <div>
                   In the <b> Options </b> panel
                   one can choose to use the proportion differences (P12-P21). Results are equivalent.
                   </div>

                   " 


INFO[["facmeans"]]<-"
             <div>
             <p> Please list in the datasheet at least one <b>factor</b> and the data column containing the groups means and the group standard deviations.
                 If more than one factor is defined, the <b>means</b> and <b>standard deviations</b> should correspond to the means of the cells
                 resulting from the combinations of the factor levels.
              </p>
             </div>
             "

########### Greek Letters  ###############

greek_vector <- c( # lowercase Greek letters
  alpha='\u03b1', beta='\u03b2', gamma='\u03b3', delta='\u03b4', epsilon='\u03b5', zeta='\u03b6',
  eta='\u03b7', theta='\u03b8', iota='\u03b9', kappa='\u03ba', lambda='\u03bb', mu='\u03bc',
  nu='\u03bd', xi='\u03be', omicron='\u03bf', pi='\u03c0', rho='\u03c1', sigma='\u03c3', tau='\u03c4',
  upsilon='\u03c5', phi='\u03c6', chi='\u03c7', psi='\u03c8', omega='\u03c9',
  # uppercase Greek letters
  Alpha='\u0391', Beta='\u0392', Gamma='\u0393', Delta='\u0394', Epsilon='\u0395', Zeta='\u0396',
  Eta='\u0397', Theta='\u0398', Iota='\u0399', Kappa='\u039a', Lambda='\u039b', Mu='\u039c',
  Nu='\u039d', Xi='\u039e', Omicron='\u039f', Pi='\u03a0', Rho='\u03a1', Sigma='\u03a3', Tau='\u03a4',
  Upsilon='\u03a5', Phi='\u03a6', Chi='\u03a7', Psi='\u03a8', Omega='\u03a9',
  # mathematical symbols
  infinity ='\u221e', leftrightarrow ='\u21d4', forall='\u2200', exist ='\u2203', notexist ='\u2204',
  emptyset ='\u2205', elementof='\u2208', notelementof='\u2209', proportional='\u221d',
  asymptoticallyEqual='\u2243', notasymptoticallyEqual='\u2244', approxEqual='\u2245', almostEqual='\u2248',
  leq='\u2264', lt="\u003c",gt="\u003e", geq='\u2265', muchless='\u226a', muchgreater='\u226b', leftarrow='\u21d0', rightarrow='\u21d2',
  equal='\uff1d', notEqual='\u2260', integral='\u222b', doubleintegral='\u222c', tripleintegral='\u222d',
  logicalAnd='\u2227', logicalOr='\u2228', intersection='\u2229', union='\u222a')


letter_r2<-paste("R",'\u00B2',sep="")
letter_chi2<-paste(greek_vector["chi"],'\u00B2',sep="")
letter_eta2<-paste(greek_vector["eta"],'\u00B2',sep="")
letter_peta2<-paste("p",greek_vector["eta"],'\u00B2',sep="")
letter_omega2<-paste(greek_vector["omega"],'\u00B2',sep="")
letter_pomega2<-paste(greek_vector["omega"],'\u00B2',"p",sep="")
letter_epsilon2<-paste(greek_vector["epsilon"],'\u00B2',sep="")
letter_pepsilon2<-paste("p",greek_vector["epsilon"],'\u00B2',sep="")


##########################

