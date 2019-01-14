dm 'log; clear; output; clear;';
options nodate nonumber;
ods rtf file='HW9C.doc';

/******************   HW9C  *********************/

/*
Use the Cox’s regression to analyze this data set with a time-dependent covariate
Both X and Z included
Report hazard ratios and their confidence limits
*/

proc phreg data=HW9C;
  model (start,stop)*status(0)=x z / rl;
run;


/*
Use the Cox’s regression to perform a stratified analysis (based on X)
Z is the time-dependent covariate
Report the hazard ratio and its confidence limits
*/

proc phreg data=HW9C;
model (start,stop)*status(0)=x/ rl;
strata z;
baseline out=phout survival=sfest;    run;

symbol1 v=none i=join c=black;
symbol2 v=none i=join l=2 c=blue;
proc gplot data=phout;
plot sfest*stop=z;   run;





ods rtf close;
