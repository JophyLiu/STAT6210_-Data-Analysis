dm 'log; clear; output; clear;';
options nodate nonumber;
ods rtf file='HW9B.doc';

/******************   HW9B  *********************/




/*
Run the Cox’s regression (proportional hazard model) analysis with both X and Z included
*/

proc phreg data=HW9B;
model Time*Status(1)=x z;
output out=Outp xbeta=xb resdev=dev; 
run;


/*
Perform a model diagnostics by comparing the deviance residuals vs. linear predictor scores

*/


goptions reset=all;
symbol i=none v=dot c=black; 
proc gplot data=Outp; 
plot dev*xb; 
run;








ods rtf close;
